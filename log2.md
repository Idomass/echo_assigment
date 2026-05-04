# Work Log
## Switching base layer is not allowed
Oh well, guess I cheated.
Ill look again at the vulnerability report, and attempt to fix 10+ CVEs again.

I feel like the docker-slim solution is still strong, but now I am unsure if the task requires me to keep the docker environment "working", or just `redis` binary working.

## Removing `gosu`
Still allowed, we are down one method and removed the same 94 CVEs.

### Rescanning
Running:
``` bash
(.venv) idomass@DESKTOP-UL3SLNM:~/projects/interviews_warmup/echo:(master)$ awk 'NR>1 {print $3}' /home/idomass/projects
/interviews_warmup/echo/reports/bookworm-secured | sort | uniq -c | sort -rn
     73 deb
     68 (won't
      2 binary
```

Shows that most vulnerabilities remain from debian packages, and because of that I will remain focused on fixing the environment.

## Back to Method 0: docker-slim
Docker slim is still a viable option, and that's what led me to going to alpine in the first place.

Since the tests are defining what is the "working state" for the container, I can keep updating them as the definition changes and keep a slim action possible.

Running docker_slim.sh, then grype, led to an image sized 42.4MB and with only 4 vulnerabilities:
```bash
NAME   INSTALLED  TYPE    VULNERABILITY   SEVERITY  EPSS           RISK
redis  7.4.8      binary  CVE-2022-0543   Critical  94.4% (99th)   99.8    KEV
redis  7.4.8      binary  CVE-2022-3734   Critical  0.5% (65th)    0.4
redis  7.4.8      binary  CVE-2025-49112  Low       < 0.1% (24th)  < 0.1
redis  7.4.8      binary  CVE-2025-46686  Low       < 0.1% (14th)  < 0.1
```

But somehow a new cve appeared? WTF.
Apparently it has to do something with the fact that "distro context" files were removed via the slimming process.

### I removed too much
I have realized that my "working properly" definition mainly discussed the redis binary, and did not consider the "user" of the container, that might want to connect, and some operations with the files, install packages, debug it dynamically.
In short, I overdid it, admin functions are broken.

###
