# CRAN submission aroma.core 3.3.0

on 2022-11-11

I've verified this submission has no negative impact on any of the
six reverse package dependencies available on CRAN (n=5) and
Bioconductor (n=1).

Thank you


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version | GitHub | R-hub  | mac/win-builder |
| --------- | ------ | ------ | --------------- |
| 3.4.x     | .      |        |                 |
| 3.6.x     | .      |        |                 |
| 4.0.x     | .      |        |                 |
| 4.1.x     | L      |        |                 |
| 4.2.x     | L . .  | L   W  | .  W            |
| devel     | L . .  | L      |    W            |

_Legend: OS: L = Linux, S = Solaris, M = macOS, M1 = macOS M1, W = Windows_

Comments:

 * macbuilder does not support Bioconductor dependencies
 
 * GitHub macOS checks fail due to DNAcopy installation issues, i.e.
   `Error in dyn.load(file, DLLpath = DLLpath, ...) : unable to load
   shared object
   '/Users/runner/work/_temp/Library/DNAcopy/libs/DNAcopy.so':
   dlopen(/Users/runner/work/_temp/Library/DNAcopy/libs/DNAcopy.so,
   0x0006): Symbol not found: (__gfortran_os_error_at)`
   
 * GitHub MS Windows checks fail due to an 'sfit' issue,
   cf. <https://github.com/HenrikBengtsson/sfit/issues/7>

 * GitHub Linux older R version: Skipped to conserve GitHub credits
 

R-hub checks:

```r
res <- rhub::check(platforms = c(
  "debian-clang-devel", 
  "debian-gcc-patched", 
  "fedora-gcc-devel",
  "macos-highsierra-release-cran",
  "windows-x86_64-release"
))
print(res)
```

gives

```
── aroma.core 3.3.0: NOTE

  Build ID:   aroma.core_3.3.0.tar.gz-f8db413876b44baabea935bfb150b4a4
  Platform:   Debian Linux, R-devel, clang, ISO-8859-15 locale
  Submitted:  6h 39m 7.4s ago
  Build time: 1h 27m 8.1s

❯ checking package dependencies ... NOTE
  Packages suggested but not available for checking: 'EBImage', 'GLAD'

❯ checking Rd cross-references ... NOTE
  Package unavailable to check Rd xrefs: 'GLAD'

0 errors ✔ | 0 warnings ✔ | 2 notes ✖

── aroma.core 3.3.0: NOTE

  Build ID:   aroma.core_3.3.0.tar.gz-4dc7b49a4575400793f962c0b39cfcc1
  Platform:   Debian Linux, R-patched, GCC
  Submitted:  6h 39m 7.4s ago
  Build time: 1h 30m 8.1s

❯ checking package dependencies ... NOTE
  Packages suggested but not available for checking: 'EBImage', 'GLAD'

❯ checking Rd cross-references ... NOTE
  Package unavailable to check Rd xrefs: 'GLAD'


── aroma.core 3.3.0: NOTE

  Build ID:   aroma.core_3.3.0.tar.gz-b14fbf5a6d1245089bd560b64304fdd7
  Platform:   Fedora Linux, R-devel, GCC
  Submitted:  6h 39m 7.4s ago
  Build time: 58m 52.1s

❯ checking package dependencies ... NOTE
  Packages suggested but not available for checking: 'EBImage', 'GLAD'

❯ checking Rd cross-references ... NOTE
  Package unavailable to check Rd xrefs: ‘GLAD’

0 errors ✔ | 0 warnings ✔ | 2 notes ✖

── aroma.core 3.3.0: ERROR

  Build ID:   aroma.core_3.3.0.tar.gz-19bef8d0e8d947879e33fb72c607d014
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  6h 39m 7.5s ago
  Build time: 3m 19.4s

❯ checking package dependencies ... ERROR
  Package suggested but not available: ‘EBImage’
  
  The suggested packages are required for a complete check.
  Checking can be attempted without them by setting the environment
  variable _R_CHECK_FORCE_SUGGESTS_ to a false value.
  
  See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
  manual.

1 error ✖ | 0 warnings ✔ | 0 notes ✔

── aroma.core 3.3.0: NOTE

  Build ID:   aroma.core_3.3.0.tar.gz-b1d4a5dcecff4494ae438756be585c0b
  Platform:   Windows Server 2022, R-release, 32/64 bit
  Submitted:  6h 39m 7.5s ago
  Build time: 6m 37.1s

❯ checking package dependencies ... NOTE
  

0 errors ✔ | 0 warnings ✔ | 1 note ✖
```
