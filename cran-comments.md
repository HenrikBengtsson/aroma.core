# CRAN submission aroma.core 3.3.0

on 2022-11-10

I've verified this submission have no negative impact on any of the 5 reverse package dependencies available on CRAN.

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
── aroma.core 3.3.0: ERROR

  Build ID:   aroma.core_3.3.0.tar.gz-75ec5c6049c046108ed82975096b66e7
  Platform:   Debian Linux, R-devel, clang, ISO-8859-15 locale
  Submitted:  1h 21m 58.4s ago
  Build time: 1h 21m 30.1s

❯ checking examples ... ERROR
  Running examples in 'aroma.core-Ex.R' failed
  The error most likely occurred in:
  
  > ### Name: segmentByMPCBS.RawGenomicSignals
  > ### Title: Segment copy numbers using the multi-platform CBS (mpCBS) method
  > ### Aliases: segmentByMPCBS.RawGenomicSignals
  > ###   RawGenomicSignals.segmentByMPCBS
  > ###   segmentByMPCBS,RawGenomicSignals-method
  > ### Keywords: internal methods IO
  > 
  > ### ** Examples
  > 
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > # Simulating copy-number data from multiple platforms
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > # Piecewise-constant copy-number state function
  > cnState <- function(x, ...) {
  +   n <- length(x)
  +   mu <- double(n)
  +   mu[20e6 <= x & x <= 30e6] <- +1
  +   mu[65e6 <= x & x <= 80e6] <- -1
  +   mu
  + } # cnState()
  > 
  > xMax <- 100e6
  > 
  > Js <- c(200, 400, 100)
  > bs <- c(1, 1.4, 0.5)
  > as <- c(0, +0.5, -0.5)
  > sds <- c(0.5, 0.3, 0.8)
  > 
  > cnList <- list()
  > for (kk in seq_along(Js)) {
  +   J <- Js[kk]
  +   a <- as[kk]
  +   b <- bs[kk]
  +   sd <- sds[kk]
  +   x <- sort(runif(J, max=xMax))
  +   mu <- a + b * cnState(x)
  +   eps <- rnorm(J, sd=sd)
  +   y <- mu + eps
  +   cn <- RawCopyNumbers(y, x)
  +   cnList[[kk]] <- cn
  + }
  > 
  > 
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > # Merge platform data (record their sources in 'id')
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > cn <- Reduce(append, cnList)
  > plot(cn, ylim=c(-3,3), col=cn$id)
  > 
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > # Segment
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > legend <- c()
  > 
  > if (require("DNAcopy")) {
  +   fit <- segmentByCBS(cn)
  +   cnr <- extractCopyNumberRegions(fit)
  +   print(cnr)
  +   drawLevels(cnr, col="white", lwd=6)
  +   drawLevels(cnr, col="red", lwd=3)
  +   legend <- c(legend, red="CBS")
  + }
  Loading required package: DNAcopy
  CopyNumberRegions:
  Number of regions: 5
  > 
  > 
  > if (require("mpcbs")) {
  +   fit <- local({
  +     ## WORKAROUND: There's a _R_CHECK_LENGTH_1_LOGIC2_ bug in
  +     ## mpcbs::mpcbs.mbic().  Until fixed, we need to disable this check
  +     ## while calling segmentByMPCBS().
  +     ovalue <- Sys.getenv("_R_CHECK_LENGTH_1_LOGIC2_")
  +     on.exit(Sys.setenv("_R_CHECK_LENGTH_1_LOGIC2_"=ovalue))
  +     ovalue <- Sys.setenv("_R_CHECK_LENGTH_1_LOGIC2_"="warn,verbose")
  +     segmentByMPCBS(cn)
  +   })
  +   cnr <- extractCopyNumberRegions(fit)
  +   print(cnr)
  +   drawLevels(cnr, col="white", lwd=6)
  +   drawLevels(cnr, col="blue", lwd=3)
  +   legend <- c(legend, blue="MPCBS")
  + }
  Loading required package: mpcbs
  Loading required package: fields
  Loading required package: spam
  Spam version 2.9-1 (2022-08-07) is loaded.
  Type 'help( Spam)' or 'demo( spam)' for a short introduction 
  and overview of this package.
  Help for individual functions is also obtained by adding the
  suffix '.spam' to the function name, e.g. 'help( chol.spam)'.
  
  Attaching package: 'spam'
  
  The following object is masked from 'package:aroma.core':
  
      display
  
  The following object is masked from 'package:R.utils':
  
      cleanup
  
  The following objects are masked from 'package:base':
  
      backsolve, forwardsolve
  
  Loading required package: viridis
  Loading required package: viridisLite
  
  Try help(fields) to get started.
  Error in is.na(rratio) || (length(rratio) != K) : 
    'length = 3' in coercion to 'logical(1)'
  Calls: local ... system.time -> do.call -> mpcbs.mbic -> fcompute.max.ProjectedZ
  Timing stopped at: 0.001 0 0.001
  Execution halted

