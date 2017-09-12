# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.4.1 (2017-06-30) |
|system   |x86_64, linux-gnu            |
|ui       |X11                          |
|language |en                           |
|collate  |C                            |
|tz       |NA                           |
|date     |2017-09-12                   |

## Packages

|package        |*  |version |date       |source         |
|:--------------|:--|:-------|:----------|:--------------|
|aroma.core     |   |3.1.0   |2017-03-23 |cran (@3.1.0)  |
|aroma.light    |   |3.6.0   |2017-06-29 |cran (@3.6.0)  |
|Cairo          |   |1.5-9   |2015-09-26 |cran (@1.5-9)  |
|DNAcopy        |   |1.50.1  |2017-06-30 |cran (@1.50.1) |
|EBImage        |   |4.18.2  |2017-09-12 |cran (@4.18.2) |
|expectile      |   |0.3.0   |2017-09-12 |cran (@0.3.0)  |
|future         |   |1.6.1   |2017-09-09 |cran (@1.6.1)  |
|HaarSeg        |   |0.0.3   |2017-09-12 |cran (@0.0.3)  |
|listenv        |   |0.6.0   |2015-12-28 |cran (@0.6.0)  |
|matrixStats    |   |0.52.2  |2017-04-14 |cran (@0.52.2) |
|mpcbs          |   |1.1.1   |2017-09-12 |cran (@1.1.1)  |
|png            |   |0.1-8   |2017-04-24 |cran (@0.1-8)  |
|preprocessCore |   |1.38.1  |2017-06-29 |cran (@1.38.1) |
|PSCBS          |   |0.63.0  |2017-06-28 |cran (@0.63.0) |
|R.cache        |   |0.12.0  |2015-11-12 |cran (@0.12.0) |
|R.devices      |   |2.15.1  |2016-11-10 |cran (@2.15.1) |
|R.filesets     |   |2.11.0  |2017-02-28 |cran (@2.11.0) |
|R.methodsS3    |   |1.7.1   |2016-02-16 |cran (@1.7.1)  |
|R.oo           |   |1.21.0  |2016-11-01 |cran (@1.21.0) |
|R.rsp          |   |0.41.0  |2017-04-16 |cran (@0.41.0) |
|R.utils        |   |2.5.0   |2016-11-07 |cran (@2.5.0)  |
|RColorBrewer   |   |1.1-2   |2014-12-07 |cran (@1.1-2)  |
|sfit           |   |0.3.1   |2017-09-12 |cran (@0.3.1)  |

# Check results

10 packages

|package          |version | errors| warnings| notes|
|:----------------|:-------|------:|--------:|-----:|
|ACNE             |0.8.1   |      0|        0|     0|
|MPAgenomics      |1.1.2   |      0|        0|     2|
|NSA              |0.0.32  |      0|        0|     7|
|PECA             |1.13.0  |      0|        0|     1|
|Repitools        |1.23.0  |      1|        0|     3|
|SWATH2stats      |1.7.5   |      0|        3|     4|
|TIN              |1.9.0   |      0|        0|     3|
|aroma.affymetrix |3.1.0   |      0|        0|     1|
|aroma.cn         |1.6.1   |      0|        0|     1|
|calmate          |0.12.1  |      0|        0|     0|

## ACNE (0.8.1)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/ACNE/issues

0 errors | 0 warnings | 0 notes

## MPAgenomics (1.1.2)
Maintainer: Samuel Blanck <samuel.blanck@inria.fr>

0 errors | 0 warnings | 2 notes

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  'R.devices' 'R.filesets' 'R.methodsS3' 'R.oo' 'aroma.affymetrix'
  'aroma.cn' 'aroma.core' 'aroma.light' 'matrixStats' 'snowfall'
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
Unexported object imported by a ':::' call: 'cghseg:::segmeanCO'
  See the note in ?`:::` about the use of this operator.

checking R code for possible problems ... NOTE
.varregtimescount: no visible global function definition for 'var'
CGHSEGaroma: no visible global function definition for 'read.csv'
CGHSEGaroma : <anonymous>: no visible global function definition for
  'points'
