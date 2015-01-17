# CRAN submission aroma.core 2.13.0
on 2015-01-16

This is a re-submission of aroma.core 2.13.0 of my Jan 7 submission, which for unknown reasons vanished from the CRAN upload ftp folders.

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

Note that R CMD check on R (>= 3.1.0) gives the following *false* NOTE:

* checking package namespace information ... NOTE
R < 3.0.2 had a limit of 500 registered S3 methods: found 782

This NOTE is not correct, since it done on `NAMESPACE` loaded in R (>= 3.1.0), which is different from the one that is loaded in R (< 3.1.0), because in the latter I limit the number of registered S3 methods in `NAMESPACE` using:

    if (getRversion() >= "3.1.0") {
      ...
    } 

This exact same approach was taken also in aroma.core 2.12.1, which was accepted in March 7, 2014 (by email from CRAN).

Thank you,

Henrik Bengtsson  
(maintainer of aroma.core)

Footnotes:  
(*) The submitted updates cause no issues for any of the following 5
reverse dependencies: aroma.affymetrix 2.12.0, aroma.cn 1.5.0,
calmate 0.11.0, MPAgenomics 1.1.2 and NSA 0.0.32.
