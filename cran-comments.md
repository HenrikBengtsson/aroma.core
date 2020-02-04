# CRAN submission aroma.core 3.2.1

on 2020-02-03

This submission addresses \usage{} mistake discovered by recent R-devel PR#16223 fix.

I've verified that this submission causes no issues for any of the 5 reverse package dependencies available on CRAN and Bioconductor.

Thanks in advance


## Notes not sent to CRAN

### R CMD check --as-cran validation

The package has been verified using `R CMD check --as-cran` on:

* Platform x86_64-apple-darwin15.6.0 (64-bit) [Travis CI]:
  - R version 3.5.3 (2019-03-11)
  - R version 3.6.2 (2019-12-12)

* Platform x86_64-unknown-linux-gnu (64-bit) [Travis CI]:
  - R version 3.5.3 (2017-01-27) [sic!]
  - R version 3.6.2 (2017-01-27) [sic!]
  - R Under development (unstable) (2020-02-03 r77764)

* Platform x86_64-pc-linux-gnu (64-bit):
  - R version 3.2.0 (2015-04-16)
  - R version 3.3.0 (2016-05-03)
  - R version 3.4.0 (2017-04-21)
  - R version 3.5.0 (2018-04-23)
  - R version 3.6.0 (2019-04-26)
  - R version 3.6.2 (2019-12-12)
  
* Platform x86_64-pc-linux-gnu (64-bit) [r-hub]:
  - R version 3.6.1 (2019-07-05)
  - R Under development (unstable) (2020-02-01 r77752)

* Platform i686-pc-linux-gnu (32-bit):
  - R version 3.4.4 (2018-03-15)
  - R version 3.6.1 (2019-07-05)

* Platform i386-pc-solaris2.10 (32-bit) [r-hub]:
  - R version 3.6.0 (2019-04-26)

* Platform x86_64-w64-mingw32 (64-bit) [r-hub]:
  - R Under development (unstable) (2020-01-22 r77697)

* Platform i386-w64-mingw32 (32-bit) [Appveyor CI]:
  - R version 3.6.2 (2019-12-12)
  
* Platform x86_64-w64-mingw32/x64 (64-bit) [Appveyor CI]:
  - R version 3.6.2 (2019-12-12)

* Platform x86_64-w64-mingw32/x64 (64-bit) [win-builder]:
  - R version 3.6.2 (2019-12-12)

Not available:

* Platform x86_64-w64-mingw32/x64 (64-bit) [win-builder]:
  - R Under development (unstable) (2019-06-14 r76701)
  REASON: Huge backlog


### Notes

```sh
> env_vars <- c("_R_CHECK_FORCE_SUGGESTS_"="false")
> rhub::check_for_cran(env_vars = env_vars)
> rhub::check(env_vars = env_vars)
```
