# Work log

## Scanning
I have run via my WSL2, and scanned the redis image:
``` bash
grype db update
grype redis:7-bookworm
```
The scan results:
```
idomass@DESKTOP-UL3SLNM:~/projects/interviews_warmup/echo:$ grype redis:7-bookworm
 ✔ Vulnerability DB                [updated]
 ✔ Loaded image                                                                                      redis:7-bookworm
 ✔ Parsed image                               sha256:7ceda270a3137de18c0b3aff75fa0002faa1c2a87e2b25e86978a1c3f20b3b78
 ✔ Cataloged contents                                e6410661c78ce0f971d8202f910a58ad23cbe3bd76f3c4f131e630995eaa5a0d
   ├── ✔ Packages                        [93 packages]
   ├── ✔ Executables                     [704 executables]
   ├── ✔ File metadata                   [2,996 locations]
   └── ✔ File digests                    [2,996 files]
 ✔ Scanned for vulnerabilities     [237 vulnerability matches]
   ├── by severity: 12 critical, 68 high, 80 medium, 12 low, 55 negligible (10 unknown)
   └── by status:   94 fixed, 143 not-fixed, 0 ignored (1 dropped)
NAME                INSTALLED               FIXED IN                      TYPE       VULNERABILITY     SEVERITY    EPSS           RISK
stdlib              go1.18.2                1.20.10, 1.21.3               go-module  CVE-2023-44487    High        94.4% (99th)   78.8    KEV
stdlib              go1.18.2                1.21.9, 1.22.2                go-module  CVE-2023-45288    High        64.9% (98th)   48.6
stdlib              go1.18.2                1.21.10, 1.22.3               go-module  CVE-2024-24787    Medium      2.7% (85th)    1.5
stdlib              go1.18.2                1.21.8, 1.22.1                go-module  CVE-2024-24784    High        2.0% (83rd)    1.5
login               1:4.13+dfsg1-1+deb12u2  (won't fix)                   deb        CVE-2024-56433    Low         4.5% (89th)    1.5
passwd              1:4.13+dfsg1-1+deb12u2  (won't fix)                   deb        CVE-2024-56433    Low         4.5% (89th)    1.5
stdlib              go1.18.2                1.21.12, 1.22.5               go-module  CVE-2024-24791    High        1.0% (77th)    0.8
stdlib              go1.18.2                1.19.8, 1.20.3                go-module  CVE-2023-24538    Critical    0.8% (73rd)    0.7
stdlib              go1.18.2                1.21.8, 1.22.1                go-module  CVE-2024-24785    Medium      0.9% (76th)    0.5
stdlib              go1.18.2                1.21.0-0                      go-module  CVE-2023-24531    Critical    0.5% (65th)    0.5
stdlib              go1.18.2                1.21.8, 1.22.1                go-module  CVE-2024-24783    Medium      0.6% (69th)    0.3
stdlib              go1.18.2                1.19.10, 1.20.5               go-module  CVE-2023-29405    Critical    0.3% (55th)    0.3
stdlib              go1.18.2                1.21.8, 1.22.1                go-module  CVE-2023-45289    Medium      0.6% (69th)    0.3
stdlib              go1.18.2                1.21.8, 1.22.1                go-module  CVE-2023-45290    Medium      0.5% (65th)    0.3
stdlib              go1.18.2                1.19.9, 1.20.4                go-module  CVE-2023-24540    Critical    0.2% (47th)    0.2
stdlib              go1.18.2                1.22.7, 1.23.1                go-module  CVE-2024-34156    High        0.3% (53rd)    0.2
stdlib              go1.18.2                1.19.6                        go-module  CVE-2022-41723    High        0.3% (49th)    0.2
stdlib              go1.18.2                1.19.11, 1.20.6               go-module  CVE-2023-29406    Medium      0.3% (56th)    0.2
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2011-3389     Negligible  3.9% (88th)    0.2
dpkg                1.21.22                 (won't fix)                   deb        CVE-2025-6297     High        0.2% (48th)    0.2
tar                 1.34+dfsg-1.2+deb12u1                                 deb        CVE-2005-2541     Negligible  3.8% (88th)    0.2
stdlib              go1.18.2                1.18.9, 1.19.4                go-module  CVE-2022-41717    Medium      0.3% (55th)    0.2
stdlib              go1.18.2                1.21.11, 1.22.4               go-module  CVE-2024-24790    Critical    0.2% (38th)    0.2
stdlib              go1.18.2                1.20.0                        go-module  CVE-2023-45287    High        0.2% (39th)    0.1
stdlib              go1.18.2                1.22.7, 1.23.1                go-module  CVE-2024-34158    High        0.2% (36th)    0.1
stdlib              go1.18.2                1.19.8, 1.20.3                go-module  CVE-2023-24534    High        0.2% (36th)    0.1
stdlib              go1.18.2                1.19.10, 1.20.5               go-module  CVE-2023-29402    Critical    0.1% (31st)    0.1
stdlib              go1.18.2                1.23.8, 1.24.2                go-module  CVE-2025-22871    Critical    0.1% (31st)    0.1
stdlib              go1.18.2                1.18.6                        go-module  CVE-2022-27664    High        0.1% (32nd)    < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-30635    High        0.1% (29th)    < 0.1
stdlib              go1.18.2                1.17.13, 1.18.5               go-module  CVE-2022-32189    High        0.1% (29th)    < 0.1
stdlib              go1.18.2                1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45336    Medium      0.1% (34th)    < 0.1
stdlib              go1.18.2                1.19.10, 1.20.5               go-module  CVE-2023-29404    Critical    < 0.1% (24th)  < 0.1
apt                 2.6.1                                                 deb        CVE-2011-3374     Negligible  1.5% (81st)    < 0.1
libapt-pkg6.0       2.6.1                                                 deb        CVE-2011-3374     Negligible  1.5% (81st)    < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2018-20796    Negligible  1.5% (81st)    < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2018-20796    Negligible  1.5% (81st)    < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-30632    High        < 0.1% (26th)  < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-30633    High        < 0.1% (26th)  < 0.1
stdlib              go1.18.2                1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45341    Medium      0.1% (30th)    < 0.1
stdlib              go1.18.2                1.20.12, 1.21.5               go-module  CVE-2023-39326    Medium      0.1% (31st)    < 0.1
stdlib              go1.18.2                1.19.12, 1.20.7               go-module  CVE-2023-29409    Medium      0.1% (29th)    < 0.1
stdlib              go1.18.2                1.19.8, 1.20.3                go-module  CVE-2023-24536    High        < 0.1% (21st)  < 0.1
bsdutils            1:2.38.1-5+deb12u3      (won't fix)                   deb        CVE-2026-3184     Medium      0.1% (27th)    < 0.1
libblkid1           2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-3184     Medium      0.1% (27th)    < 0.1
libmount1           2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-3184     Medium      0.1% (27th)    < 0.1
libsmartcols1       2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-3184     Medium      0.1% (27th)    < 0.1
libuuid1            2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-3184     Medium      0.1% (27th)    < 0.1
mount               2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-3184     Medium      0.1% (27th)    < 0.1
util-linux          2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-3184     Medium      0.1% (27th)    < 0.1
util-linux-extra    2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-3184     Medium      0.1% (27th)    < 0.1
libc-bin            2.36-9+deb12u13         (won't fix)                   deb        CVE-2025-15281    High        < 0.1% (21st)  < 0.1
libc6               2.36-9+deb12u13         (won't fix)                   deb        CVE-2025-15281    High        < 0.1% (21st)  < 0.1
libc-bin            2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-4437     High        < 0.1% (20th)  < 0.1
libc6               2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-4437     High        < 0.1% (20th)  < 0.1
stdlib              go1.18.2                1.19.9, 1.20.4                go-module  CVE-2023-24539    High        < 0.1% (20th)  < 0.1
stdlib              go1.18.2                1.19.6                        go-module  CVE-2022-41725    High        < 0.1% (19th)  < 0.1
stdlib              go1.18.2                1.20.8, 1.21.1                go-module  CVE-2023-39318    Medium      < 0.1% (24th)  < 0.1
stdlib              go1.18.2                1.20.8, 1.21.1                go-module  CVE-2023-39319    Medium      < 0.1% (24th)  < 0.1
stdlib              go1.18.2                1.20.9, 1.21.2                go-module  CVE-2023-39323    High        < 0.1% (18th)  < 0.1
libtasn1-6          4.19.0-2+deb12u1        (won't fix)                   deb        CVE-2025-13151    High        < 0.1% (19th)  < 0.1
libc-bin            2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-5450     Critical    < 0.1% (15th)  < 0.1
libc6               2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-5450     Critical    < 0.1% (15th)  < 0.1
stdlib              go1.18.2                1.17.11, 1.18.3               go-module  CVE-2022-30580    High        < 0.1% (18th)  < 0.1
stdlib              go1.18.2                1.23.10, 1.24.4               go-module  CVE-2025-4673     Medium      < 0.1% (22nd)  < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2019-1010025  Negligible  0.8% (74th)    < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2019-1010025  Negligible  0.8% (74th)    < 0.1
stdlib              go1.18.2                1.20.12, 1.21.5               go-module  CVE-2023-45285    High        < 0.1% (16th)  < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2019-9192     Negligible  0.8% (73rd)    < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2019-9192     Negligible  0.8% (73rd)    < 0.1
stdlib              go1.18.2                1.25.8, 1.26.1                go-module  CVE-2026-25679    High        < 0.1% (15th)  < 0.1
stdlib              go1.18.2                1.22.7, 1.23.1                go-module  CVE-2024-34155    Medium      < 0.1% (23rd)  < 0.1
libc-bin            2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-4046     High        < 0.1% (14th)  < 0.1
libc6               2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-4046     High        < 0.1% (14th)  < 0.1
stdlib              go1.18.2                1.19.9, 1.20.4                go-module  CVE-2023-29400    High        < 0.1% (14th)  < 0.1
libtinfo6           6.4-4                   (won't fix)                   deb        CVE-2025-6141     Medium      < 0.1% (21st)  < 0.1
ncurses-base        6.4-4                   (won't fix)                   deb        CVE-2025-6141     Medium      < 0.1% (21st)  < 0.1
ncurses-bin         6.4-4                   (won't fix)                   deb        CVE-2025-6141     Medium      < 0.1% (21st)  < 0.1
libc-bin            2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-5928     High        < 0.1% (13th)  < 0.1
libc6               2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-5928     High        < 0.1% (13th)  < 0.1
libgcrypt20         1.10.1-3                                              deb        CVE-2024-2236     Negligible  0.7% (71st)    < 0.1
perl-base           5.36.0-7+deb12u3                                      deb        CVE-2023-31486    Negligible  0.7% (71st)    < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-32148    Medium      < 0.1% (17th)  < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2019-1010024  Negligible  0.6% (70th)    < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2019-1010024  Negligible  0.6% (70th)    < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-30631    High        < 0.1% (12th)  < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-1705     Medium      < 0.1% (16th)  < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-61725    High        < 0.1% (12th)  < 0.1
libtinfo6           6.4-4                   (won't fix)                   deb        CVE-2023-50495    Medium      < 0.1% (15th)  < 0.1
ncurses-base        6.4-4                   (won't fix)                   deb        CVE-2023-50495    Medium      < 0.1% (15th)  < 0.1
ncurses-bin         6.4-4                   (won't fix)                   deb        CVE-2023-50495    Medium      < 0.1% (15th)  < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-61723    High        < 0.1% (11th)  < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-30630    High        < 0.1% (11th)  < 0.1
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-33845    High        < 0.1% (11th)  < 0.1
liblzma5            5.4.1-1                 (won't fix)                   deb        CVE-2026-34743    Medium      < 0.1% (17th)  < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2026-5435     High        < 0.1% (10th)  < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2026-5435     High        < 0.1% (10th)  < 0.1
redis               7.4.8                                                 binary     CVE-2025-49112    Low         < 0.1% (24th)  < 0.1
libgcrypt20         1.10.1-3                                              deb        CVE-2018-6829     Negligible  0.5% (66th)    < 0.1
stdlib              go1.18.2                1.24.12, 1.25.6               go-module  CVE-2025-61726    High        < 0.1% (9th)   < 0.1
coreutils           9.1-1                   (won't fix)                   deb        CVE-2016-2781     Low         < 0.1% (24th)  < 0.1
libc-bin            2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-4438     Medium      < 0.1% (13th)  < 0.1
libc6               2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-4438     Medium      < 0.1% (13th)  < 0.1
libsystemd0         252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-40225    Medium      < 0.1% (12th)  < 0.1
libudev1            252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-40225    Medium      < 0.1% (12th)  < 0.1
stdlib              go1.18.2                1.18.7, 1.19.2                go-module  CVE-2022-2880     High        < 0.1% (8th)   < 0.1
gpgv                2.2.40-1.1+deb12u2      (won't fix)                   deb        CVE-2025-30258    Medium      < 0.1% (14th)  < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2026-6238     Medium      < 0.1% (10th)  < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2026-6238     Medium      < 0.1% (10th)  < 0.1
libpam-modules      1.5.2-6+deb12u2         (won't fix)                   deb        CVE-2024-10041    Medium      < 0.1% (13th)  < 0.1
libpam-modules-bin  1.5.2-6+deb12u2         (won't fix)                   deb        CVE-2024-10041    Medium      < 0.1% (13th)  < 0.1
libpam-runtime      1.5.2-6+deb12u2         (won't fix)                   deb        CVE-2024-10041    Medium      < 0.1% (13th)  < 0.1
libpam0g            1.5.2-6+deb12u2         (won't fix)                   deb        CVE-2024-10041    Medium      < 0.1% (13th)  < 0.1
stdlib              go1.18.2                1.17.11, 1.18.3               go-module  CVE-2022-30629    Low         < 0.1% (20th)  < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2010-4756     Negligible  0.4% (60th)    < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2010-4756     Negligible  0.4% (60th)    < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-58186    Medium      < 0.1% (11th)  < 0.1
stdlib              go1.18.2                1.23.12, 1.24.6               go-module  CVE-2025-47906    Medium      < 0.1% (8th)   < 0.1
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-3833     Medium      < 0.1% (8th)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-27143    Critical    < 0.1% (4th)   < 0.1
stdlib              go1.18.2                1.24.13, 1.25.7, 1.26.0-rc.3  go-module  CVE-2025-68121    Critical    < 0.1% (4th)   < 0.1
login               1:4.13+dfsg1-1+deb12u2                                deb        CVE-2007-5686     Negligible  0.3% (55th)    < 0.1
passwd              1:4.13+dfsg1-1+deb12u2                                deb        CVE-2007-5686     Negligible  0.3% (55th)    < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-58185    Medium      < 0.1% (8th)   < 0.1
libc-bin            2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-0915     High        < 0.1% (5th)   < 0.1
libc6               2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-0915     High        < 0.1% (5th)   < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2019-1010023  Negligible  0.3% (53rd)    < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2019-1010023  Negligible  0.3% (53rd)    < 0.1
redis               7.4.8                                                 binary     CVE-2025-46686    Low         < 0.1% (14th)  < 0.1
stdlib              go1.18.2                1.19.6                        go-module  CVE-2022-41724    High        < 0.1% (5th)   < 0.1
dpkg                1.21.22                 (won't fix)                   deb        CVE-2026-2219     High        < 0.1% (5th)   < 0.1
tar                 1.34+dfsg-1.2+deb12u1   (won't fix)                   deb        CVE-2026-5704     Medium      < 0.1% (7th)   < 0.1
stdlib              go1.18.2                1.24.9, 1.25.3                go-module  CVE-2025-58187    High        < 0.1% (4th)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-32281    High        < 0.1% (4th)   < 0.1
stdlib              go1.18.2                1.19.7, 1.20.2                go-module  CVE-2023-24532    Medium      < 0.1% (7th)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-32280    High        < 0.1% (4th)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-32283    High        < 0.1% (4th)   < 0.1
stdlib              go1.18.2                1.23.12, 1.24.6               go-module  CVE-2025-47907    High        < 0.1% (4th)   < 0.1
stdlib              go1.18.2                1.18.7, 1.19.2                go-module  CVE-2022-41715    High        < 0.1% (3rd)   < 0.1
stdlib              go1.18.2                1.19.8, 1.20.3                go-module  CVE-2023-24537    High        < 0.1% (3rd)   < 0.1
stdlib              go1.18.2                1.18.7, 1.19.2                go-module  CVE-2022-2879     High        < 0.1% (3rd)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-27140    High        < 0.1% (2nd)   < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-47912    Medium      < 0.1% (6th)   < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-28131    High        < 0.1% (3rd)   < 0.1
libssl3             3.0.19-1~deb12u2                                      deb        CVE-2025-27587    Negligible  0.2% (44th)    < 0.1
stdlib              go1.18.2                1.24.12, 1.25.6               go-module  CVE-2025-61728    Medium      < 0.1% (5th)   < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-61724    Medium      < 0.1% (5th)   < 0.1
libsystemd0         252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-29111    Medium      < 0.1% (5th)   < 0.1
libudev1            252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-29111    Medium      < 0.1% (5th)   < 0.1
perl-base           5.36.0-7+deb12u3                                      deb        CVE-2011-4116     Negligible  0.2% (41st)    < 0.1
stdlib              go1.18.2                1.22.12, 1.23.6, 1.24.0-rc.3  go-module  CVE-2025-22866    Medium      < 0.1% (6th)   < 0.1
stdlib              go1.18.2                1.24.11, 1.25.5               go-module  CVE-2025-61729    High        < 0.1% (1st)   < 0.1
libgcrypt20         1.10.1-3                                              deb        CVE-2026-41989    Medium      < 0.1% (3rd)   < 0.1
libsystemd0         252.39-1~deb12u1                                      deb        CVE-2023-31437    Negligible  0.2% (37th)    < 0.1
libudev1            252.39-1~deb12u1                                      deb        CVE-2023-31437    Negligible  0.2% (37th)    < 0.1
libtinfo6           6.4-4                   (won't fix)                   deb        CVE-2025-69720    High        < 0.1% (1st)   < 0.1
ncurses-base        6.4-4                   (won't fix)                   deb        CVE-2025-69720    High        < 0.1% (1st)   < 0.1
ncurses-bin         6.4-4                   (won't fix)                   deb        CVE-2025-69720    High        < 0.1% (1st)   < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-58189    Medium      < 0.1% (3rd)   < 0.1
libc-bin            2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-0861     High        < 0.1% (1st)   < 0.1
libc6               2.36-9+deb12u13         (won't fix)                   deb        CVE-2026-0861     High        < 0.1% (1st)   < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-58183    Medium      < 0.1% (4th)   < 0.1
stdlib              go1.18.2                1.24.12, 1.25.6               go-module  CVE-2025-61731    High        < 0.1% (1st)   < 0.1
stdlib              go1.18.2                1.19.10, 1.20.5               go-module  CVE-2023-29403    High        < 0.1% (1st)   < 0.1
bsdutils            1:2.38.1-5+deb12u3      (won't fix)                   deb        CVE-2026-27456    Medium      < 0.1% (3rd)   < 0.1
libblkid1           2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-27456    Medium      < 0.1% (3rd)   < 0.1
libmount1           2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-27456    Medium      < 0.1% (3rd)   < 0.1
libsmartcols1       2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-27456    Medium      < 0.1% (3rd)   < 0.1
libuuid1            2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-27456    Medium      < 0.1% (3rd)   < 0.1
mount               2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-27456    Medium      < 0.1% (3rd)   < 0.1
util-linux          2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-27456    Medium      < 0.1% (3rd)   < 0.1
util-linux-extra    2.38.1-5+deb12u3        (won't fix)                   deb        CVE-2026-27456    Medium      < 0.1% (3rd)   < 0.1
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-3832     Low         < 0.1% (5th)   < 0.1
libsystemd0         252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-4105     Medium      < 0.1% (1st)   < 0.1
libudev1            252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-4105     Medium      < 0.1% (1st)   < 0.1
stdlib              go1.18.2                1.24.8, 1.25.2                go-module  CVE-2025-58188    High        < 0.1% (0th)   < 0.1
libsystemd0         252.39-1~deb12u1                                      deb        CVE-2023-31438    Negligible  0.1% (32nd)    < 0.1
libudev1            252.39-1~deb12u1                                      deb        CVE-2023-31438    Negligible  0.1% (32nd)    < 0.1
libcap2             1:2.66-4+deb12u2+b2     (won't fix)                   deb        CVE-2026-4878     High        < 0.1% (0th)   < 0.1
coreutils           9.1-1                                                 deb        CVE-2025-5278     Negligible  0.1% (32nd)    < 0.1
libc-bin            2.36-9+deb12u13                                       deb        CVE-2019-1010022  Negligible  0.1% (31st)    < 0.1
libc6               2.36-9+deb12u13                                       deb        CVE-2019-1010022  Negligible  0.1% (31st)    < 0.1
libsystemd0         252.39-1~deb12u1                                      deb        CVE-2023-31439    Negligible  0.1% (31st)    < 0.1
libudev1            252.39-1~deb12u1                                      deb        CVE-2023-31439    Negligible  0.1% (31st)    < 0.1
stdlib              go1.18.2                1.25.8, 1.26.1                go-module  CVE-2026-27142    Medium      < 0.1% (1st)   < 0.1
stdlib              go1.18.2                1.24.13, 1.25.7               go-module  CVE-2025-61732    High        < 0.1% (0th)   < 0.1
stdlib              go1.18.2                1.23.11, 1.24.5               go-module  CVE-2025-4674     High        < 0.1% (0th)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-32289    Medium      < 0.1% (1st)   < 0.1
libsystemd0         252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-40226    Medium      < 0.1% (0th)   < 0.1
libudev1            252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-40226    Medium      < 0.1% (0th)   < 0.1
zlib1g              1:1.2.13.dfsg-1         (won't fix)                   deb        CVE-2026-27171    Medium      < 0.1% (0th)   < 0.1
stdlib              go1.18.2                1.24.12, 1.25.6               go-module  CVE-2025-61730    Medium      < 0.1% (0th)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-32282    Medium      < 0.1% (0th)   < 0.1
libsystemd0         252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-40228    Low         < 0.1% (2nd)   < 0.1
libudev1            252.39-1~deb12u1        (won't fix)                   deb        CVE-2026-40228    Low         < 0.1% (2nd)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-27144    High        < 0.1% (0th)   < 0.1
stdlib              go1.18.2                1.21.11, 1.22.4               go-module  CVE-2024-24789    Medium      < 0.1% (0th)   < 0.1
stdlib              go1.18.2                1.24.11, 1.25.5               go-module  CVE-2025-61727    Medium      < 0.1% (0th)   < 0.1
coreutils           9.1-1                                                 deb        CVE-2017-18018    Negligible  < 0.1% (17th)  < 0.1
stdlib              go1.18.2                1.17.12, 1.18.4               go-module  CVE-2022-1962     Medium      < 0.1% (0th)   < 0.1
gcc-12-base         12.2.0-14+deb12u1                                     deb        CVE-2022-27943    Negligible  < 0.1% (15th)  < 0.1
libgcc-s1           12.2.0-14+deb12u1                                     deb        CVE-2022-27943    Negligible  < 0.1% (15th)  < 0.1
libstdc++6          12.2.0-14+deb12u1                                     deb        CVE-2022-27943    Negligible  < 0.1% (15th)  < 0.1
gpgv                2.2.40-1.1+deb12u2      (won't fix)                   deb        CVE-2025-68972    Medium      < 0.1% (0th)   < 0.1
stdlib              go1.18.2                1.25.8, 1.26.1                go-module  CVE-2026-27139    Low         < 0.1% (0th)   < 0.1
stdlib              go1.18.2                1.25.9, 1.26.2                go-module  CVE-2026-32288    Medium      < 0.1% (0th)   < 0.1
libsystemd0         252.39-1~deb12u1                                      deb        CVE-2013-4392     Negligible  < 0.1% (12th)  < 0.1
libudev1            252.39-1~deb12u1                                      deb        CVE-2013-4392     Negligible  < 0.1% (12th)  < 0.1
sed                 4.9-1                   (won't fix)                   deb        CVE-2026-5958     Low         < 0.1% (0th)   < 0.1
bsdutils            1:2.38.1-5+deb12u3                                    deb        CVE-2022-0563     Negligible  < 0.1% (7th)   < 0.1
libblkid1           2.38.1-5+deb12u3                                      deb        CVE-2022-0563     Negligible  < 0.1% (7th)   < 0.1
libmount1           2.38.1-5+deb12u3                                      deb        CVE-2022-0563     Negligible  < 0.1% (7th)   < 0.1
libsmartcols1       2.38.1-5+deb12u3                                      deb        CVE-2022-0563     Negligible  < 0.1% (7th)   < 0.1
libuuid1            2.38.1-5+deb12u3                                      deb        CVE-2022-0563     Negligible  < 0.1% (7th)   < 0.1
mount               2.38.1-5+deb12u3                                      deb        CVE-2022-0563     Negligible  < 0.1% (7th)   < 0.1
util-linux          2.38.1-5+deb12u3                                      deb        CVE-2022-0563     Negligible  < 0.1% (7th)   < 0.1
util-linux-extra    2.38.1-5+deb12u3                                      deb        CVE-2022-0563     Negligible  < 0.1% (7th)   < 0.1
stdlib              go1.18.2                1.23.9, 1.24.3                go-module  CVE-2025-22873    Low         < 0.1% (0th)   < 0.1
gpgv                2.2.40-1.1+deb12u2                                    deb        CVE-2022-3219     Negligible  < 0.1% (3rd)   < 0.1
bsdutils            1:2.38.1-5+deb12u3                                    deb        CVE-2025-14104    Negligible  < 0.1% (0th)   < 0.1
libblkid1           2.38.1-5+deb12u3                                      deb        CVE-2025-14104    Negligible  < 0.1% (0th)   < 0.1
libmount1           2.38.1-5+deb12u3                                      deb        CVE-2025-14104    Negligible  < 0.1% (0th)   < 0.1
libsmartcols1       2.38.1-5+deb12u3                                      deb        CVE-2025-14104    Negligible  < 0.1% (0th)   < 0.1
libuuid1            2.38.1-5+deb12u3                                      deb        CVE-2025-14104    Negligible  < 0.1% (0th)   < 0.1
mount               2.38.1-5+deb12u3                                      deb        CVE-2025-14104    Negligible  < 0.1% (0th)   < 0.1
util-linux          2.38.1-5+deb12u3                                      deb        CVE-2025-14104    Negligible  < 0.1% (0th)   < 0.1
util-linux-extra    2.38.1-5+deb12u3                                      deb        CVE-2025-14104    Negligible  < 0.1% (0th)   < 0.1
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-33846    Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-42009    Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-42010    Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-42011    Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-42012    Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-42013    Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-42014    Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-42015    Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-5260     Unknown     N/A            N/A
libgnutls30         3.7.9-2+deb12u6                                       deb        CVE-2026-5419     Unknown     N/A            N/A
A newer version of grype is available for download: 0.112.0 (installed version is 0.111.1)
```
### 237 vulnerabilites
The results were: 12 critical, 68 high, 80 medium, 12 low, 55 negligible, 10 unknown