CGHSEGaroma : <anonymous>: no visible global function definition for
  'lines'
CGHSEGaroma : <anonymous>: no visible global function definition for
  'write.table'
CGHcall: no visible global function definition for 'mad'
... 43 lines ...
tumorboostPlot: no visible global function definition for 'par'
tumorboostPlot: no visible global function definition for 'axis'
tumorboostPlot: no visible global function definition for 'points'
Undefined global functions or variables:
  axis head lines lm mad median optim par points read.csv sd var
  write.table
Consider adding
  importFrom("graphics", "axis", "lines", "par", "points")
  importFrom("stats", "lm", "mad", "median", "optim", "sd", "var")
  importFrom("utils", "head", "read.csv", "write.table")
to your NAMESPACE file.
```

## NSA (0.0.32)
Maintainer: Maria Ortiz-Estevez <mortizest@gmail.com>

0 errors | 0 warnings | 7 notes

```
checking package dependencies ... NOTE
Depends: includes the non-default packages:
  'R.methodsS3' 'MASS' 'matrixStats' 'R.oo' 'R.utils' 'aroma.core'
  'aroma.affymetrix' 'DNAcopy'
Adding so many packages to the search path is excessive and importing
selectively is preferable.

checking installed package size ... NOTE
  installed size is 1024.3Mb
  sub-directories of 1Mb or more:
    exData  1024.2Mb

checking top-level files ... NOTE
Non-standard file/directory found at top level:
  'incl'

checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  'DNAcopy' 'MASS' 'R.methodsS3' 'R.oo' 'aroma.affymetrix' 'aroma.core'
  'matrixStats'
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.

checking S3 generic/method consistency ... NOTE
Found the following apparent S3 methods exported but not registered:
  NSAByTotalAndFracB.matrix allocateOutputDataSets.NSANormalization
  allocateOutputDataSets.SNPsNormalization
  allocateOutputDataSets.SampleNormalization
  as.character.NSANormalization as.character.SNPsNormalization
  as.character.SampleNormalization findArraysTodo.NSANormalization
  findArraysTodo.SampleNormalization findUnitsTodo.SNPsNormalization
  fitNSA.matrix fitNSAcnPs.matrix getDataSets.NSANormalization
  getDataSets.SNPsNormalization getDataSets.SampleNormalization
  getName.NSANormalization getName.SNPsNormalization
  getName.SampleNormalization getOutputDataSets.NSANormalization
  getOutputDataSets.SNPsNormalization
  getOutputDataSets.SampleNormalization getPath.NSANormalization
  getPath.SNPsNormalization getPath.SampleNormalization
  getRootPath.NSANormalization getRootPath.SNPsNormalization
  getRootPath.SampleNormalization process.NSANormalization
  process.SNPsNormalization process.SampleNormalization
  sampleNByTotalAndFracB.numeric snpsNByTotalAndFracB.matrix
See section 'Registering S3 methods' in the 'Writing R Extensions'
manual.

checking R code for possible problems ... NOTE
NB: .First.lib is obsolete and will not be used in R >= 3.0.0

.First.lib: no visible global function definition for
  'packageDescription'
NSAByTotalAndFracB.matrix: no visible global function definition for
  'throw'
NSAByTotalAndFracB.matrix: no visible global function definition for
  'str'
NSANormalization: no visible global function definition for 'throw'
... 279 lines ...
  extractMatrix findUnitsTodo getAsteriskTags getChipType getFile
  getFullName getFullNames getGenomeInformation getName getNames
  getPath getPathname getPathnames getPositions getRam getRootPath
  getTags getUnitsOnChromosome hist median nbrOfFiles newInstance
  packageDescription rowAlls rowMedians segment setTags str throw trim
  verbose
Consider adding
  importFrom("graphics", "hist")
  importFrom("stats", "approxfun", "median")
  importFrom("utils", "packageDescription", "str")
to your NAMESPACE file.

