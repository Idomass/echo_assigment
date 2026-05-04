#!/usr/bin/env bash
# Layered test runner — mirrors test-plan.md
#
# Usage: ./tests/run_tests.sh [base-image] [secured-image]
# Default: redis:7-bookworm  vs  redis:7-bookworm-secured

set -uo pipefail

BASE="${1:-redis:7-bookworm}"
SECURED="${2:-redis:7-bookworm-secured}"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_DIR=$(cd -- "$SCRIPT_DIR/.." && pwd)
RESULTS_DIR="$SCRIPT_DIR/results"
mkdir -p "$RESULTS_DIR"

# Use a venv so pip and python share the same interpreter (redis-py needs 3.10+).
VENV="$REPO_DIR/.venv"
if [ ! -x "$VENV/bin/python" ]; then
    if command -v uv &>/dev/null; then
        uv venv --python 3.13 "$VENV"
    else
        python3 -m venv "$VENV"
    fi
fi
# shellcheck disable=SC1091
source "$VENV/bin/activate"

FAILED=0
step()  { printf '\n=== %s ===\n' "$*"; }
pass()  { printf '\033[32mPASS\033[0m  %s\n' "$*"; }
fail()  { printf '\033[31mFAIL\033[0m  %s\n' "$*"; FAILED=1; }

# ── helpers ──────────────────────────────────────────────────────────────────

ensure_dgoss() {
    command -v dgoss &>/dev/null && return 0
    local ver="0.4.0" dir="/tmp/goss-bin"
    mkdir -p "$dir"
    echo "  downloading goss $ver..."
    curl -fsSL "https://github.com/goss-org/goss/releases/download/v${ver}/goss-linux-amd64" \
         -o "$dir/goss" && chmod +x "$dir/goss"
    curl -fsSL "https://github.com/goss-org/goss/releases/download/v${ver}/dgoss" \
         -o "$dir/dgoss" && chmod +x "$dir/dgoss"
    export PATH="$dir:$PATH"
    export GOSS_PATH="$dir/goss"
}

wait_ready() {
    local cid=$1
    for _ in $(seq 15); do
        docker exec "$cid" redis-cli ping 2>/dev/null | grep -q PONG && return 0
        sleep 1
    done
    echo "container $cid never became ready" >&2
    return 1
}

bench() {
    local image=$1 out=$2 cid
    cid=$(docker run -d --rm "$image")
    wait_ready "$cid"
    docker exec "$cid" redis-benchmark -q -n 10000 \
        -t ping,set,get,incr,lpush,rpush,lpop,rpop,sadd,hset,zadd,mset \
        | tee "$out"
    docker rm -f "$cid" >/dev/null 2>&1 || true
}

# ── Layer 1: structural (dgoss) ───────────────────────────────────────────────

step "Layer 1: structural tests (dgoss) — $SECURED"
ensure_dgoss
export GOSS_FILES_PATH="$SCRIPT_DIR"
if dgoss run "$SECURED" >"$RESULTS_DIR/dgoss.txt" 2>&1; then
    pass "Layer 1"
else
    fail "Layer 1"
fi
cat "$RESULTS_DIR/dgoss.txt"

# ── Layer 2: functional (redis-py test suite) ────────────────────────────────

step "Layer 2: functional tests (redis-py) — $BASE vs $SECURED"

REDISPY_DIR="/tmp/redis-py"
# Pin redis-py to the latest 5.0.x — matches Redis 7.x and drops the redis-8
# / Redis-Stack tests (FT.*, JSON.*, BF.*, HOTKEYS, DELEX, XNACK, BITOP DIFF, …)
# that would otherwise produce ~80 spurious failures against redis 7.4.
REDISPY_TAG="v5.0.9"
if [ -d "$REDISPY_DIR/.git" ] && \
   ! git -C "$REDISPY_DIR" describe --tags --exact-match 2>/dev/null | grep -qx "$REDISPY_TAG"; then
    rm -rf "$REDISPY_DIR"
fi
if [ ! -d "$REDISPY_DIR" ]; then
    git clone --depth 1 --branch "$REDISPY_TAG" https://github.com/redis/redis-py "$REDISPY_DIR"
fi
python -m pip install "$REDISPY_DIR[dev]" -q

L2_PASS=true
for image in "$BASE" "$SECURED"; do
    echo "Testing image: $image"
    tag="${image##*:}"
    cid=$(docker run -d --rm -p 0:6379 "$image")
    wait_ready "$cid"
    port=$(docker inspect "$cid" --format '{{(index (index .NetworkSettings.Ports "6379/tcp") 0).HostPort}}')
    # -k skips tests that need a 2nd redis on :6479 (modules) or a replica on :6380
    if ! python -m pytest -vv \
            "$REDISPY_DIR/tests/test_commands.py" \
            "$REDISPY_DIR/tests/test_pipeline.py" \
            "$REDISPY_DIR/tests/test_connection.py" \
            "$REDISPY_DIR/tests/test_connection_pool.py" \
            "$REDISPY_DIR/tests/test_pubsub.py" \
            "$REDISPY_DIR/tests/test_scripting.py" \
            "$REDISPY_DIR/tests/test_encoding.py" \
            "$REDISPY_DIR/tests/test_lock.py" \
            "$REDISPY_DIR/tests/test_monitor.py" \
            "$REDISPY_DIR/tests/test_retry.py" \
            "$REDISPY_DIR/tests/test_multiprocessing.py" \
            -k "not test_module and not test_psync and not test_replica" \
            --redis-url="redis://127.0.0.1:${port}/0" \
            -q --tb=short 2>&1 | tee "$RESULTS_DIR/pytest-${tag}.txt"; then
        L2_PASS=false
    fi
    docker rm -f "$cid" >/dev/null 2>&1 || true
done

if $L2_PASS; then pass "Layer 2"; else fail "Layer 2"; fi

# ── Layer 3: benchmark (logged, not gated) ───────────────────────────────────

step "Layer 3: benchmark — $BASE"
bench "$BASE" "$RESULTS_DIR/bench-base.txt"

step "Layer 3: benchmark — $SECURED"
bench "$SECURED" "$RESULTS_DIR/bench-secured.txt"

pass "Layer 3 (results logged to $RESULTS_DIR/bench-*.txt, not gated)"

# ── Summary ──────────────────────────────────────────────────────────────────

step "Summary"
printf '  %-30s %s\n' "$BASE"    "$(docker images --format '{{.Size}}' "$BASE"    | head -1)"
printf '  %-30s %s\n' "$SECURED" "$(docker images --format '{{.Size}}' "$SECURED" | head -1)"

if [ "$FAILED" -eq 0 ]; then
    echo "ALL LAYERS PASSED"
else
    echo "SOME LAYERS FAILED — see output above"
    exit 1
fi