## Profiling
First, before fixing, I want to define what is a "working" redis docker is.
Ill use tests before, and after redacting the image to make sure I don't break compatiblity.

I want to "record" the action of the container, and understand which assets it truly needs.
I will be able to reconstruct a "whitelist" of libraris and files with this approach.

Then, ill cross the profile and scan results - and understand what can be fixed and how.

### Maximising coverage
Reading online, I have discovered there are different tools to test redis, each one with different functionalities.
I will go for a layered approach, using different tools to maximise coverage.

I have let an claude code to implement this test stack described in tests/test-plan.md for me.
I chatted about potential test with both claude and gemini, for making sure I get the right coverage.

## Solving the vulnerabilities
### Strategy
We need to fix vulnarbilities usually by RISK, which is a parameters used to predict vulnerability likelihood to be exploited (EPSS) combined with severity.

And if by any point we have a chance to remove a lot of vulnerabilites with one blow, we should go for it right on to reduce the size of the task.

### Method 0: docker-slim
I have discovered that slim is a tool that does exactly what I described, recording usage of a container assets, then building a redacted image - amazing.

But learning about this feature, which can work well if I implement tests first - I searched for "slim" versions already existing, and learned about `redis:7-alpine`

### Method 1: Alternative OS layer
Switching to `redis:7-alpine` was an easy solution, reducing the number of vulnerabilities signficantly.
When checking about a "slim" version of `bookwork` image, I found out about `alpine`.

