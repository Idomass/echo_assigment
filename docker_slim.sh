#!/usr/bin/env bash
# Record a slim image of redis:7-bookworm-tmp.
#
# Strategy:
#   1. `slim build --continue-after signal` keeps recording until we send SIGUSR1.
#   2. slim's --exec runs *inside* the recorded container, so it just calls
#      redis-cli / redis-benchmark directly — that captures their library loads
#      so slim keeps them in the slim image (without that, Layer 3 of
#      run_tests.sh breaks with "redis-benchmark: not found").
#   3. Once redis is up, this script drives the redis-py functional suite from
#      the host against the published port — exercises redis-server code paths
#      slim must keep.
#   4. After pytest, we send SIGUSR1 to slim and it finalizes the slim image.

set -uo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
TARGET=redis:7-bookworm-tmp
SLIMMED=redis:7-bookworm-secured
PORT=6379

REDISPY_DIR="${REDISPY_DIR:-/tmp/redis-py}"
# Pin redis-py to the latest 5.0.x — matches Redis 7.x and avoids redis-8 /
# Redis-Stack tests (FT.*, JSON.*, BF.*, HOTKEYS, DELEX, XNACK, BITOP DIFF, …)
# that produce ~80 spurious failures against redis 7.4.
REDISPY_TAG="${REDISPY_TAG:-v5.0.9}"
VENV="${VENV:-$SCRIPT_DIR/.venv}"

# ── prep host-side test deps ─────────────────────────────────────────────────
if [ -d "$REDISPY_DIR/.git" ] && \
   ! git -C "$REDISPY_DIR" describe --tags --exact-match 2>/dev/null | grep -qx "$REDISPY_TAG"; then
    rm -rf "$REDISPY_DIR"
fi
[ -d "$REDISPY_DIR" ] || git clone --depth 1 --branch "$REDISPY_TAG" \
    https://github.com/redis/redis-py "$REDISPY_DIR"
[ -x "$VENV/bin/python" ] || python3 -m venv "$VENV"
# shellcheck disable=SC1091
source "$VENV/bin/activate"
python -m pip install -q "$REDISPY_DIR[dev]"

# ── start slim recording in the background ───────────────────────────────────
slim build \
  --target "$TARGET" \
  --tag "$SLIMMED" \
  --http-probe=false \
  --publish-port "${PORT}:6379" \
  --include-shell \
  --include-bin /usr/local/bin/redis-cli \
  --include-bin /usr/local/bin/redis-benchmark \
  --include-path /data \
  --include-path /etc/os-release \
  --include-path /var/lib/dpkg/status \
  --continue-after signal \
  --exec '
    until redis-cli -p 6379 ping 2>/dev/null | grep -q PONG; do sleep 0.2; done
    redis-benchmark -p 6379 -q -n 10000 \
      -t ping,set,get,incr,lpush,rpush,lpop,rpop,sadd,hset,zadd,mset
    # exercise persistence so slim keeps /data + RDB write paths.
    # SAVE is synchronous, so no poll needed; dataset is small after the bench.
    redis-cli -p 6379 SAVE
    redis-cli -p 6379 BGREWRITEAOF
    sleep 1
  ' &
SLIM_PID=$!
trap 'kill -USR1 "$SLIM_PID" 2>/dev/null || true' EXIT

# ── wait for redis to actually answer PING ───────────────────────────────────
# A bare TCP connect succeeds against docker's userland-proxy before redis-server
# is up inside the container, then the first real read gets RST → flood of
# "Connection reset by peer" errors in pytest. Probe at the RESP layer instead.
echo "waiting for redis to PONG on 127.0.0.1:${PORT}..."
for _ in $(seq 120); do
    if printf 'PING\r\n' | nc -w 1 127.0.0.1 "$PORT" 2>/dev/null | grep -q PONG; then
        echo "redis is up"
        break
    fi
    sleep 0.5
    kill -0 "$SLIM_PID" 2>/dev/null || { echo "slim exited unexpectedly"; exit 1; }
done

# ── drive pytest from this host (NOT inside the container) ───────────────────
# -k skips tests that need a 2nd redis on :6479 (modules) or a replica on :6380
pytest -q --tb=short \
    "$REDISPY_DIR/tests/test_commands.py" \
    "$REDISPY_DIR/tests/test_pipeline.py" \
    "$REDISPY_DIR/tests/test_connection.py" \
    "$REDISPY_DIR/tests/test_connection_pool.py" \
    "$REDISPY_DIR/tests/test_pubsub.py" \
    "$REDISPY_DIR/tests/test_scripting.py" \
    "$REDISPY_DIR/tests/test_encoding.py" \
    "$REDISPY_DIR/tests/test_lock.py" \
    "$REDISPY_DIR/tests/test_monitor.py" \
    -k "not test_module and not test_psync and not test_replica" \
    --redis-url="redis://127.0.0.1:${PORT}/0" \
  || echo "pytest had failures — continuing to finalize the slim image anyway"

# ── stop recording, slim finalizes the image ─────────────────────────────────
echo "signalling slim to finalize..."
kill -USR1 "$SLIM_PID"
trap - EXIT
wait "$SLIM_PID"

# ── post-fix: restore /data ownership ────────────────────────────────────────
# slim drops empty dirs and doesn't preserve directory ownership. WORKDIR /data
# auto-creates the dir as root:root on rebuild, so the redis user (uid 999)
# can't write RDB/AOF files there → BGSAVE fails → MISCONF blocks all writes.
# Overlay /data from the secured source image with correct ownership.
echo "fixing /data ownership in slim image..."
docker build -t "$SLIMMED" - <<EOF
FROM $TARGET AS srcdata
FROM $SLIMMED
COPY --from=srcdata --chown=redis:redis /data /data
EOF

echo "slim image: $SLIMMED"
docker images "$SLIMMED" --format 'size: {{.Size}}'