❯ checking tests ...
  See below...

❯ checking package dependencies ... NOTE
  Packages suggested but not available for checking: 'EBImage', 'GLAD'

❯ checking Rd cross-references ... NOTE
  Package unavailable to check Rd xrefs: 'GLAD'

2 errors ✖ | 0 warnings ✔ | 2 notes ✖

── aroma.core 3.3.0: NOTE

  Build ID:   aroma.core_3.3.0.tar.gz-9df0dee7bafa47d98314e8e2c5ac6146
  Platform:   Debian Linux, R-patched, GCC
  Submitted:  1h 21m 58.5s ago
  Build time: 1h 16m 35.3s

❯ checking package dependencies ... NOTE
  Packages suggested but not available for checking: 'EBImage', 'GLAD'

❯ checking Rd cross-references ... NOTE
  Package unavailable to check Rd xrefs: ‘GLAD’

0 errors ✔ | 0 warnings ✔ | 2 notes ✖

── aroma.core 3.3.0: ERROR

  Build ID:   aroma.core_3.3.0.tar.gz-be92fb5e08704d839a267296bc8620f2
  Platform:   Fedora Linux, R-devel, GCC
  Submitted:  1h 21m 58.5s ago
  Build time: 54m 11.8s

❯ checking examples ... ERROR
  Running examples in ‘aroma.core-Ex.R’ failed
  The error most likely occurred in:
  
  > ### Name: segmentByMPCBS.RawGenomicSignals
  > ### Title: Segment copy numbers using the multi-platform CBS (mpCBS) method
  > ### Aliases: segmentByMPCBS.RawGenomicSignals
  > ###   RawGenomicSignals.segmentByMPCBS
  > ###   segmentByMPCBS,RawGenomicSignals-method
  > ### Keywords: internal methods IO
  > 
  > ### ** Examples
  > 
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > # Simulating copy-number data from multiple platforms
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > # Piecewise-constant copy-number state function
  > cnState <- function(x, ...) {
  +   n <- length(x)
  +   mu <- double(n)
  +   mu[20e6 <= x & x <= 30e6] <- +1
  +   mu[65e6 <= x & x <= 80e6] <- -1
  +   mu
  + } # cnState()
  > 
  > xMax <- 100e6
  > 
  > Js <- c(200, 400, 100)
  > bs <- c(1, 1.4, 0.5)
  > as <- c(0, +0.5, -0.5)
  > sds <- c(0.5, 0.3, 0.8)
  > 
  > cnList <- list()
  > for (kk in seq_along(Js)) {
  +   J <- Js[kk]
  +   a <- as[kk]
  +   b <- bs[kk]
  +   sd <- sds[kk]
  +   x <- sort(runif(J, max=xMax))
  +   mu <- a + b * cnState(x)
  +   eps <- rnorm(J, sd=sd)
  +   y <- mu + eps
  +   cn <- RawCopyNumbers(y, x)
  +   cnList[[kk]] <- cn
  + }
  > 
  > 
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > # Merge platform data (record their sources in 'id')
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > cn <- Reduce(append, cnList)
  > plot(cn, ylim=c(-3,3), col=cn$id)
  > 
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > # Segment
  > # - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  > legend <- c()
  > 
  > if (require("DNAcopy")) {
  +   fit <- segmentByCBS(cn)
  +   cnr <- extractCopyNumberRegions(fit)
  +   print(cnr)
  +   drawLevels(cnr, col="white", lwd=6)
  +   drawLevels(cnr, col="red", lwd=3)
  +   legend <- c(legend, red="CBS")
  + }
  Loading required package: DNAcopy
  CopyNumberRegions:
  Number of regions: 5
  > 
  > 
  > if (require("mpcbs")) {
  +   fit <- local({
  +     ## WORKAROUND: There's a _R_CHECK_LENGTH_1_LOGIC2_ bug in
  +     ## mpcbs::mpcbs.mbic().  Until fixed, we need to disable this check
  +     ## while calling segmentByMPCBS().
  +     ovalue <- Sys.getenv("_R_CHECK_LENGTH_1_LOGIC2_")
  +     on.exit(Sys.setenv("_R_CHECK_LENGTH_1_LOGIC2_"=ovalue))
  +     ovalue <- Sys.setenv("_R_CHECK_LENGTH_1_LOGIC2_"="warn,verbose")
  +     segmentByMPCBS(cn)
  +   })
  +   cnr <- extractCopyNumberRegions(fit)
  +   print(cnr)
  +   drawLevels(cnr, col="white", lwd=6)
  +   drawLevels(cnr, col="blue", lwd=3)
  +   legend <- c(legend, blue="MPCBS")
  + }
  Loading required package: mpcbs
  Loading required package: fields
  Loading required package: spam
  Spam version 2.9-1 (2022-08-07) is loaded.
  Type 'help( Spam)' or 'demo( spam)' for a short introduction 
  and overview of this package.
  Help for individual functions is also obtained by adding the
  suffix '.spam' to the function name, e.g. 'help( chol.spam)'.
  
  Attaching package: ‘spam’
  
  The following object is masked from ‘package:aroma.core’:
  
      display
  
  The following object is masked from ‘package:R.utils’:
  
      cleanup
  
  The following objects are masked from ‘package:base’:
  
      backsolve, forwardsolve
  
  Loading required package: viridis
  Loading required package: viridisLite
  
  Try help(fields) to get started.
  Error in is.na(rratio) || (length(rratio) != K) : 
    'length = 3' in coercion to 'logical(1)'
  Calls: local ... system.time -> do.call -> mpcbs.mbic -> fcompute.max.ProjectedZ
  Timing stopped at: 0 0 0.001
  Execution halted