| | `redis:7-bookworm` | `redis:7-alpine` | Δ |
|---|---|---|---|
| **Total findings** | 237 | 4 | −138 |
| **Critical** | 12 | 10 | −2 |
| **High** | 68 | 46 | −22 |
| **Medium** | 80 | 38 | −42 |
| **Low** | 12 | 5 | −7 |
| **Negligible** | 55 | 0 | −55 |
| **Won't fix** | 143 | 5 | −138 |
| **Image size** | 175 MB | 61 MB | −114 MB |

#### musl vs glibc
This is the main reason so many vulnerabilties were removed.
musl is the secured variant of glibc, and a smaller one.

Less code, less vulnerabilities.

#### Rescanning
Rescanning left us with 99 vulnerabilities:

```
idomass@DESKTOP-UL3SLNM:~/projects/interviews_warmup/echo:$ grype redis:7-alpine
 ✔ Loaded image                                                                                                                                                    redis:7-alpine
 ✔ Parsed image                                                                                           sha256:9210b8dc25f122eb00e5572dcc7147c8e11fb1a08308b088e06c9d5dd2aa49d6
 ✔ Cataloged contents                                                                                            5fe0bf5f8b97a1954128ed3c46757a1c1b0f45fd2919735ed14a631a650e1132
   ├── ✔ Packages                        [21 packages]
   ├── ✔ Executables                     [21 executables]
   ├── ✔ File metadata                   [429 locations]
   └── ✔ File digests                    [429 files]
 ✔ Scanned for vulnerabilities     [99 vulnerability matches]
   ├── by severity: 10 critical, 46 high, 38 medium, 5 low, 0 negligible
   └── by status:   94 fixed, 5 not-fixed, 0 ignored
NAME           INSTALLED   FIXED IN                      TYPE       VULNERABILITY   SEVERITY  EPSS           RISK
stdlib         go1.18.2    1.20.10, 1.21.3               go-module  CVE-2023-44487  High      94.4% (99th)   78.8    KEV
stdlib         go1.18.2    1.21.9, 1.22.2                go-module  CVE-2023-45288  High      64.9% (98th)   48.6
stdlib         go1.18.2    1.21.10, 1.22.3               go-module  CVE-2024-24787  Medium    2.7% (85th)    1.5
stdlib         go1.18.2    1.21.8, 1.22.1                go-module  CVE-2024-24784  High      2.0% (83rd)    1.5
stdlib         go1.18.2    1.21.12, 1.22.5               go-module  CVE-2024-24791  High      1.0% (77th)    0.8
stdlib         go1.18.2    1.19.8, 1.20.3                go-module  CVE-2023-24538  Critical  0.8% (73rd)    0.7
stdlib         go1.18.2    1.21.8, 1.22.1                go-module  CVE-2024-24785  Medium    0.9% (76th)    0.5
stdlib         go1.18.2    1.21.0-0                      go-module  CVE-2023-24531  Critical  0.5% (65th)    0.5
stdlib         go1.18.2    1.21.8, 1.22.1                go-module  CVE-2024-24783  Medium    0.6% (69th)    0.3
stdlib         go1.18.2    1.19.10, 1.20.5               go-module  CVE-2023-29405  Critical  0.3% (55th)    0.3
stdlib         go1.18.2    1.21.8, 1.22.1                go-module  CVE-2023-45289  Medium    0.6% (69th)    0.3
stdlib         go1.18.2    1.21.8, 1.22.1                go-module  CVE-2023-45290  Medium    0.5% (65th)    0.3
stdlib         go1.18.2    1.19.9, 1.20.4                go-module  CVE-2023-24540  Critical  0.2% (47th)    0.2
stdlib         go1.18.2    1.22.7, 1.23.1                go-module  CVE-2024-34156  High      0.3% (53rd)    0.2
stdlib         go1.18.2    1.19.6                        go-module  CVE-2022-41723  High      0.3% (49th)    0.2
stdlib         go1.18.2    1.19.11, 1.20.6               go-module  CVE-2023-29406  Medium    0.3% (56th)    0.2
stdlib         go1.18.2    1.18.9, 1.19.4                go-module  CVE-2022-41717  Medium    0.3% (55th)    0.2
stdlib         go1.18.2    1.21.11, 1.22.4               go-module  CVE-2024-24790  Critical  0.2% (38th)    0.2
stdlib         go1.18.2    1.20.0                        go-module  CVE-2023-45287  High      0.2% (39th)    0.1
stdlib         go1.18.2    1.22.7, 1.23.1                go-module  CVE-2024-34158  High      0.2% (36th)    0.1
stdlib         go1.18.2    1.19.8, 1.20.3                go-module  CVE-2023-24534  High      0.2% (36th)    0.1
stdlib         go1.18.2    1.19.10, 1.20.5               go-module  CVE-2023-29402  Critical  0.1% (31st)    0.1
stdlib         go1.18.2    1.23.8, 1.24.2                go-module  CVE-2025-22871  Critical  0.1% (31st)    0.1
stdlib         go1.18.2    1.18.6                        go-module  CVE-2022-27664  High      0.1% (32nd)    < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-30635  High      0.1% (29th)    < 0.1
stdlib         go1.18.2    1.17.13, 1.18.5               go-module  CVE-2022-32189  High      0.1% (29th)    < 0.1
stdlib         go1.18.2    1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45336  Medium    0.1% (34th)    < 0.1
stdlib         go1.18.2    1.19.10, 1.20.5               go-module  CVE-2023-29404  Critical  < 0.1% (24th)  < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-30632  High      < 0.1% (26th)  < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-30633  High      < 0.1% (26th)  < 0.1
stdlib         go1.18.2    1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45341  Medium    0.1% (30th)    < 0.1
stdlib         go1.18.2    1.20.12, 1.21.5               go-module  CVE-2023-39326  Medium    0.1% (31st)    < 0.1
stdlib         go1.18.2    1.19.12, 1.20.7               go-module  CVE-2023-29409  Medium    0.1% (29th)    < 0.1
stdlib         go1.18.2    1.19.8, 1.20.3                go-module  CVE-2023-24536  High      < 0.1% (21st)  < 0.1
stdlib         go1.18.2    1.19.9, 1.20.4                go-module  CVE-2023-24539  High      < 0.1% (20th)  < 0.1
stdlib         go1.18.2    1.19.6                        go-module  CVE-2022-41725  High      < 0.1% (19th)  < 0.1
stdlib         go1.18.2    1.20.8, 1.21.1                go-module  CVE-2023-39318  Medium    < 0.1% (24th)  < 0.1
stdlib         go1.18.2    1.20.8, 1.21.1                go-module  CVE-2023-39319  Medium    < 0.1% (24th)  < 0.1
stdlib         go1.18.2    1.20.9, 1.21.2                go-module  CVE-2023-39323  High      < 0.1% (18th)  < 0.1
stdlib         go1.18.2    1.17.11, 1.18.3               go-module  CVE-2022-30580  High      < 0.1% (18th)  < 0.1
stdlib         go1.18.2    1.23.10, 1.24.4               go-module  CVE-2025-4673   Medium    < 0.1% (22nd)  < 0.1
stdlib         go1.18.2    1.20.12, 1.21.5               go-module  CVE-2023-45285  High      < 0.1% (16th)  < 0.1
stdlib         go1.18.2    1.25.8, 1.26.1                go-module  CVE-2026-25679  High      < 0.1% (15th)  < 0.1
stdlib         go1.18.2    1.22.7, 1.23.1                go-module  CVE-2024-34155  Medium    < 0.1% (23rd)  < 0.1
stdlib         go1.18.2    1.19.9, 1.20.4                go-module  CVE-2023-29400  High      < 0.1% (14th)  < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-32148  Medium    < 0.1% (17th)  < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-30631  High      < 0.1% (12th)  < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-1705   Medium    < 0.1% (16th)  < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-61725  High      < 0.1% (12th)  < 0.1
busybox        1.37.0-r14                                apk        CVE-2025-60876  Medium    < 0.1% (15th)  < 0.1
busybox-binsh  1.37.0-r14                                apk        CVE-2025-60876  Medium    < 0.1% (15th)  < 0.1
ssl_client     1.37.0-r14                                apk        CVE-2025-60876  Medium    < 0.1% (15th)  < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-61723  High      < 0.1% (11th)  < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-30630  High      < 0.1% (11th)  < 0.1
redis          7.4.8                                     binary     CVE-2025-49112  Low       < 0.1% (24th)  < 0.1
stdlib         go1.18.2    1.24.12, 1.25.6               go-module  CVE-2025-61726  High      < 0.1% (9th)   < 0.1
stdlib         go1.18.2    1.18.7, 1.19.2                go-module  CVE-2022-2880   High      < 0.1% (8th)   < 0.1
stdlib         go1.18.2    1.17.11, 1.18.3               go-module  CVE-2022-30629  Low       < 0.1% (20th)  < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-58186  Medium    < 0.1% (11th)  < 0.1
stdlib         go1.18.2    1.23.12, 1.24.6               go-module  CVE-2025-47906  Medium    < 0.1% (8th)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-27143  Critical  < 0.1% (4th)   < 0.1
stdlib         go1.18.2    1.24.13, 1.25.7, 1.26.0-rc.3  go-module  CVE-2025-68121  Critical  < 0.1% (4th)   < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-58185  Medium    < 0.1% (8th)   < 0.1
redis          7.4.8                                     binary     CVE-2025-46686  Low       < 0.1% (14th)  < 0.1
stdlib         go1.18.2    1.19.6                        go-module  CVE-2022-41724  High      < 0.1% (5th)   < 0.1
stdlib         go1.18.2    1.24.9, 1.25.3                go-module  CVE-2025-58187  High      < 0.1% (4th)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-32281  High      < 0.1% (4th)   < 0.1
stdlib         go1.18.2    1.19.7, 1.20.2                go-module  CVE-2023-24532  Medium    < 0.1% (7th)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-32280  High      < 0.1% (4th)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-32283  High      < 0.1% (4th)   < 0.1
stdlib         go1.18.2    1.23.12, 1.24.6               go-module  CVE-2025-47907  High      < 0.1% (4th)   < 0.1
stdlib         go1.18.2    1.18.7, 1.19.2                go-module  CVE-2022-41715  High      < 0.1% (3rd)   < 0.1
stdlib         go1.18.2    1.19.8, 1.20.3                go-module  CVE-2023-24537  High      < 0.1% (3rd)   < 0.1
stdlib         go1.18.2    1.18.7, 1.19.2                go-module  CVE-2022-2879   High      < 0.1% (3rd)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-27140  High      < 0.1% (2nd)   < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-47912  Medium    < 0.1% (6th)   < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-28131  High      < 0.1% (3rd)   < 0.1
stdlib         go1.18.2    1.24.12, 1.25.6               go-module  CVE-2025-61728  Medium    < 0.1% (5th)   < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-61724  Medium    < 0.1% (5th)   < 0.1
stdlib         go1.18.2    1.22.12, 1.23.6, 1.24.0-rc.3  go-module  CVE-2025-22866  Medium    < 0.1% (6th)   < 0.1
stdlib         go1.18.2    1.24.11, 1.25.5               go-module  CVE-2025-61729  High      < 0.1% (1st)   < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-58189  Medium    < 0.1% (3rd)   < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-58183  Medium    < 0.1% (4th)   < 0.1
stdlib         go1.18.2    1.24.12, 1.25.6               go-module  CVE-2025-61731  High      < 0.1% (1st)   < 0.1
stdlib         go1.18.2    1.19.10, 1.20.5               go-module  CVE-2023-29403  High      < 0.1% (1st)   < 0.1
stdlib         go1.18.2    1.24.8, 1.25.2                go-module  CVE-2025-58188  High      < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.25.8, 1.26.1                go-module  CVE-2026-27142  Medium    < 0.1% (1st)   < 0.1
stdlib         go1.18.2    1.24.13, 1.25.7               go-module  CVE-2025-61732  High      < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.23.11, 1.24.5               go-module  CVE-2025-4674   High      < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-32289  Medium    < 0.1% (1st)   < 0.1
stdlib         go1.18.2    1.24.12, 1.25.6               go-module  CVE-2025-61730  Medium    < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-32282  Medium    < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-27144  High      < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.21.11, 1.22.4               go-module  CVE-2024-24789  Medium    < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.24.11, 1.25.5               go-module  CVE-2025-61727  Medium    < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.17.12, 1.18.4               go-module  CVE-2022-1962   Medium    < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.25.8, 1.26.1                go-module  CVE-2026-27139  Low       < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.25.9, 1.26.2                go-module  CVE-2026-32288  Medium    < 0.1% (0th)   < 0.1
stdlib         go1.18.2    1.23.9, 1.24.3                go-module  CVE-2025-22873  Low       < 0.1% (0th)   < 0.1
```