checking Rd line widths ... NOTE
Rd file 'NSANormalization.Rd':
  \examples lines wider than 100 characters:
     by <- 50e3; # 50kb bins; you may want to try with other amounts of smoothing xOut <- seq(from=xRange[1], to=xRange[2], by=by);
     plot(getSignals(cnCNPS), getSignals(cnSNPS), xlim=Clim, ylim=Clim); abline(a=0, b=1, col="red", lwd=2);

These lines will be truncated in the PDF manual.
```

## PECA (1.13.0)
Maintainer: Tomi Suomi <tomi.suomi@utu.fi>

0 errors | 0 warnings | 1 note 

```
checking Rd line widths ... NOTE
Rd file 'PECA.Rd':
  \usage lines wider than 90 characters:
     PECA_AffyBatch(affy=NULL, normalize=FALSE, test="t", type="median", paired=FALSE, progress=FALSE)

These lines will be truncated in the PDF manual.
```

## Repitools (1.23.0)
Maintainer: Mark Robinson <mark.robinson@imls.uzh.ch>

1 error  | 0 warnings | 3 notes

```
checking examples ... ERROR
Running examples in 'Repitools-Ex.R' failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: empBayes
> ### Title: Function to calculate prior parameters using empirical Bayes.
> ### Aliases: empBayes
> ### Keywords: programming
> 
... 56 lines ...

Offset is determined for sample of interest: 2


	Information: The program will take advantage of 21 CPUs from total 64
	If you would like to change this please cancel and set explicitly the argument 'ncpus'


Error in .check_ncores(cores) : 21 simultaneous processes spawned
Calls: empBayes -> mclapply -> .check_ncores
Execution halted

checking R code for possible problems ... NOTE
Found an obsolete/platform-specific call in the following function:
  'maskOut'
Found the platform-specific device:
  'windows'
dev.new() is the preferred way to open a new device, in the unlikely
event one is needed.
.cpgBoxplots: no visible global function definition for 'pdf'
.cpgBoxplots: no visible global function definition for 'par'
.cpgBoxplots: no visible global function definition for 'dev.off'
... 291 lines ...
  rainbow read.table rect str t.test text title verbose
Consider adding
  importFrom("grDevices", "dev.off", "pdf", "rainbow")
  importFrom("graphics", "abline", "axis", "barplot", "bxp", "grid",
             "layout", "legend", "lines", "matlines", "matplot", "mtext",
             "par", "persp", "plot", "plot.new", "plot.window", "points",
             "polygon", "rect", "text", "title")
  importFrom("stats", "dbeta", "embed", "filter", "kmeans", "lm",
             "lowess", "p.adjust", "predict", "pt", "qnorm", "t.test")
  importFrom("utils", "read.table", "str")
to your NAMESPACE file.

checking Rd line widths ... NOTE
Rd file 'ChromaBlocks.Rd':
  \usage lines wider than 90 characters:
     ChromaBlocks(rs.ip, rs.input, organism, chrs, ipWidth=100, inputWidth=500, preset=NULL, blockWidth=NULL, minBlocks=NULL, extend=NULL, c ... [TRUNCATED]

Rd file 'GCbiasPlots.Rd':
  \usage lines wider than 90 characters:
                 cex = 0.2, pch.col = "black", line.col = "red", lty = 1, lwd = 2, verbose = TRUE)

Rd file 'absoluteCN.Rd':
... 57 lines ...

