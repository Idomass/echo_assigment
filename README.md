# Echo assignment
## Summary & Analysis
| | `redis:7-bookworm` | `redis:7-bookworm-secured` | Δ |
|---|---|---|---|
| **Total findings** | 237 | 4 | -233 |
| **Critical** | 12 | 2 | −10 |
| **High** | 68 | 0 | −68 |
| **Medium** | 80 | 0 | −80 |
| **Low** | 12 | 2 | −10 |
| **Negligible** | 55 | 0 | −55 |
| **Won't fix** | 143 | 0 | −143 |
| **Image size** | 175 MB | 42.5MB MB | -132.5 MB |

The 2 new critical vulnerabilities are highly likely to be false-positives raised after the docker-slim process.

## Validating Functionality
Testing was implemented using a combination of claude code + gemini.
See `test-plan.md` for testing strategy.

## Vulnerability report
94 Go-stdlib CVEs eliminated by gosu removal, and branch fixing in `docker-entrypoint.sh`.

For a full vulnerability report, before and after, look at `reports/` folder.
For the remaining risks, see `Residual Risk Assessment`.

## Cleaning the image
For a full version and unimplemented methods - see both `log.md` and `log2.md`.

### Method 0: Using `docker-slim`
This is the nuclear option, aiming to get a "perfect" result regarding removing vulnerable components.
This method is costly considering implementation, because it needs a almost-perfect simulation of the container user.

I made it run with redis tests, but missed the "administrative" paths that might include logging in, changing permissions manually and installing other packages.

### Method 5: Skipping a branch and removing `gosu`
`gosu` is used in the `docker-entrypoint.sh` to change from root to redis.
By enforcing `USER "redis"` in the Dockerfile, this branch never reaches, and `gosu` can be removed, since there is no other users to it.

In order to make this work, I had to `chown` the data directory, and force the docker into using user `redis`.

## Challenges and lessons learned
### Maximilist approach breaks stuff
Container usage extends beyond the binary it wraps, and missing this was a major oversight on my part doing this exercise.
I attempted to complete it with a maximilist approach ("Everything that is unused can be purged"), but my definition of a "working container" was minimized to "redis is working and containerized".

Next time, it's better to consider patching and rebuilding.

### Dealing with unknown system - `redis`
Before the challenge, I only knew `redis` by name and high-level functionality.
I found making the tests much harder than hardening the image, probably because defensive lines of thinking are easier for me.
Understanding which tests I should run, and what `redis` is, was a main challenge for me - and in the era of AI it is important to differentiate actual information from hallucinations.

Testing was especially difficult - since it's hard to map what a "working" state for a product I don't know is.
I experimented with AI implementation, but honestly still not satisfied with the results and further work is required.

## Residual Risk Assessment
### Broken functionalities
As mentioned in the bullet above, I broke the container while keeping `redis` functioning.
This can be managed with adding an extra layer to the docker slim prcoess, named "admin_tests", that records the admin usage of the container.

### Remaining vulnerabilities
After Methods 0 and 5, 4 findings remain — 2 are scanner false-positives, 2 are real Redis upstream issues (both Low, EPSS <0.1%):

| # | Package | CVE | Severity | EPSS | Source / Note |
|---|---|---|---|---|---|
| 1| redis |  7.4.8 |      binary  | CVE-2022-0543 |   Critical  94.4% (99th) |   99.8   (kev)  |
| 2| redis |  7.4.8 |      binary |  CVE-2022-3734  | Critical  0.5% (65th)    0.4
| 3 | `redis` 7.4.8 | CVE-2025-49112 | Low | <0.1% | Redis upstream |
| 4 | `redis` 7.4.8 | CVE-2025-46686 | Low | <0.1% | Redis upstream |

### Fixes and workarounds
The remaining vulnerabilities are low RISK, but no fixes found by grype for them.

**CVE-2025-49112 / CVE-2025-46686 (Redis 7.4.8)**
Should build from source the redis code with a custom fixes.
Both of these vulnerabilities are in redis source code, and weren't fixed yet.
