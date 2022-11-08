## Installation

This R package is available on [CRAN](https://cran.r-project.org/package=aroma.core) and can be installed in R as:

```r
# install.packages("BiocManager")
BiocManager::install(c("aroma.light", "DNAcopy"))

install.packages("aroma.core")
```

To install the _optional_ dependency **sfit**, use:

```r
install.packages("sfit", repos = "https://henrikbengtsson.r-universe.dev")
```

To install the very-rarely needed _optional_ dependencies **expectile**, **mpcbs**, and **HaarSeg**, use:

```r
install.packages("expectile", repos = "https://henrikbengtsson.r-universe.dev")
install.packages("mpcbs", repos = "https://r-forge.r-project.org")
install.packages("HaarSeg", repos = "https://r-forge.r-project.org", INSTALL_opts = "--no-test-load")
```


### Pre-release version
 
To install the pre-release version that is available in Git branch `develop` on GitHub, use:

```r
remotes::install_github("HenrikBengtsson/aroma.core", ref="develop")
```

This will install the package from source.  
