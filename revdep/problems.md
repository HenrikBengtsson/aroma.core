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

2 packages with problems

|package     |version | errors| warnings| notes|
|:-----------|:-------|------:|--------:|-----:|
|Repitools   |1.23.0  |      1|        0|     3|
|SWATH2stats |1.7.5   |      0|        3|     4|

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

