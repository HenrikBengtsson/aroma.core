# CRAN submission aroma.core 2.13.1
on 2015-05-25

Package now declare all S3 methods.

Thanks in advance


## Notes not sent to CRAN

I have verified aroma.core 2.13.0-9000 and its 6 reverse-dependent packages(*) using `R CMD build` and `R CMD chec
k --as-cran` on

* R version 3.1.3 (2015-03-09) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R version 3.2.0 (2015-04-16) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R version 3.2.0 Patched (2015-05-22 r68399) [Platform: x86_64-unknown-linux-gnu (64-bit)].
* R Under development (unstable) (2015-05-25 r68405) [Platform: x86_64-w64-mingw32/x64 (64-bit)]

I have also verified the package using the <http://win-builder.r-project.org/> service.

This submission contains changes that are related to updates in R and/or CRAN;

* Package now declare all S3 methods.

Thank you,

Henrik Bengtsson
(maintainer of aroma.core)

Footnotes:
(*) The submitted updates cause no issues for any of the following 6 reverse dependencies on CRAN: ACNE 0.8.0, MPAgenomics 1.1.2, NSA 0.0.32, aroma.affymetrix 2.13.0, aroma.cn 1.6.0 and calmate 0.12.0.
