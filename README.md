


# aroma.core: Core Methods and Classes Used by 'aroma.*' Packages Part of the Aroma Framework


## Installation
R package aroma.core is available on [CRAN](https://cran.r-project.org/package=aroma.core) and can be installed in R as:
```r
install.packages("aroma.core")
```


### Pre-release version

To install the pre-release version that is available in Git branch `develop` on GitHub, use:
```r
remotes::install_github("HenrikBengtsson/aroma.core", ref="develop")
```
This will install the package from source.  

## Contributions

This Git repository uses the [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) branching model (the [`git flow`](https://github.com/petervanderdoes/gitflow-avh) extension is useful for this).  The [`develop`](https://github.com/HenrikBengtsson/aroma.core/tree/develop) branch contains the latest contributions and other code that will appear in the next release, and the [`master`](https://github.com/HenrikBengtsson/aroma.core) branch contains the code of the latest release, which is exactly what is currently on [CRAN](https://cran.r-project.org/package=aroma.core).

Contributing to this package is easy.  Just send a [pull request](https://help.github.com/articles/using-pull-requests/).  When you send your PR, make sure `develop` is the destination branch on the [aroma.core repository](https://github.com/HenrikBengtsson/aroma.core).  Your PR should pass `R CMD check --as-cran`, which will also be checked by <a href="https://travis-ci.org/HenrikBengtsson/aroma.core">Travis CI</a> and <a href="https://ci.appveyor.com/project/HenrikBengtsson/aroma-core">AppVeyor CI</a> when the PR is submitted.

We abide to the [Code of Conduct](https://www.contributor-covenant.org/version/2/0/code_of_conduct/) of Contributor Covenant.


## Software status

| Resource      | CRAN        | GitHub Actions      | Travis CI       | AppVeyor CI      |
| ------------- | ------------------- | ------------------- | --------------- | ---------------- |
| _Platforms:_  | _Multiple_          | _Multiple_          | _Linux & macOS_ | _Windows_        |
| R CMD check   | <a href="https://cran.r-project.org/web/checks/check_results_aroma.core.html"><img border="0" src="http://www.r-pkg.org/badges/version/aroma.core" alt="CRAN version"></a> | <a href="https://github.com/HenrikBengtsson/aroma.core/actions?query=workflow%3AR-CMD-check"><img src="https://github.com/HenrikBengtsson/aroma.core/workflows/R-CMD-check/badge.svg?branch=develop" alt="Build status"></a>       | <a href="https://travis-ci.org/HenrikBengtsson/aroma.core"><img src="https://travis-ci.org/HenrikBengtsson/aroma.core.svg" alt="Build status"></a>   | <a href="https://ci.appveyor.com/project/HenrikBengtsson/aroma-core"><img src="https://ci.appveyor.com/api/projects/status/github/HenrikBengtsson/aroma.core?svg=true" alt="Build status"></a> |
| Test coverage |                     |                     | <a href="https://codecov.io/gh/HenrikBengtsson/aroma.core"><img src="https://codecov.io/gh/HenrikBengtsson/aroma.core/branch/develop/graph/badge.svg" alt="Coverage Status"/></a>     |                  |