Most of them has a single source: `go1.18.2`.

### GO 1.18.2 Problem
In the vulnerability report, it seems like `go1.18.2` is responsible for 94/99 vulnerabilities in the container, including the most dangerous ones.

It is from June 2022, pretty old.

Scanning who uses that library led to:
```bash
idomass@DESKTOP-UL3SLNM:~/projects/interviews_warmup/echo:$ docker run --rm --entrypoint sh redis:7-alpine -c '
  for f in $(find / -type f -executable -size +50k 2>/dev/null); do
    ver=$(grep -aoE "go1\.[0-9]+(\.[0-9]+)?" "$f" 2>/dev/null | sort -u | head -1)
    [ -n "$ver" ] && echo "$ver  $f"
  done'
go1.18.2  /usr/local/bin/gosu
```

Only `guso` binary uses that old library.
And there is exactly one user for `guso`, it's `docker-entrypoint.sh` :
``` bash
#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
        set -- redis-server "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
        find . \! -user redis -exec chown redis '{}' +
        exec gosu redis "$0" "$@"
fi

# set an appropriate umask (if one isn't set already)
# - https://github.com/docker-library/redis/issues/305
# - https://github.com/redis/redis/blob/bb875603fb7ff3f9d19aad906bd45d7db98d9a39/utils/systemd-redis_server.service#L37
um="$(umask)"
if [ "$um" = '0022' ]; then
        umask 0077
fi

exec "$@"
```

