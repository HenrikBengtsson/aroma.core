# CRAN submission aroma.core 2.13.0
on 2015-01-07

I have verified the package and its 5 reverse-dependent packages(*) using `R CMD build` and `R CMD check --as-cran` on

* R version 3.0.0 (2013-04-03) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R version 3.0.3 (2014-03-06) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R version 3.0.3 (2014-03-06) [Platform: x86_64-w64-mingw32/x64 (64-bit)].
* R version 3.1.2 (2014-10-31) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R version 3.1.2 Patched (2015-01-05 r67329) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R version 3.1.2 Patched (2015-01-05 r67329) [Platform: x86_64-w64-mingw32/x64 (64-bit)].
* R Under development (unstable) (2015-01-05 r67329) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R Under development (unstable) (2015-01-06 r67341) [Platform: x86_64-w64-mingw32/x64 (64-bit)].

I have also verified the package using the <http://win-builder.r-project.org/> service.

This submission contains changes that are related to updates in R and/or CRAN;

 * Now using `Additional_repositories` for packages on non-mainstream repositories.

Thank you,

Henrik Bengtsson  
(maintainer of aroma.core)

Footnotes:  
(*) The submitted updates cause no issues for any of the following 5 reverse dependencies: aroma.affymetrix 2.12.0, aroma.cn 1.5.0, calmate 0.11.0, MPAgenomics 1.1.2 and NSA 0.0.32.

---
Update 2015-01-08:

I forgot to clarify this in my note to CRAN that this NOTE
is false.  In the `NAMESPACE` file I limit the number of S3 methods in <
3.1.0 using:

    if (getRversion() >= "3.1.0") {
      ...
    }

This was also the case in my 2.12.1 submission, which was discussed
and accepted back in March 2014, cf.

"... I've now updated the NAMESPACE file in aroma.core 2.12.1 to
limit the number of registered S3 methods for R (< 3.1.0) instead
of R (< 3.0.2) as in aroma.core 2.12.0.  The `R CMD check` message
on R-devel:

* using R Under development (unstable) (2014-03-03 r65113)
[...]
* checking package namespace information ... NOTE
R < 3.0.2 had a limit of 500 registered S3 methods: found 782

is not correct, since it applies the loaded `NAMESPACE` in R devel but
apply the check emulating R 3.0.1.  On all other versions `R CMD
check` passes with all OKs."