❯ checking tests ...
  See below...

❯ checking package dependencies ... NOTE
  Packages suggested but not available for checking: 'EBImage', 'GLAD'

❯ checking Rd cross-references ... NOTE
  Package unavailable to check Rd xrefs: ‘GLAD’

2 errors ✖ | 0 warnings ✔ | 2 notes ✖

── aroma.core 3.3.0: ERROR

  Build ID:   aroma.core_3.3.0.tar.gz-bec64880060f4947a0eebca45c543a7e
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  1h 21m 58.5s ago
  Build time: 3m 36.8s

❯ checking package dependencies ... ERROR
  Packages suggested but not available: 'preprocessCore', 'GLAD'
  
  The suggested packages are required for a complete check.
  Checking can be attempted without them by setting the environment
  variable _R_CHECK_FORCE_SUGGESTS_ to a false value.
  
  See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
  manual.

1 error ✖ | 0 warnings ✔ | 0 notes ✔

── aroma.core 3.3.0: NOTE

  Build ID:   aroma.core_3.3.0.tar.gz-5744a383f51e41469e6808ae026595b4
  Platform:   Windows Server 2022, R-release, 32/64 bit
  Submitted:  1h 21m 58.5s ago
  Build time: 6m 9.5s

❯ checking package dependencies ... NOTE
  Package suggested but not available for checking: 'mpcbs'

0 errors ✔ | 0 warnings ✔ | 1 note ✖
```
