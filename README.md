# Echo assignment
## Summary & Analysis
| | `redis:7-bookworm` | `redis:7-alpine-secured` | Δ |
|---|---|---|---|
| **Image size** | 175 MB | 41.4 MB | -133.6 MB |
| **Vulnerabilities** | 237 | 5 | −232 |

## Validating Functionality
Testing was implemented using a combination of claude code + gemini.
See `test-plan.md` for testing strategy.

## Vulnerability report
138 Debian-only CVEs eliminated by base swap; 94 Go-stdlib CVEs eliminated by gosu removal.

For a full report, look at `reports/` folder.
For the remaining risks, see `Residual Risk Assessment`

## Cleaning the image
For a full version and unimplemented methods - see `log.md`.

### Method 1: Alternative OS layer
Switching to `redis:7-alpine` was an easy solution, reducing the number of vulnerabilities significantly.
When checking about a "slim" version of `bookworm` image, I found out about `alpine`.

| | `redis:7-bookworm` | `redis:7-alpine` | Δ |
|---|---|---|---|
| **Total findings** | 237 | 99 | −138 (−58%) |
| **Critical** | 12 | 10 | −2 |
| **High** | 68 | 46 | −22 |
| **Medium** | 80 | 38 | −42 |
| **Low** | 12 | 5 | −7 |
| **Negligible** | 55 | 0 | −55 |
| **Won't fix** | 143 | 5 | −138 |
| **Image size** | 175 MB | 61 MB | −114 MB (−65%) |

#### musl vs glibc
This is the main reason so many vulnerabilities were removed.
musl is the secured variant of glibc, and a smaller one.

Less code, less vulnerabilities.

#### Potential downside
Performance, shell and DNS sequencing are part of the changes I read online about.
In this challenge I chose the `alpine` container since the goal is to reduce surface - but in real world applications these changes might be a dealbreaker and should be considered thoroughly.

### Rescanning
Left us with 99 vulnerabilities, 94 sourced in `gosu` Go 1.18.2 library.

### Method 5: Removing `gosu`
This has the risk of breaking compatibility, even though it is a small change.

In order to make this work, I had to `chown` the data directory, and force the docker into using user `redis`.

## Challenges and lessons learned
### Unknown product - `redis`
Before the challenge, I only knew `redis` by name and high-level functionality.
I found making the tests much harder than hardening the image, probably because defensive lines of thinking are easier for me.
Understanding which tests I should run, and what `redis` is, was a main challenge for me - and in the era of AI it is important to differentiate actual information from hallucinations.

Testing was especially difficult - since it's hard to map what a "working" state for a product I don't know is.
I experimented with AI implementation, but honestly still not satisfied with the results and further work is required.

### Architecture is stronger than specific mitigations
Starting the mission, my mind ran with possible solutions for each CVE: patching, rebuilding and other "heavy-lifting" solutions for hardening the image.

But instead of rebuilding everything, I discovered the `alpine` variation of `redis` - which already does 90% of the work for me.

This reminded me that architectural solutions (such as changing the base layer) are usually much stronger than patches or specific mitigations.

## Residual Risk Assessment
### Remaining vulnerabilities
After Methods 1 and 5, 5 findings remain — all very low EPSS (<0.1%):

| # | Package(s) | CVE | Severity | EPSS | Source |
|---|---|---|---|---|---|
| 1 | `busybox`, `busybox-binsh`, `ssl_client` (1.37.0-r14) | CVE-2025-60876 | Medium | <0.1% | Alpine base (BusyBox) |
| 2 | `redis` 7.4.8 | CVE-2025-49112 | Low | <0.1% | Redis upstream |
| 3 | `redis` 7.4.8 | CVE-2025-46686 | Low | <0.1% | Redis upstream |

This leaves us with 3 distinct CVEs.

### Fixes and workarounds
The remaining vulnerabilities are low RISK, but no fixes found by grype for them.

**CVE-2025-60876 (BusyBox)**
Wasn't fixed in upstream yet, but is probably unreachable because `redis` doesn't invoke `wget` which is required for this exploitation.

**CVE-2025-49112 / CVE-2025-46686 (Redis 7.4.8)**
Should build from source the redis code and bundle to a custom container.
Will remove `alpine` dependence, but will add maintence burden.

### Prioritized fix order
Ranked by my own assesment:

1. **CVE-2025-49112 / CVE-2025-46686** - High payoff for building redis from source.
2. **CVE-2025-60876** - Not exploitable in current configuration
