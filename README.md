

<div id="badges"><!-- pkgdown markup -->
<a href="https://CRAN.R-project.org/web/checks/check_results_aroma.core.html"><img border="0" src="https://www.r-pkg.org/badges/version/aroma.core" alt="CRAN check status"/></a> <a href="https://github.com/HenrikBengtsson/aroma.core/actions?query=workflow%3AR-CMD-check"><img border="0" src="https://github.com/HenrikBengtsson/aroma.core/actions/workflows/R-CMD-check.yaml/badge.svg?branch=develop" alt="R CMD check status"/></a>     <a href="https://app.codecov.io/gh/HenrikBengtsson/aroma.core"><img border="0" src="https://codecov.io/gh/HenrikBengtsson/aroma.core/branch/develop/graph/badge.svg" alt="Coverage Status"/></a> 
</div>

# aroma.core: Core Methods and Classes Used by 'aroma.*' Packages Part of the Aroma Framework 


## Installation

This R package is available on [CRAN](https://cran.r-project.org/package=aroma.core) and can be installed in R as:

```r
# install.packages("BiocManager")
BiocManager::install(c("aroma.light", "DNAcopy"))

install.packages("aroma.core")
```

To install the _optional_ dependency **sfit**, use:

```r
install.packages("sfit", repos = "https://henrikbengtsson.github.io/drat")
```

To install the very-rarely needed _optional_ dependencies **expectile**, **mpcbs**, and **HaarSeg**, use:

```r
install.packages(c("expectile", "mpcbs"), repos = "https://r-forge.r-project.org")
install.packages("HaarSeg", repos = "https://r-forge.r-project.org", INSTALL_opts = "--no-test-load")
```


### Pre-release version
 
To install the pre-release version that is available in Git branch `develop` on GitHub, use:

```r
remotes::install_github("HenrikBengtsson/aroma.core", ref="develop")
```

This will install the package from source.  


<!-- pkgdown-drop-below -->