Rd file 'regionStats.Rd':
  \usage lines wider than 90 characters:
     regionStats(x, design = NULL, maxFDR=0.05, n.perm=5, window=600, mean.trim=.1, min.probes=10, max.gap=500, two.sides=TRUE, ndf, return. ... [TRUNCATED]
     regionStats(x, design = NULL, maxFDR=0.05, n.perm=5, window=600, mean.trim=.1, min.probes=10, max.gap=500, two.sides=TRUE, ind=NULL, re ... [TRUNCATED]

Rd file 'writeWig.Rd':
  \usage lines wider than 90 characters:
     writeWig(rs, seq.len = NULL, design=NULL, sample=20, drop.zero=TRUE, normalize=TRUE, verbose=TRUE)

These lines will be truncated in the PDF manual.

checking compiled code ... NOTE
File 'Repitools/libs/Repitools.so':
  Found no call to: 'R_useDynamicSymbols'

It is good practice to register native routines and to disable symbol
search.

See 'Writing portable packages' in the 'Writing R Extensions' manual.
```

## SWATH2stats (1.7.5)
Maintainer: Peter Blattmann <blattmann@imsb.biol.ethz.ch>

0 errors | 3 warnings | 4 notes

```
checking for missing documentation entries ... WARNING
Undocumented code objects:
  'convert4PECA'
All user-level objects in a package should have documentation entries.
See chapter 'Writing R documentation files' in the 'Writing R
Extensions' manual.

checking Rd \usage sections ... WARNING
Objects in \usage without \alias in documentation object 'convert4ROPECA':
  'convert4PECA'

Functions with \usage entries need to have the appropriate \alias
entries, and all their arguments documented.
The \usage entries must correspond to syntactically valid R code.
See chapter 'Writing R documentation files' in the 'Writing R
Extensions' manual.

checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
! LaTeX Error: File `ifxetex.sty' not found.

Type X to quit or <RETURN> to proceed,
or enter new name. (Default extension: sty)

Enter file name: 
! Emergency stop.
<read *> 
         
l.5 \usepackage

pandoc: Error producing PDF
Error: processing vignette 'SWATH2stats_example_script.Rmd' failed with diagnostics:
pandoc document conversion failed with error 43
Execution halted


checking package dependencies ... NOTE
Packages which this enhances but not available for checking:
  'imsbInfer' 'MSstats'

checking installed package size ... NOTE
  installed size is 1025.2Mb
  sub-directories of 1Mb or more:
    data  1024.6Mb

checking top-level files ... NOTE
Non-standard file/directory found at top level:
  'scripts'

checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: 'MSstats'
```

## TIN (1.9.0)
Maintainer: Bjarne Johannessen <bjajoh@rr-research.no>

0 errors | 0 warnings | 3 notes

```
checking installed package size ... NOTE
  installed size is 2049.3Mb
  sub-directories of 1Mb or more:
    data  2049.0Mb

checking top-level files ... NOTE
Non-standard file/directory found at top level:
  'doc'

checking R code for possible problems ... NOTE
aberrantExonUsage: no visible global function definition for 'quantile'
aberrantExonUsage: no visible global function definition for 'ave'
clusterPlot: no visible global function definition for 'dist'
clusterPlot: no visible global function definition for 'hclust'
clusterPlot: no visible global function definition for
  'colorRampPalette'
clusterPlot: no visible global function definition for 'par'
clusterPlot: no visible global function definition for 'png'
clusterPlot: no visible global function definition for 'jpeg'
... 50 lines ...
  importFrom("stats", "ave", "dist", "hclust", "median", "quantile")
  importFrom("utils", "data", "read.table")
to your NAMESPACE file.

Found the following assignments to the global environment:
File 'TIN/R/aberrantExonUsage.R':
  assign("quantiles", quantiles, envir = .GlobalEnv)
  assign("aberrantExons", aberrantExons, envir = .GlobalEnv)
File 'TIN/R/correlationPlot.R':
  assign("randomGeneSetsDist", B, envir = .GlobalEnv)
  assign("traPermutationsDist", L, envir = .GlobalEnv)
```

## aroma.affymetrix (3.1.0)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/aroma.affymetrix/issues

0 errors | 0 warnings | 1 note 

```
checking installed package size ... NOTE
  installed size is 1028.1Mb
  sub-directories of 1Mb or more:
    R            1024.9Mb
    help            1.1Mb
    testScripts     1.2Mb
```

## aroma.cn (1.6.1)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/aroma.cn/issues

0 errors | 0 warnings | 1 note 

```
checking package dependencies ... NOTE
Package suggested but not available for checking: 'GLAD'
```

## calmate (0.12.1)
Maintainer: Henrik Bengtsson <henrikb@braju.com>  
Bug reports: https://github.com/HenrikBengtsson/calmate/issues

0 errors | 0 warnings | 0 notes