Looking at this code, `gosu` is used only if the container is started as `root`, then changes user back to `redis` user.


#### Method 2: Updating `gosu`
| | `gosu` in `redis:7-alpine` (current) | `gosu` 1.19 (latest, Sept 2025) |
|---|---|---|
| Built with Go | 1.18.2 (June 2022) | 1.24.6 (Aug 2025) |
| Binary size | 2.3 MB | 1.7 MB |
| Total findings | 94 | **30** |
| Critical | several | 2 |
| High | dozens | 14 |
| Medium | dozens | 13 |
| Low | few | 1 |

Updating from the bundled `gosu` (Go 1.18.2) to the latest release (Go 1.24.6) cuts the `gosu` finding count by roughly two thirds to 30 from 94, but **not to zero** — and it never will. The Go team releases security patches every 2–4 weeks, while the `gosu` maintainer cuts a release every 6–18 months. The embedded Go runtime is always lagging current, so grype will always match recent stdlib CVEs against it. Updating `gosu` is a moving target that needs periodic re-attention.

#### Method 3: Rebuilding `gosu` with newer library
This leads to similir results to updating `gosu`, but removes dependency on waiting for `gosu` developers to deploy updated versions.

It has obvious downsides of owning `gosu` build process - but will make a more resilient system overall.

#### Method 4: Replacing `gosu` with `su-exec`
`su-exec` is a safer alternative for `gosu`, with a low vulnerabillity history and smaller.

#### [Choosen] Method 5: Removing `gosu`
This has the risk of breaking compatability, even though it is a small change.

In order to make this work, I had to `chown` the data directory, and force the docker into using user `redis`

### Making it 0
Even though the tasks requires using 2 different methods, and reducing vulnerabilities by 10 - I want to make it 0.
Let's talk about those potential last miles.

#### BusyBox vulnerabilities
This was added with changing to the alpine image, since alpine containers are built upon `BusyBox`.

##### CVE-2025-60876

#### Redis vulnerabilities
##### CVE-2025-49112

##### CVE-2025-46686
