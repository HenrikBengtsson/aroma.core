# Version (development version)

## Documentation

 * Fix minor help-page issues.


# Version 3.3.0 [2022-11-11]

## Documentation

 * Drop duplicated arguments from help for `writeDataFrame()` of
   AromaUnitSignalBinaryFile and AromaUnitTabularBinaryFile.


## Deprecated and Defunct

 * Removed defunct method `whatDataType()`.

 * The `segmentByMPCBS()` method does not work in R (>= 4.2.0).  This
   is because the **mpcbs** package has `_R_CHECK_LENGTH_1_CONDITION_`
   and`_R_CHECK_LENGTH_1_LOGIC2_` bugs, which give errors in R (>=
   4.2.0).  The **mpcbs** package is a legacy package that is no
   longer maintained.  Because of this, it is likely that
   `segmentByMPCBS()` and support for MPCBS segmentation will
   eventually be dropped from **aroma.core**.


# Version 3.2.2 [2021-01-02]

## New Features

 * `downloadFile()` for AromaRepository is now smarter about `*.gz`
   files.


## Bug Fixes

 * Re-export S3 generic `process()` from **R.rsp**.

 * Argument `pattern` for `findByGenome()` for AromaGenomeTextFile has
   an `sprintf()` mistake causing it to produce a warning in R (>=
   4.1.0).


# Version 3.2.1 [2020-02-03]

## Significant Changes

 * Package requires R (>= 3.2.1) released in June 2015 and
   Bioconductor (>= 3.2) released in October 2015.


## Miscellaneous

 * WORKAROUND: Package fails `R CMD check` with
   `_R_CHECK_LENGTH_1_LOGIC2_=true` due to PR#17663
   (https://bugs.r-project.org/bugzilla/show_bug.cgi?id=17663). Made a
   simple code tweak to avoid this bug hitting us.

 * WORKAROUND: There's a `_R_CHECK_LENGTH_1_LOGIC2_` bug in
   `mpcbs::mpcbs.mbic()`. Until fixed, we need to disable this check
   while testing `segmentByMPCBS()`.


# Version 3.2.0 [2019-06-17]

## Bug Fixes

 * `findByChipType()` for AromaMicroarrayTabularBinaryFile and
   TextUnitNamesFile would only recognize Windows Shortcut Links with
   a filename extension in lower case (`*.lnk`) but not in upper case
   (`*.LNK`).


# Version 3.1.3 [2018-04-30]

## Bug Fixes

 * Imported `extract()` from **R.utils** instead of **R.filesets**,
   which would result in `R CMD check` errors for **aroma.affymetrix**
   with R-devel (>= 3.6.0).


# Version 3.1.2 [2018-04-23]

## Workaround

 * For R (>= 3.6.0), don't run examples or tests that rely on the
   Bioconductor package **GLAD** or the legacy R-Forge package
   **expectile**, because they do not properly registered S3 generic
   function.


# Version 3.1.1 [2017-09-12]

## Bug Fixes

 * `getRegions()` for CopyNumberSegmentationModel used future strategy
   `eager` that is defunct in **future** (>= 1.6.0) - updated to
   `sequential`.


# Version 3.1.0 [2017-03-22]

## New Features

 * Now file sizes are reported using IEC binary prefixes, i.e. bytes,
   KiB, MiB, GiB, TiB, ..., YiB.

 * Now genomic positions / distances are reported in 'Mbp' (was 'MB'
   and 'Mb').

 * Objects no longer report on memory (RAM) usage.


## Bug Fixes

 * Package used `%<=%` internally with was deprecated in **future**
   (>= 1.4.0).

 * `exportTotalCnRatioSet()` for AromaUnitTotalCnBinarySet and
   `exportFracBDiffSet()` for AromaUnitFracBCnBinarySet would return
   files with file names matching `.asb`, which would incorrectly also
   include `.asb.md5` files. Thanks to Thomas Grombacher at the Merck
   Group for the report.


## Deprecated and Defunct

 * Default method `whatDataType()` is now defunct.

 * Argument `.old` of `getChipType()` for
   AromaMicroarrayTabularBinaryFile is now defunct (was deprecated in
   2008!).

 * Previously deprecated argument `maxNAFraction` to `getRawCnData()`
   of CopyNumberChromosomalModel and for `fit()` of
   CopyNumberSegmentationModel is now defunct.

 * Removed previously defunct `apply()` for SampleAnnotationFile.


# Version 3.0.0 [2016-01-05]

## Significant Changes

 * Package requires R (>= 3.1.2) and Bioconductor (>= 3.0) both
   released in October 2014.


## Performance

 * SPEED: Segmentation methods (e.g. CbsModel) now uses futures, which
   means that samples can now be segmented in parallel/distributed.


## Refactorization

 * ROBUSTNESS: Using `do.call(fcn)` internally instead of
   `do.call("fcn")`.

 * ROBUSTNESS: Using `getPathname()` internally instead of private
   field.


## Bug Fixes

 * `getOutputDataSet(..., onMissing = "dropall")` for AromaTransform
   would throw error on no applicable method `getFullNames()` for
   NULL.


## Deprecated and Defunct

 * `apply()` for SampleAnnotationFile is now defunct; use `applyTo()`.

 * Drop defunct methods.


# Version 2.14.0 [2015-10-20]

## Significant Changes

 * Renamed `apply()` for SampleAnnotationFile to `applyTo()`.


## Refactorization

 * ROBUSTNESS: Explicitly importing core R functions.

 * CLEANUP: One occurance of `rowMads(..., centers)` to `rowMads(...,
   center)`.

 * CLEANUP: Drop prototype code never used.


## Bug Fixes

 * `writeRegions(..., format = "wig")` gave an error.


## Deprecated and Defunct

 * Deprecated internal `whatDataType()` method.

 * Previously deprecated methods now defunct: `nbrOfArrays()` for
   `readData()` for AromaMicroarrayDataSetTuple,
   AromaMicroarrayDataSet and AromaUnitTotalCnBinarySet, as well as
   `readData()` for SampleAnnotationFile.

 * Removed previously (Feb 2014) defunct method `patchPackage()` and
   `patch()`.


# Version 2.13.1 [2015-05-25]

## Significant Changes

 * Package now requires R (>= 3.1.1) released July 2014. This allows
   us to use Bioconductor (>= 3.0) (October 2014).


## New Features

 * Relaxed sanity checks; now it's possible to allocate Aroma tabular
   binary files with 200 million rows (was 100 million rows).


## Software Quality

 * ROBUSTNESS: `exportAromaUnitPscnBinarySet()` asserts that no
   duplicated files are returned.

 * `getOutputDataSet()` for AromaTransform gives more informative
   error messages.


## Refactorization

 * ROBUSTNESS: Package now declares all S3 methods.


## Bug Fixes

 * `getOutputDataSet()` for AromaTransform would sometimes given an
   error due to the same output file being identified more than once,
   for instance, when the full name of an output file is also the
   prefix of another file. Thanks to Benilton Carvalho (Universidade
   Estadual de Campinas, Sao Paulo, Brazil) for reporting on this.

 * `extractRawMirroredAlleleBFractions()` for RawAlleleBFractions gave
   `Error in setSignals(res, dh) : object 'res' not found`.


# Version 2.13.0 [2015-01-07]

## New Release

 * Bumped version for CRAN submission.


## Software Quality

 * Package passes all redundancy tests.


## Refactorization

 * Updated package dependencies.


# Version 2.12.8 [2014-09-19]

## Bug Fixes

 * `display()` for Explorer would try to open a pathname in a way that
   only worked on MS Windows.  Thanks to Sunghee Oh (S. Korea) for
   reporting on this.


# Version 2.12.7 [2014-09-04]

## Software Quality

 * ROBUSTNESS: Wherever needed, files are now copied without
   preserving file permissions (e.g. read-only), which became the
   default in R (>= 2.13.0) [April 2013].


## Refactorization

 * Bumped package dependencies.


# Version 2.12.6 [2014-08-27]

## Significant Changes

 * Now `aromaSettings` are loaded when the packages is
   loaded. Previously the package had to be attached.


## Software Quality

 * ROBUSTNESS: Now `fit2d()` for matrix utilizes `use()` for
   **aroma.light**.


## Refactorization

 * ROBUSTNESS: Added several missing NAMESPACE imports.


## Bug Fixes

 * `writeDataFrame(..., columnNamesPrefix="none")` for
   AromaUnitSignalBinaryFile would give an error.


# Version 2.12.5 [2014-06-28]

## New Features

 * Added `getAromaUflFile()` for AromaPlatformInterface.


## Refactorization

 * Move `byChipType()` from classes AromaCellCpgFile and
   AromaCellPositionFile to superclass AromaCellTabularBinaryFile.

 * Package does less package reordering.


## Bug Fixes

 * `SampleAnnotationSet$loadAll()` would give an error if
   `annotationData/samples/` didn't exist or did not contain any SAF
   files.


## Deprecated and Defunct

 * Dropped `getAromaUgpFile()` for AromaUnitSignalBinaryFile.


# Version 2.12.4 [2014-06-09]

## Significant Changes

 * Package now requires R (>= 3.0.0) and Bioconductor (>= 2.13), which
   were released April 2013 and are in fact old and it's recommended
   to use a more recent version of R.


## Refactorization

 * Added `SuggestsNote` field to DESCRIPTION with list of packages
   that are recommended for the most common use cases.

 * Bumped package dependencies.


# Version 2.12.3 [2014-05-02]

## Refactorization

 * Now using `ds[[idx]]` instead of `getFile(ds, idx)` where possible.


# Version 2.12.2 [2014-04-26]

## Performance

 * Minor speedup by replacing repetive `<ns>::<fcn>()` calls with
   repetive `<fcn>()` calls; the `::` operator is fairly expensive.


# Version 2.12.1 [2014-03-04]

## Software Quality

 * CRAN POLICY: Now limiting the number of registered S3 methods in
   NAMESPACE for R (< 3.1.0).  Used to be R (< 3.0.2).


# Version 2.12.0 [2014-03-01]

## New Release

 * Bumped version for CRAN submission.


## Software Quality

 * Package passes all redundancy tests.


## Refactorization

 * Updated package dependencies.


# Version 2.11.7 [2014-02-28]

## Significant Changes

 * Now methods that supports searching sibling root directories do so
   by default.  Previously this had to be explicitly enabled via an
   option.


## Refactorization

 * Updated package dependencies.


## Deprecated and Defunct

 * Previously deprecated `downloadPackagePatch()`, `patchPackage()`
   and `patch()` for AromaPackage are now defunct.

 * Removed defunct methods.


# Version 2.11.6 [2014-02-17]

## Bug Fixes

 * The GladModel would not pass user-specified arguments.  Thanks to
   Hans-Ulrich Klein at University of Munster for reporting on this.


# Version 2.11.5 [2014-02-03]

## Bug Fixes

 * `readDataFrame()` for AromaGenomeTextFile and
   AromaUcscGenomeTextFile explicitly passed arguments `...` to
   `NextMethod()`, which would cause them to be duplicated in certain
   cases.


# Version 2.11.4 [2014-01-17]

## Refactorization

 * Now all Explorer classes utilize `R.rsp::rfile()` for compiling RSP
   files instead of the to-be-deprecated `rspToHtml()`.


# Version 2.11.3 [2014-01-16]

## Bug Fixes

 * `getGenericSummary()` for RichDataFrame would throw `Error in
   data[i, , drop = FALSE] : subscript out of bounds` if it had zero
   rows.


# Version 2.11.2 [2013-12-11]

## New Features

 * Added `findChangePointsByState()` for
   SegmentedGenomicSignalsInterface.


## Documentation

 * Added documentation for `exportAromaUnitPscnBinarySet()`.


# Version 2.11.1 [2013-11-15]

## New Features

 * Added argument `onMissing` to `getOutputDataSet()` for
   AromaTransform. This replaces argument `incomplete`, which will be
   dropped in a future version, but is for now supported as well.


# Version 2.11.0 [2013-10-16]

## Significant Changes

 * Now package requires R (>= 2.15.0) and Bioconductor (>= 2.10.0).


## Refactorization

 * Minor adjustments of NAMESPACE imports.

 * Updated package dependencies.


## Deprecated and Defunct

 * Dropped `colMedians()` for AromaTabularBinaryFile.  If needed,
   there is always `colStats()`.


# Version 2.10.6 [2013-10-07]

## Refactorization

 * Now explicitly importing only what is needed in NAMESPACE.

 * BACKWARD COMPATIBILITY: For R (< 3.0.2) only the maximum of 500 S3
   methods are declared in NAMESPACE.

 * Updated package dependencies.


# Version 2.10.5 [2013-10-03]

## New Features

 * Added argument `chromosomes` to `ChromosomalModel()` and
   `setChromosomes()` for the same class.  If not specified, the
   default is as before to infer the set of chromosomes from the UGP
   files.


## Software Quality

 * Now the sanity-check error that CopyNumberChromosomalModel throws
   gives a more informative error message suggesting to adjust
   argument `maxNAFraction` when setting up the model.


# Version 2.10.4 [2013-09-28]

## Refactorization

 * Now the `aroma.core` Package object is also available when the
   package is only loaded (but not attached).

 * Now only importing only what is needed from the **R.utils** package.


# Version 2.10.3 [2013-09-20]

## Refactorization

 * Now only importing only what is needed from the **matrixStats**
   package.

 * ROBUSTNESS: Forgot to import `R.methodsS3::appendVarArgs()`.

 * Updated package dependencies.


# Version 2.10.2 [2013-09-11]

## Refactorization

 * Backward-compatibility code for obsolete **EBImage** was no longer
   needed.

 * Updated package dependencies.


# Version 2.10.1 [2013-08-12]

## Bug Fixes

 * `exportAromaUnitPscnBinarySet()` for AromaUnitTotalCnBinarySet
   would throw an error on `unknown argument 'names' to indexOf()`.


# Version 2.10.0 [2013-08-03]

## New Release

 * Bumped version for CRAN submission.


## Software Quality

 * Package passes all redundancy tests.


## Refactorization

 * Updated package dependencies.


# Version 2.9.7 [2013-07-20]

## Refactorization

 * Replaced all internal `x11()` with `dev.new()` calls.

 * Moved more packages from Depends to Imports.

 * Updated package dependencies.


# Version 2.9.6 [2013-06-01]

## New Features

 * Added `findFilesTodo()` for AromaTransform.


# Version 2.9.5 [2013-05-30]

## New Features

 * Now it's possible to call `aroma.core::doCBS()` without loading
   package.

 * Turned `doCBS()` into a default method,
   cf. `aroma.affymetrix::doRMA()`.


## Documentation

 * Now `help("doCBS")` documents all `doCBS()` methods.


# Version 2.9.4 [2013-05-25]

## Performance

 * SPEEDUP: Replaced all `rm()` calls with NULL assignments.


# Version 2.9.3 [2013-05-22]

## Refactorization

 * Now using `getChecksum()` instead of (internal)
   `R.filesets::digest2()` with identical results.


# Version 2.9.2 [2013-05-22]

## Bug Fixes

 * `extractRawCopyNumbers()` for CopyNumberChromosomalModel would
   throw `Error in UseMethod("getChecksum") : no applicable method for
   'getChecksum' applied to an object of class "list"` if (and only
   if) **R.cache** package was not attached. Thanks Yadav Sapkota at
   University of Alberta for reporting on this.


# Version 2.9.1 [2013-05-20]

## Refactorization

 * CRAN POLICY: Now all Rd `\usage{}` lines are at most 90 characters
   long.

 * CRAN POLICY: Now all Rd example lines are at most 100 characters
   long.


# Version 2.9.0 [2013-04-23]

## New Release

 * Bumped version for CRAN submission.

 * No updates.


## Software Quality

 * Package passes all redundancy tests.


# Version 2.8.7 [2013-04-22]

## Refactorization

 * Package no longer try to apply package patches, which was only
   possible when namespaces where not used.

 * Package no longer depends on **R.cache** (only imports it).


# Version 2.8.6 [2013-04-21]

## Deprecated and Defunct

 * Made `is(Homo|Hetero)zygote()` and `getPhysicalPositions()`
   defunct.


# Version 2.8.5 [2013-04-08]

## Refactorization

 * Updated package dependencies.


# Version 2.8.4 [2013-03-28]

## New Features

 * Added the `sqrtsign()` transform.  This makes it possible to plot
   log2 PLM residuals (in **aroma.affymetrix**) on a blue-to-red scale
   using `setColorMaps(.., "log2,sqrtsigned,bluewhitered")` where
   `bluewhitered <- colorRampPalette(c("blue", "white", "red"))`.


# Version 2.8.3 [2013-03-23]

## Refactorization

 * Bumped the package dependencies.

 * Added an `Authors@R` field to DESCRIPTION.


# Version 2.8.2 [2013-03-05]

## Refactorization

 * Bumped up package dependencies.


## Documentation

 * Updated the help usage section for all static methods.


# Version 2.8.1 [2013-01-03]

## Refactorization

 * Some of the internal **aroma.core** code still called deprecated
   methods resulting in unnecessary warnings.


## Deprecated and Defunct

 * Deprecated `nbrOfArrays()` for AromaMicroarrayDataSet and
   AromaUnitTotalCnBinarySet.


# Version 2.8.0 [2012-12-21]

## New Release

 * No updates.

 * Bumped version for CRAN submission.


## Software Quality

 * Package passes all redundancy tests.


# Version 2.7.6 [2012-12-20]

## Refactorization

 * Utilizing new `startupMessage()` of **R.oo**.

 * Bumped up package dependencies.

 * Now using argument `colClasses` (was `colClassPatterns`) for all
   `readDataFrame()`:s.


# Version 2.7.5 [2012-12-06]

## Refactorization

 * ROBUSTNESS: Utilizing new `getOneFile()` internally.


# Version 2.7.4 [2012-12-04]

## Refactorization

 * CLEANUP: Dropped `inst/reports/templates/html/archive/`,
   `inst/reports/templates/rsp/archive/ and inst/archive/`, which all
   contained old/legacy Explorer versions.


# Version 2.7.3 [2012-11-29]

## Significant Changes

 * Renamed `lapply()` for AromaTabularBinaryFile to `colApply()`.


# Version 2.7.2 [2012-11-28]

## Refactorization

 * Made several file classes implement FileCacheKeyInterface.

 * Added CacheKeyInterface and FileCacheKeyInterface.


# Version 2.7.1 [2012-11-26]

## Significant Changes

 * Lowered the package dependencies to **aroma.light** (>= 1.22.0)
   such that this package can be installed easily on R (>= 2.14.0).


## Bug Fixes

 * `getRam()` and `setRam()` for AromaSettings did not use
   `memory/ram`.


# Version 2.7.0 [2012-11-24]

## New Release

 * Bumped version for CRAN submission.

 * No updates.


## Software Quality

 * Package passes all redundancy tests.


## Refactorization

 * Bumped up package dependencies.


# Version 2.6.16 [2012-11-21]

## New Features

 * Now `getParametersAsString()` handles sets of parameters as well.

 * Added `getParameterSets()` to ParametersInterface.


# Version 2.6.15 [2012-11-21]

## New Features

 * Added ParametersInterface.


## Documentation

 * Hiding more internal methods from the help indices.


# Version 2.6.14 [2012-11-18]

## Refactorization

 * Dropped `getHeaderParameters()` for TextUnitNamesFile, which is now
   done by `getHeader()` of TabularTextFile.

 * Package only depends on digest indirectly via **R.cache**.

 * Moved internal `.assertDigest()` to **R.cache**.

 * Now using `getName()` instead of deprecated `getLabel()`.


# Version 2.6.13 [2012-11-13]

## Refactorization

 * Properly declared all cached fields, making it possible to remove
   nearly all `clearCache()` implementations because the one for
   Object takes does the job.

 * The RSP template for ChromosomeExplorer's `setupExplorer.js` had a
   duplicated entry.


# Version 2.6.12 [2012-11-12]

## Refactorization

 * Now `seq_along(x)` instead of `seq(along = x)` everywhere.
   Similarly, `seq(ds)` where `ds` is GenericDataFileSet is now
   replaced by `seq_along(ds)`. Likewise, `seq_len(x)` replaces
   `seq(length = x)`, and `length(ds)` replaces `nbrOfFiles(ds)`.


# Version 2.6.11 [2012-11-08]

## Significant Changes

 * Renamed `getColumnNames()` to `getDefaultColumnNames()` for all
   classes inheriting from GenericTabularFile, because of the new
   ColumnNamesInterface interface.


## Software Quality

 * CRAN POLICY: Made a few of the examples faster. Also made some of
   the system tests faster.


# Version 2.6.10 [2012-11-05]

## Refactorization

 * CLEANUP: Replaced all `whichVector()` with `which()`, because the
   latter is now the fastest again.


# Version 2.6.9 [2012-10-31]

## New Features

 * Added argument `units` to `readDataFrame()` for
   AromaUnitChromosomeTabularBinaryFile.


# Version 2.6.8 [2012-10-29]

## Refactorization

 * Now using `Arguments$get(Read|Writ)ablePath()` instead of
   `filePath(..., expandLinks = "any")`.


# Version 2.6.7 [2012-10-21]

## New Features

 * Added argument `maxNAFraction` to CopyNumberChromosomalModel, which
   is now the prefer place to specify it, instead of to `fit()` etc.

 * Now `CopyNumberChromosomalModel()` accepts references of type
   `"none"`, `"constant(1)"`, `"constant(2)"`, and `"median"`, where
   `"none"` and `"constant(1)"` are identical, `"constant(2)"` uses
   reference signals that are exactly 2, and `"median"` uses reference
   signals are equals the robust average across all samples.  For
   backward compatibility, NULL is still supported, which equals
   `"median"`.


## Refactorization

 * ROBUSTNESS: Now using `Arguments$getWritablePath()` everywhere
   instead of `mkdirs()`, because the former will do a better job in
   creating and asserting directories on slow shared file systems, and
   when it fails it gives a more informative error message.


## Bug Fixes

 * Scrolling in the ChromosomeExplorer by dragging navigator bar was
   broken.


# Version 2.6.6 [2012-10-18]

## Significant Changes

 * It is no longer possible to have different *versions* of
   ArrayExplorer and ChromosomeExplorer under the same reports/
   directory structure. If you wish to keep old Explorer reports,
   rename those reports/ root directories.


## Bug Fixes

 * Some of the HTML and CSS errors in ArrayExplorer and
   ChromosomeExplorer that were detected by the W3's online validation
   services were correct.

 * A few errors in the JavaScript of ArrayExplorer has been
   corrected. It also does a better job of inferring the height of the
   displayed spatial image. Thanks Laurent Malvert (ID Business
   Solutions Ltd; IDBS) for the report, troubleshooting and
   suggestions on this.


# Version 2.6.5 [2012-10-17]

## Refactorization

 * ROBUSTNESS: Now all static `Object` methods that calls "next"
   methods, utilizes `NextMethod()`, which became possible with
   **R.oo** v1.10.0.


# Version 2.6.4 [2012-10-16]

## Bug Fixes

 * ROBUSTNESS/BUG FIX: No longer passing '...' to `NextMethod()`,
   cf. R-devel thread 'Do *not* pass '...' to NextMethod() - it'll
   do it for you; missing documentation, a bug or just me?' on Oct 16,
   2012.


# Version 2.6.3 [2012-10-14]

## Refactorization

 * Added AromaUnitGcContentFile (from **aroma.affymetrix**).


## Deprecated and Defunct

 * CLEANUP: Removed several defunct/obsolete methods and made
   deprecated methods defunct/obsolete.


# Version 2.6.2 [2012-10-11]

## Refactorization

 * Now **aroma.core** imports **R.methodsS3** and **R.oo**.  This solves
   issues such as `trim()` being overridden by ditto from the IRanges
   package, iff loaded.


# Version 2.6.1 [2012-09-14]

## New Features

 * Added `exportAromaUnitPscnBinarySet()` for a list.


## Bug Fixes

 * `exportAromaUnitPscnBinarySet()` for AromaUnitTotalCnBinarySet
   would throw an error if the files of the exported data set was
   ordered in a non-lexicographic order.


# Version 2.6.0 [2012-09-05]

## New Release

 * Submitted to CRAN.


## Software Quality

 * The package passes all redundancy tests.


# Version 2.5.14 [2012-09-04]

## New Features

 * Added `downloadUGC()` for AromaRepository.


# Version 2.5.13 [2012-09-02]

## Bug Fixes

 * `interleave()` for Image and RasterImage could generate error
 `'Error in if (abs(vRatio) > abs(hRatio)) { : missing value where
 TRUE/FALSE needed` if odd/even cell intensity columns (rows)
 contained all NAs.


# Version 2.5.12 [2012-08-31]

## Software Quality

 * Now `downloadCDF()` for AromaRepository downloads CDFs regardless
   of `*.cdf` and `*.CDF`.


# Version 2.5.11 [2012-08-29]

## New Features

 * ROBUSTNESS: Added argument `escape` to `findAnnotationData()`,
   which causes such symbols that exist in argument `pattern` to be
   automatically be escaped.


# Version 2.5.10 [2012-08-26]

## Documentation

 * Clarified that when `colBinnedSmoothing()` is done over zero-length
   bins, the output for those bins will be NA.


## Bug Fixes

 * `colBinnedSmoothing(..., xOut = xOut)` would return binned values
   in the incorrect order, iff `xOut` was not ordered.  Added a
   systems test for this case.

 * `colBinnedSmoothing(..., xOut = xOut)` could generate bins at the
   ends that did not contain the outer most `xOut` values.


# Version 2.5.9 [2012-08-22]

## Refactorization

 * Improved the AromaRepository class.


# Version 2.5.8 [2012-08-21]

## Refactorization

 * ROBUSTNESS: Now the package startup message is outputted at the
   very end.  Previously it was done before some additional setup,
   which could potentially fail.

 * ROBUSTNESS: `fitWRMA()` and `fitWHRCModel()` now call
   `rcModelWPLM()` of **preprocessCore** instead of `.Call(...,
   PACKAGE = "preprocessCore")`. Doing so will somewhat slow down the
   speed, because `rcModelWPLM()` introduces some non-needed
   validation of the arguments. This caused their arguments `psiCode`
   and `psiK` to be dropped.


# Version 2.5.7 [2012-08-08]

## Refactorization

 * ROBUSTNESS: Added **preprocessCore** as a suggested package,
   because some of the internal functions rely on that package.  This
   was never an issue, because those functions were called by wrapper
   functions in **aroma.affymetrix** that assert that the package is
   indeed loaded.


# Version 2.5.6 [2012-07-21]

## New Features

 * Added `exportAromaUnitPscnBinarySet()` for
   AromaUnitTotalCnBinarySet.

 * Added alpha versions of classes `AromaUnitPscnBinary(File|Set)`.

 * Added `getNumberOfFilesAveraged()` to
   AromaUnitSignalBinaryFile. Formerly only for
   AromaUnitTotalCnBinaryFile.


# Version 2.5.5 [2012-07-17]

## Refactorization

 * Updated package dependencies.


# Version 2.5.4 [2012-07-10]

## Refactorization

 * Now package imports **R.devices**, because it uses some of its
   device drivers that previously were in **R.utils**.


# Version 2.5.3 [2012-06-18]

## Bug Fix

 * Fixed a typo in an error message generated by `byChipType()` for
   several annotation data file classes.


# Version 2.5.2 [2012-05-30]

## New Features

 * Added argument `calculateRatios` to `CopyNumberChromosomalModel()`.


## Refactorization

 * Updated package dependencies.


# Version 2.5.1 [2012-04-16]

## Refactorization

 * CLEANUP: Package now only depends/imports on CRAN package, which
   simplifies the installation of **aroma.core**, and indirectly any
   packages that depends on it.  Note, there are still "suggested"
   non-CRAN packages, which are required by some/optional methods.

 * CLEANUP: Package no longer depends on **aroma.light**, but instead
   it "suggests" it.  This is possible, because now `weightedMad()` of
   **aroma.light** has been added to **matrixStats** v0.5.0.

 * CLEANUP: Package no longer "Suggests" affxparser.  It was needed
   because of the `findFiles()` function, which has been added to
   **R.utils** v1.13.1.


# Version 2.5.0 [2012-03-25]

## New Release

 * Submitted to CRAN.


## Software Quality

 * The package passes all redundancy tests.


# Version 2.4.13 [2012-03-23]

## New Features

 * Added alpha versions of PairedPSCNData and NonPairedPSCNData, which
   inherits from RawGenomicSignals.


## Refactorization

 * Turned `weightedMad()` into a default method, added help
   documentation with example code.

 * CLEANUP: Moved (internal) `swapXY()` and `draw()` for `density`
   objects to **R.utils** (>= 1.10.0).


## Bug Fixes

 * `[()` for RichDataFrame would loose the class attribute, unless
   argument `drop` was FALSE.


# Version 2.4.12 [2012-03-15]

## New Features

 * Now `colBinnedSmoothing()`, `colKernelSmoothing()` and
   `colGaussianSmoothing()` returns a matrix with column names as in
   argument `Y`.

 * For RawGenomicSignals, added argument `fields` to
   `binnedSmoothing()` and `binnedSmoothingByField()`.  Also added
   argument `field` to `getSignals()` and
   `estimateStandardDeviation()`.


## Refactorization

 * Now RawGenomicSignals extends new internal RichDataFrame class.


## Deprecated and Defunct

 * Dropped deprecated files from the `reports/includes/js/` directory
   installed by ArrayExplorer and ChromosomeExplorer.


# Version 2.4.11 [2012-03-12]

## New Features

 * Added `binnedSmoothingByField()` for RawGenomicSignals.

 * Added `subset()` for RawGenomicSignals.

 * Added get- and `setVirtualField()` for RawGenomicSignals.

 * Added argument `sort` to `as.data.frame()` for RawGenomicSignals.


# Version 2.4.10 [2012-03-06]

## Significant Changes

 * GENERALIZATION: The new ArrayExplorer v3.4 will work with most
   commonly used web browsers including Mozilla Firefox, Google
   Chrome, Microsoft Internet Explorer, Apple Safari, and Opera.


# Version 2.4.9 [2012-03-06]

## Significant Changes

 * ROBUSTNESS: Now all `writeDataFrame()` methods will add quotation
   marks around column names that contain a comment character
   (`#`). This will make the written file readable with `read.table()`
   even when there are header comments with prefix `#`.  This issue
   was reported by Yu Song at Oakland University.

 * Now `createImage()` for matrix creates images of type
   `"png::array"` by default (used to be `"EBImage::Image"`).  If the
   latter, then at least **EBImage** v3.9.7 (July 2011) is required.


## Bug Fixes

 * `write()` for RasterImage would write truncated intensities,
   because we forgot to rescale [0,65535] to [0,1] intensities.


# Version 2.4.8 [2012-03-02]

# Version 2.4.7 [2012-03-01]

## Software Quality

 * ROBUSTNESS: Added system tests for RawGenomicSignals classes.

 * CLEANUP: Now `R CMD check` no longer reports that the package is
   using `.Internal()` function calls.  This was due to how we
   adjusted `colSums()` and `colMeans()` to become generic functions.


## Refactorization

 * Preparing for RawGenomicSignals not being reference variables.

 * Preparing for supporting multiple-chromosome RawGenomicSignals.


# Version 2.4.6 [2012-02-04]

## Significant Changes

 * Created ChromosomeExplorer v3.4, which should work on even more
   browsers.


## New Features

 * GENERALIZATION: Now `binnedSmoothing()` of RawGenomicSignals
   default to generate the same target bins as `binnedSmoothing()` of
   a numeric vector. Before the bins had to be specified explicitly by
   the caller.

 * GENERALIZATION: Now it is possible to call `colBinnedSmoothing()`
   with an empty set of input loci, but still requesting a set of
   output loci, which then will be all missing values.


## Bug Fixes

 * Argument `x` of `colBinnedSmoothing()` would default to the
   incorrect number of loci.


# Version 2.4.5 [2012-02-03]

## Significant Changes

 * GENERALIZATION: As ChromosomeExplorer v3.3, the new ArrayExplorer
   v3.3 works with most common web browsers. See below.  However, we
   still have problems getting ArrayExplorer to load the main spatial
   (PNG) image in Internet Explorer.


## Bug Fixes

 * Forgot to include `require.js` in v2.4.4, which is needed by the
   ChromosomeExplorer v3.3.


# Version 2.4.4 [2012-02-01]

## Significant Changes

 * GENERALIZATION: The new ChromosomeExplorer v3.3 will work with most
   commonly used web browsers including Mozilla Firefox, Google
   Chrome, Microsoft Internet Explorer, Apple Safari and Opera.  This
   far it has been tested with the following browsers: Firefox
   v3.6/v9.01/v10.0, Chrome v17.0, IE v7.x/v9.0, and Safari 5. NOTE:
   To update an existing ChromosomeExplorer report, call `setup(ce,
   force = TRUE)` where `ce` is your ChromosomeExplorer object. Thanks
   to Keith Ching at ConsultChing for the initial troubleshooting
   [`http://consultching.com/root/?p=64`] leading me on the right
   track on how update ChromosomeExplorer.


# Version 2.4.3 [2012-01-17]

## Software Quality

 * ROBUSTNESS: Now `findPngDevice()` tries all the available settings
   for argument "type" of `png()`, for the current platform.  This
   will increase the chances for finding a PNG device that really
   works.


## Refactorization

 * CLEANUP: Now `findPngDevice()` uses `isPackageInstalled("Cairo")`
   instead of `require("Cairo")` to avoid loading **Cairo** if not
   really used.


## Performance

 * SPEEDUP: Now `findPngDevice()` memoizes the results throughout the
   current session.


# Version 2.4.2 [2012-01-14]

## Significant Changes

 * Added tag `hg17` to
   `Human,cytobands,hg17,GLADv2.4.0,HB20100219.txt` in
   `annotationData/genomes/Human/`.


## Bug Fixes

 * `drawCytoband()` for ChromosomalModel failed to locate the genome
   annotation data file containing cytoband information,
   e.g. `Human,cytobands,<tags>.txt`. Thanks to Kai Wang at Pfizer for
   reporting on this.


# Version 2.4.1 [2012-01-12]

## Significant Changes

 * Package now requires R (>= 2.12.0).


## Refactorization

 * CLEANUP: Dropped internal patch of `base::serialize()`, because it
   was only applied to R (< 2.12.0) anyway and this package now
   requires R (>= 2.12.0).


# Version 2.4.0 [2012-01-11]

## Refactorization

 * ROBUSTNESS: Aroma settings are no longer loaded during `R CMD
   check`.

 * Updated package dependencies.


# Version 2.3.7 [2011-12-22]

## Bug Fixes

 * The overridden `library()` would always return an `invisible()`
   object, even if `base::library()` wouldn't.  This caused plain
   `library()` to not list installed packaged.  Thanks Venkat Seshan
   at MSKCC for reporting on this.


# Version 2.3.6 [2011-12-15]

## New Features

 * Now `colBinnedSmoothing()` handles an unordered `xOut`.

 * Added argument `units` to `writeDateFrame()` for
   AromaUnitSignalBinarySet to make it possible to write any subset of
   units and in any order, e.g. genome order.


# Version 2.3.5 [2011-12-11]

## New Features

 * Now it is possible to fully specify the location and the width of
   each bin used by `colBinnedSmoothing()`, which now also returns the
   bin counts as part of the attributes.  Moreover, the bins are now
   defined to be strictly disjoint using boundaries [x0,x1) instead of
   [x0,x1] as before.

 * Added `plotCoverageMap()` for AromaUgpFile.


# Version 2.3.4 [2011-11-19]

## New Features

 * Added default `getDefaultExtension()` for UnitAnnotationDataFile,
   which guesses the filename extension from the class name, unless
   overridden by a subclass.


## Software Quality

 * Now `byChipType()` for UnitAnnotationDataFile and derivatives give
   an error message with more information on which file it failed to
   locate, e.g. by specifying filename extension it looked for.

 * CLEANUP: Now `getFullNames()` for AromaMicroarrayDataSetTuple no
   longer produces a warning on `is.na() applied to non-(list or
   vector) of type 'NULL'`.


## Bug Fixes

 * `exportTotalCnRatioSet()` for AromaUnitTotalCnBinarySet and
   `exportFracBDiffSet()` for AromaUnitTotalCnBinarySet tried to call
   `cat(verbose, x)` with `length(x) > 1`.


# Version 2.3.3 [2011-11-17]

## New Features

 * Added trial version of AromaUcscGenomeTextFile.


# Version 2.3.2 [2011-11-14]

## Bug Fixes

 * `process()` of ChromosomeExplorer would throw `Error in file(file,
   ifelse(append, "a", "w")) : [...] cannot open file '/ [...] (new
   Array(': No such file or directory`.  Importing the **R.rsp**
   namespace in the **aroma.core** namespace solved this. Thanks Qian
   Liu for reporting on this.


# Version 2.3.1 [2011-11-11]

## New Features

 * Added `extractPSCNArray()` for AromaUnitTotalCnBinary{File|Set}.


# Version 2.3.0 [2011-10-28]

## Software Quality

 * Added a namespace to the package, which will be more or less a
   requirement starting with R v2.14.0.


# Version 2.2.2 [2011-09-29]

## New Features

 * Added alpha version of the AromaRepository class.


# Version 2.2.1 [2011-09-24]

## Bug Fixes

 * `readHeader()`, `readRawFooter()` and `writeRawFooter()` of
   AromaTabularBinaryFile would try to read non-signed 4-byte
   integers, which is not supported and would instead be read as
   signed integers. From R v2.13.1 this would generated warnings.


# Version 2.2.0 [2011-09-01]

## New Release

 * Submitted to CRAN.


## Software Quality

 * The package passes all redundancy tests.


# Version 2.1.5 [2011-08-30]

## Bug Fixes

 * After introducing a sanity check in **aroma.core** v2.1.2
   (2011-05-11), `getSnpPositions()` of AromaCellSequenceFile would
   throw `Error: length(pos) == ncol(cells) is not TRUE`.  However, it
   was not until **aroma.core** v2.1.3 (2011-08-01) was release that
   some people got problem with this.  It turns out that the sanity
   check catches an error in how `getSnpPositions()` of
   AromaCellSequenceFile allocates the result vector, a bug that has
   been there for a very long time. Luckily, this bug has had no
   effect on the results for anyone. Thanks to David Goode (Stanford)
   and Irina Ostrovnaya (MSKCC) for reporting on this.


# Version 2.1.4 [2011-08-02]

## Bug Fixes

 * The **aroma.core** v2.1.3 tar ball uploaded to CRAN mistakenly
   contained a NAMESPACE file, which shouldn't have been there.


# Version 2.1.3 [2011-07-27]

## Refactorization

 * WORKAROUND: In order for the package to work with the most recent
   version of R devel, which automatically add namespaces to packages
   who do not have one, we explicitly have specify that this package
   should use `cat()` and `getOption()` of **R.utils** (instead of
   'base').


# Version 2.1.2 [2011-07-24]

## Refactorization

 * Bumped up the package dependencies, especially since R will soon
   (in practice) require namespaces for all packages.


# Version 2.1.1 [2011-05-10]

## Software Quality

 * ROBUSTNESS: Added more sanity checks and more verbose output to
   `getSnpNucleotides()` for AromaCellSequenceFile.


# Version 2.1.0 [2011-04-08]

## New Release

 * No updates.  Submitted to CRAN.


# Version 2.0.8 [2011-04-03]

## Refactorization

 * CLEANUP: Utilizing `hpaste()` internally wherever applicable.


# Version 2.0.7 [2011-03-28]

## Bug Fixes

 * `allocateFromUnitAnnotationDataFile()` for
   AromaUnitTabularBinaryFile would include chip type tags in the
   path, e.g. `annotationData/chipTypes/GenomeWidesSNP_6,Full`.


# Version 2.0.6 [2011-03-14]

## New Features

 * Now ChromosomeExplorer does a better job of listing chromosomes
   that are specific to the genome/organism used.

 * Added `getChromosomeLabels()` for ChromosomeExplorer.


# Version 2.0.5 [2011-03-04]

## Bug Fixes

 * `lapplyInChunks(idxs)` for numeric did not correctly handle the
   case when `length(idxs) == 0`, because of a typo.


# Version 2.0.4 [2011-03-03]

## Significant Changes

 * Updated the default filename patterns used by `findByGenome()` for
   AromaGenomeTextFile to `"^%s,chromosomes(|,.*)*[.]txt$"`.

 * GENERALIZATION: Now `findByGenome()` for AromaGenomeTextFile
   follows the new aroma search conventions.

 * GENERALIZATION: In addition to search `<rootPath>/<set>/<name>`
   paths, `findAnnotationData()` can also search `<rootPath>/<set>/`
   by not specifying argument `name` (or setting it to NULL).  Also,
   if it cannot locate any files, it falls back to annotation data
   available in any of the ** aroma.* ** packages.


## New Features

 * Now `getGenomeFile()` for ChromosomalModel utilizes `byGenome()`
   for AromaGenomeTextFile to locate the genome annotation file.

 * Added static `loadAll()` for SampleAnnotationSet.


## Software Quality

 * ROBUSTNESS: Added a return contract/sanity check asserting that
   `getUnitsOnChromosomes()` for AromaUnitChromosomeTabularBinaryFile
   truly returns valid `unit` indices.  Thanks to Emilie Sohier,
   France for reporting on a problem related to this.


# Version 2.0.3 [2011-03-02]

## Significant Changes

 * STANDARDIZATION: Now the default output path for all
   `allocateFromUnitAnnotationDataFile()` is
   `annotationData/chipTypes/<chipType>/`.  Before it was the same
   directory as the original annotation data file, which may for
   instance have been in a deeper subdirectory, or recently also in a
   sibling root path.

 * GENERALIZATION: `getAverageFile()` for AromaUnitTotalCnBinarySet
   first searches for an existing result file according to the new
   search conventions.  If not found, then it's created.

 * GENERALIZATION: Now the default for `createImage()` for matrix is
   to test to create images according to aroma settings option
   `output/ImageClasses`.


## Software Quality

 * ROBUSTNESS: Now `getAverageFile()` for AromaUnitTotalCnBinarySet
   creates the result file atomically by writing to a temporary file
   which is renamed afterward.

 * Now `write()` and `read()` for RasterImage throws an informative
   error message explaining that the **png** package is needed.


## Bug Fixes

 * `colorize()` for Image would throw `<simpleError in ...: could not
   find function "colorMode">`, because the `colorMode()` function
   needs to be explicitly imported after the recent package cleanups.

 * `colorize()` for Image tried to call `createImage()` using a vector
   instead of a matrix.

 * `createImage()` for matrix would not return the first possible
   image created (when testing different image classes) but instead
   continue trying to create image for all possible classes.  For
   instance, this meant that although you had the `**EBImage**`
   package installed, but not the **png** package, it would still in
   the end try to (also) use **png** package.  If writing PNG images
   to file, say via ArrayExplorer, this would result in `Error in
   loadNamespace(name) : there is no package called 'png'`.  Thanks
   Richard Beyer at University of Washington for reporting on this.


# Version 2.0.2 [2011-02-19]

## Significant Changes

 * GENERALIZATION: Extended the default root paths of
   `findAnnotationData()` to be `annotationData/` and
   `annotationData,<tags>/`.


# Version 2.0.1 [2011-02-19]

## Refactorization

 * CLEANUP: Moved static `getTags()` to Arguments to **R.filesets**
   v0.9.3.


## Deprecated and Defunct

 * Deprecated static method `importFromTable()` for FileMatrix.

 * Removed several deprecated methods.


# Version 2.0.0 [2011-02-16]

## New Release

 * Submitted to CRAN.

 * No updates.


# Version 1.9.4 [2011-02-07]

## Software Quality

 * CLARIFICATION: Now the exception thrown by `getRawCopyNumbers()`
   for CopyNumberSegmentationModel, when there are too many non-finite
   signals, gives a more informative error message containing
   information also on which sample, reference and chromosome the
   problem was detected on.


## Bug Fixes

 * Now `fit()` for CopyNumberSegmentationModel passes down argument
   `maxNAFraction` to the internal sanity test as it used to do before
   **aroma.core** v1.3.4 (November 2009).


# Version 1.9.3 [2011-02-01]

## New Features

 * GENERALIZATION: Now spatial PNG image files can also be created
   utilizing the **png** package as an alternative to the **EBImage**
   package.  The **EBImage** package can be tricky to install on some
   OSes, e.g. MS Windows 7 64-bit.

 * Added alpha version of an internal RasterImage class.


## Refactorization

 * Added an internal `writeImage()` for Image objects as defined by the **EBImage** package.  This made it possible to remove the remaining explicit dependencies on **EBImage** in the **aroma.affymetrix** package.


## Software Quality

 * ROBUSTNESS: Removed some remaining partial argument calls.


## Deprecated and Defunct

 * Deprecated internal `as.TrueColorImage()` for Image and for matrices.

 * Removed deprecated internal `rgbTransform()` for Image.


# Version 1.9.2 [2011-01-30]

## Performance

 * SPEEDUP: The memoization/caching mechanisms should now be faster on
   MS Windows, because `digest()` uses the faster `serialize()` of R
   v2.12.0.  The earlier version was orders of magnitude slower on
   MS Windows, which we have been patching in the aroma framework since
   v0.9.3.4.  That patch wrote to file, which was slower than the
   recent fix.  This Windows-only patch is no longer needed, and hence
   neither applied, on R v2.12.0 and beyond.


# Version 1.9.1 [2011-01-14]

## Significant Changes

 * Added argument `flavor` to `segmentByGLAD()` for RawGenomicSignals,
   which makes it possible to specify whether `daglad()` or `glad()`
   of the **GLAD** package will be used.  The `flavor` argument can
   also be passed as for instance `GladModel(..., flavor = "daglad")`.


# Version 1.9.0 [2011-01-10]

## New Release

 * No updates.  Submitted to CRAN.


# Version 1.8.3 [2010-12-27]

## New Features

 * Added genome annotation file `Mouse,chromosomes.txt` to
   `system.file("annotationData/genomes/Mouse", package =
   "aroma.core")`.


# Version 1.8.2 [2010-12-07]

## Software Quality

 * ROBUSTNESS: Whenever the **GLAD** package is tried to be loaded and
   it fails due to failure of loading a shared library, then this will
   be remembered for 24 hours while it will not be loaded again.

 * Added `requireWithMemory()`.


# Version 1.8.1 [2010-12-02]

## Bug Fixes

 * `plot()` for CopyNumberSegmentationModel would throw exception
   `Cannot infer number of bases in chromosome. No such chromosome:
   25` for chromosome 25.

 * `drawCytoband2()` would throw an error if argument `cytoband` was
   an empty data frame, which could happen if there is no cytoband
   annotation data for the requested chromosome.  Now it returns
   quietly.


# Version 1.8.0 [2010-11-07]

## New Release

 * Committed to CRAN.


## Refactorization

 * CLEANUP: Dropped non-used JavaScript toolkit code that was intended
   to be used for a future version of ChromosomeExplorer.


# Version 1.7.6 [2010-11-06]

## Refactorization

 * ROBUSTNESS: Now `subsample()` for BinnedScatter utilizes
   `resample()`.

 * CLEANUP: Removed `stext()`.  It is in **R.utils**.

 * CLEANUP: Removed some outdated patches for R v2.7.0 and before.

 * CLEANUP: Package no longer need to "suggest" **geneplotter**.


# Version 1.7.5 [2010-10-25]

## New Features

 * Now `fit()` for CopyNumberSegmentationModel also passed the
   optional arguments (`...`) passed to the constructor function.
   This makes it possible to specify all arguments while initiating
   the model, e.g. `sm <- CbsModel(..., min.width=5, alpha=0.05)`.

 * Now optional arguments `...` to CopyNumberChromosomalModel are
   recorded.


# Version 1.7.4 [2010-10-13]

## Software Quality

 * ROBUSTNESS/BUG FIX: The internal `drawCytoband2()` used to annotate
   chromosomal plots with cytobands tries to utilize **GLAD** package,
   if available.  However, even when **GLAD** is installed it may
   still be broken due to missing dynamic libraries, e.g. `Error in
   library.dynam(lib, package, package.lib) : DLL GLAD not found:
   maybe not installed for this architecture?`.  We now avoid this
   too.


# Version 1.7.3 [2010-09-12]

## New Features

 * Added `drawDensity()` for CopyNumberRegions and RawGenomicSignals.

 * Added `getDensity()` for CopyNumberRegions which returns the
   empirical density of the mean levels weighted by the region
   lengths.

 * Added `getLength()` for CopyNumberRegions, which returns a vector
   of region lengths.

 * Now the ylim defaults to `c(0,5)` for `plot()` for RawCopyNumbers.

 * Added basic support for operators `+`, `-`, and `*` to
   RawGenomicSignals.


# Version 1.7.2 [2010-08-22]

## New Features

 * Added the AromaGenomeTextFile class.

 * Added genome annotation file
   `Canine,chromosomes,UGP,HB20100822.txt` to
   `system.file("annotationData/genomes/Canine", package =
   "aroma.core")`.


## Bug Fixes

 * `annotationData/genomes/Human/Human,chromosomes.txt` had an extra
   TAB on the ChrM row.


# Version 1.7.1 [2010-08-06]

## New Features

 * Added abstract classes SegmentationDataFile and SegmentationDataSet
   to represent segmentation data results.  Current subclasses are
   `CbsSegmentationData(File|Set)`.

 * Added more utility methods for CopyNumberRegions.


# Version 1.7.0 [2010-07-26]

## New Release

 * Committed to CRAN. No updates.


# Version 1.6.8 [2010-07-24]

## New Features

 * Added several methods for CopyNumberRegions, e.g. `xRange()`,
   `prune()`, `simulateRawCopyNumbers()`, `+()`, `-()` and `*()`.


# Version 1.6.7 [2010-07-20]

## Bug Fixes

 * Added `writeDataFrame()` for AromaUnitTotalCnBinarySet and
   AromaUnitFracBCnBinarySet to get the correct filename
   extension. Thanks Nicolas Vergne at the Curie Institute for
   reporting this.


# Version 1.6.6 [2010-07-19]

## New Features

 * Added `subset()` for CopyNumberRegions.

 * Now `extractRegion()` for RawGenomicSignals also accepts a
   CopyNumberRegions object for argument `regions`.

 * Added `extractRegions()` for RawGenomicSignals.


# Version 1.6.5 [2010-07-08]

## Bug Fixes

 * `writeDateFrame()` for AromaUnitSignalBinarySet would write the
   same data chunk over and over.


# Version 1.6.4 [2010-07-06]

## Bug Fixes

 * `indexOf()` for ChromosomalModel would return NA if a search
   pattern contained parenthesis `(` and `)`.  There was a similar
   issue in `indexOf()` for GenericDataFileSet/List in **R.filesets**,
   which was solved in **R.filesets** 0.8.3. Now `indexOf()` for
   ChromosomalModel utilizes ditto for GenericDataFileSet for its
   solution.


# Version 1.6.3 [2010-06-22]

## Bug Fixes

 * `as.GrayscaleImage(..., transforms = NULL)` for `matrix` would
   throw `Exception: Argument transforms contains a non-function:
   NULL`.


# Version 1.6.2 [2010-06-02]

## Bug Fixes

 * `updateDataColumn()` of AromaTabularBinaryFile would censor *signed
   integers* incorrectly; it should censor at/to [-(n+1),n], but did
   it at [-n,(n+1)] ("two's complement").  This caused it to write too
   large values as n+1, which then would be read as -(n+1),
   e.g. writing 130 would be censored to 128 (should be 127), which
   then would be read as -128. Added more detailed information on how
   many values were censored. Thanks Robert Ivanek for report on this.


# Version 1.6.1 [2010-05-27]

## New Features

 * Added trial version of fullname translator files.

 * `doCBS()` for character:s support data set tuples.

 * Added `doCBS()` for CopyNumberDataSetTuple:s.


# Version 1.6.0 [2010-05-14]

## New Release

 * Package submitted to CRAN.


## Software Quality

 * Package passes `R CMD check` on R v2.11.0 and v2.12.0 devel.


# Version 1.5.8 [2010-05-13]

## Significant Changes

 * Now argument `path` of all `writeDataFrame()` methods defaults to
   `<rootPath>,txt/<dataSet>/<chipType>/`.


# Version 1.5.7 [2010-04-27]

## New Features

 * Added `writeDataFrame()` for AromaUnitTabularBinaryFile.

 * Added argument `columnNamesPrefix` to all `writeDataFrame()`.

 * AD HOC: Now `getUnitAnnotationDataFile()` of AromaPlatformInterface
   load **aroma.affymetrix** if needed and if installed.


# Version 1.5.6 [2010-04-22]

## New Features

 * Added `writeDataFrame()` for AromaUnitSignalBinary{File|Set}.


# Version 1.5.5 [2010-04-12]

## Bug Fixes

 * `getFitFunction()` of CbsModel would return a function that would
   give `Error in segmentByCBS.RawGenomicSignals(..., seed = seed):
   formal argument "seed" matched by multiple actual arguments`.


# Version 1.5.4 [2010-04-06]

## New Features

 * Added `equals()` for CopyNumberRegions.

 * Added argument `seed` to CbsModel, which will, if specified, set
   the random seed (temporarily) each time (per sample and chromosome)
   before calling the segmentation method.


# Version 1.5.3 [2010-04-05]

## New Features

 * Added argument `seed` to `segmentByCBS()` for RawGenomicSignals.


# Version 1.5.2 [2010-03-29]

## Refactorization

 * ROBUSTNESS: Increased the requirements of support packages.


# Version 1.5.1 [2010-03-02]

## Significant Changes

 * CHANGE: Argument `arrays` of `doCBS()` for CopyNumberDataSet no
   longer subset the input data set, but instead is passed to the
   `fit()` function of the segmentation model.  This way all arrays in
   the input data set are still used for calculating the pooled
   reference.

 * Now `segmentByMPCBS()` can be used to segment data from a single
   source.


## Software Quality

 * ROBUSTNESS: Added more sanity checks to `segmentByMPCBS()` for
   RawGenomicSignals.


## Bug Fixes

 * Forgot argument `verbose` of `getOutputSet()` of ChromosomalModel.


# Version 1.5.0 [2010-02-22]

## New Release

 * Submitted to CRAN.

 * No changes since v1.4.7.


## Software Quality

 * Package passes `R CMD check` on R v2.10.1 patch and R v2.11.0
   devel.

 * Package passes all redundancy tests.


# Version 1.4.7 [2010-02-21]

## New Features

 * Added the AromaCellCpgFile class.


## Documentation

 * Added Rd help for AromaCellPositionFile class.


# Version 1.4.6 [2010-02-19]

## New Features

 * Argument `zooms` of ChromosomeExplorer now default to 2^(0:6),
   instead of 2^(0:7), because the images for zoom 2^7=128 would not
   display in Firefox for the largest chromosomes.

 * Updated `getGenomeFile()` for ChromosomalModel such that it can be
   used to locate other types of genome annotation files as well,
   files that may be optional (without giving an error).

 * Added Human cytoband files to `annotationData/genomes/`.

 * Added `annotationData/genomes/` to **aroma.core** (from
   **aroma.affymetrix**).

 * Added `getOutputSet()` for ChromosomalModel.

 * Added alpha version of a `doCBS()`.


## Software Quality

 * SIMPLIFICATION: Now it is possible to use ChromosomeExplorer
   without having to install the **GLAD** package (used before for
   cytobands).

 * SIMPLIFICATION: Now it is possible to plot cytobands without having
   to install the **GLAD** package.


# Version 1.4.5 [2010-02-10]

## Software Quality

 * ROBUSTNESS: Now also patches for **R.filesets** and **R.utils** are
   loaded, if available, when **aroma.core** is loaded.


## Refactorization

 * CLEANUP: Removed debug `print()` statements in
   `isCompatibleWith()`.


# Version 1.4.4 [2010-02-03]

## Significant Changes

 * ROBUSTNESS: Package now requires **matrixStats** v0.1.9 or newer,
   due to a bug in the earlier versions that would affect smoothing of
   chromosomal signals that contains missing values.


## Software Quality

 * Package passes `R CMD check` and all redundancy tests.


# Version 1.4.3 [2010-01-25]

## Software Quality

 * ROBUSTNESS: Added a sanity check `getChromosomes()` for class
   AromaUnitChromosomeTabularBinaryFile validating that the file has a
   `chromosome` column.


## Refactorization

 * CLEANUP: Using new `Arguments$getTags()` where ever possible.


# Version 1.4.2 [2010-01-13]

## New Features

 * ChromosomalModel:s (and and the ChromosomeExplorer) no longer
   require unit names files.

 * `getListOfAromaUgpFiles()` for ChromosomalModel no longer goes via
   `getListOfUnitNamesFiles()`.  This opens up the possibility to work
   with data files without unit names files, e.g. smoothed CN data.

 * Added `getAromaUgpFile()` for AromaPlatformInterface.


## Refactorization

 * Now `getUnitNamesFile()` for AromaPlatformInterface utilizes the
   generic `getUnitAnnotationDataFile()` method.


# Version 1.4.1 [2010-01-06]

## New Features

 * Added argument `defaults` to `allocate()` of
   AromaTabularBinaryFile.


# Version 1.4.0 [2010-01-04]

## New Features

 * Added trial version of `segmentByMPCBS()` via the **mpcbs**
   package.


## Software Quality

 * Package passes `R CMD check` on R v2.10.1 and R v2.11.0 devel and
   all of its redundancy tests.


## Bug Fixes

 * Added `getDefaultFullName()` for AromaMicroarrayDataSet and
   AromaTabularBinarySet in order to override (`parent = 1`) the new
   default of GenericDataFileSet in **R.filesets** v0.7.0, which would
   return the chip type (`parent = 0`) as the name.


# Version 1.3.8 [2010-01-02]

## New Features

 * Added `getPairedNames()` to CopyNumberChromosomalModel which
   returns combined `<test>vs<ref>` names, e.g. `TumorvsNormal`.  The
   default behavior is that if `<ref>` is the average of a pool, then
   the paired name is `<test>`, e.g. `Tumor`.


## Refactorization

 * CLEANUP: Moved all GenericSummary code to **R.utils**.


# Version 1.3.7 [2010-01-01]

## New Features

 * Added argument `pattern` to `byName()` for
   AromaUnitTotalCnBinarySet and AromaUnitFracBCnBinarySet.

 * `getSets()` of AromaMicroarrayDataSetTuple overrides the default
   method by adding the chip types as the names of the returns list.


## Software Quality

 * ROBUSTNESS: Using new `Arguments$getInstanceOf()` were possible.

 * ROBUSTNESS: Now `CopyNumberChromosomalModel()` asserts that none of
   the test samples have duplicated names.

 * ROBUSTNESS: Now all index arguments are validated correctly using
   the new `max` argument of `Arguments$getIndices()`.  Before the
   case where `max == 0` was not handled correctly.


## Refactorization

 * CLEANUP: Removed `getSetTuple()` from ChromosomeExplorer.


## Bug Fixes

 * `translateFullNames()` of ChromosomeExplorer would translate the
   full names, but return the original ones.

 * `getFullNames()` of ChromosomeExplorer reported: `Error in
   UseMethod("translateFullNames"): no applicable method for
   translateFullNames applied to an object of class "character"`.


# Version 1.3.6 [2009-12-08]

## Bug Fixes

 * `extractMatrix()` of AromaUnitCallFile did not recognize `NoCalls`.


# Version 1.3.5 [2009-12-02]

## Bug Fixes

 * `extractRawCopyNumbers()` for RawCopyNumbers would give an error if
   the internal `logBase` was NULL.


# Version 1.3.4 [2009-11-24]

## Significant Changes

 * Now all chromosome plot functions have `xScale = 1e-6` by default.


## New Features

 * Added `extractRawCopyNumbers(, ...logBase = 2)` to RawCopyNumbers,
   which can be used to change the logarithmic base of CN ratios, if
   any.

 * Added `getAverageFile()` for AromaUnitTotalCnBinarySet.


## Refactorization

 * Moved ChromosomeExplorer to **aroma.core** from
   **aroma.affymetrix**.

 * Moved several method for `profileCGH` objects to **aroma.core**
   from **aroma.affymetrix**.


# Version 1.3.3 [2009-11-19]

## New Features

 * ALPHA: First successful run of segmentation with CbsModel with
   AromaUnitTotalCnBinarySet data sets.

 * Added `isAverageFile()` for AromaUnitSignalBinaryFile.

 * Added class AromaUnitTotalCnBinarySetTuple.

 * Added interfaces CopyNumberDataFile, CopyNumberDataSet, and
   CopyNumberDataSetTuple (internal for now).


## Refactorization

 * GENERALIZATION: Moved CbsModel, GladModel and HaarSegModel (all
   segmentation models) of **aroma.affymetrix** to here.

 * GENERALIZATION: Moved all (generalized) ChromosomalModel,
   CopyNumberChromosomalModel, and CopyNumberSegmentationModel from
   **aroma.affymetrix** to here.


# Version 1.3.2 [2009-11-12]

## New Features

 * Added `getAromaUflFile()` to UnitAnnotationDataFile.


## Refactorization

 * Moved AromaUflFile to **aroma.core** (from **aroma.affymetrix**).


## Bug Fixes

 * Now `AromaUflFile$allocateFromUnitNamesFile()` works.

 * `importFrom(ufl, dat, ...)` where `ufl` was an AromaUflFile and
   `dat` a GenericTabularFile gave an error reporting that
   `importFromGenericTabularFile()` is abstract/not defined for
   AromaUflFile:s. Thanks Paolo Guarnieri for reporting this.


# Version 1.3.1 [2009-11-03]

## Documentation

 * Replaced Rd cross references to **sfit** and **HaarSeg** packages
   with plain text in order to meet the CRAN requirements that all Rd
   links must exist on the CRAN servers.


# Version 1.3.0 [2009-11-01]

## New Release

 * New public release.

 * More recent dependencies on Bioconductor packages.


## Software Quality

 * Package passes `R CMD check` on R v2.10.0 and all redundancy tests.


# Version 1.2.3 [2009-10-25]

## New Features

 * Added `getExtensionPattern()` to most GenericDataFile classes.


# Version 1.2.2 [2009-10-16]

## New Features

 * Added `setName()` for RawGenomicSignals.


## Refactorization

 * Stricter dependencies.


# Version 1.2.1 [2009-10-02]

## Refactorization

 * CLEANUP: Updated to use `byPath()` instead `fromFiles()`.

 * CLEANUP: Move the Interface class to the **R.oo** package.


# Version 1.2.0 [2009-09-09]

## New Release

 * New public release.


## Software Quality

 * Package passes `R CMD check` on R v2.9.2 and all redundancy tests.


## Documentation

 * Fixed broken/missing Rd links.


# Version 1.1.7 [2009-09-07]

## Significant Changes

 * Now `getUnitsOnChromosomes()` for
   AromaUnitChromosomeTabularBinaryFile returns a vector by default
   (`unlist = TRUE`).


# Version 1.1.6 [2009-09-07]

## New Features

 * Added `yRange()`, `yMin()` and `yMax()` for RawGenomicSignals.

 * Added `extractRawCopyNumbers()` for RawSequenceReads.


## Bug Fixes

 * BUG FIX/WORKAROUND: `smoothScatter()`, which is used in for
   instance **aroma.affymetrix**, is in the **graphics** package from
   R v2.9.0.  It was previously in **geneplotter** v1.2.4 and
   before(!). The code imported it from **geneplotter** would
   therefore give an error of a missing function with **geneplotter**
   v1.2.5.  We are now assuming R v2.9.0 by default, but if not
   available, but **geneplotter** v1.2.4 or earlier is,
   **geneplotter** is loaded. If neither are available, a dummy
   `smoothScatter()` is setup reporting an error.


# Version 1.1.5 [2009-08-29]

## Significant Changes

 * Added `totalAndFracBData/` to the search path of `byName()` for
   AromaUnit(FracB|Total)CnBinarySet.


# Version 1.1.4 [2009-07-22]

## New Features

 * Added `allocateFromUnitAnnotationDataFile()` for
   AromaUnitSignalBinaryFile and AromaUnitTabularBinaryFile.

 * Added `getUnitTypesFile()` for AromaPlatform and
   AromaPlatformInterface.

 * Added UnitAnnotationDataFile, which now the UnitNamesFile and the
   new UnitTypesFile inherits from.

 * Now `uses()` for Interface takes multiple Interface:s.


# Version 1.1.3 [2009-07-03]

## New Features

 * Added class RawSequenceReads.

 * Added support for argument `byCount` to `binnedSmoothingByState()`
   of SegmentedCopyNumbers.  It is rather complex how it works, but we
   tried to immitate how it works with `byCount = FALSE`.

 * Now `binnedSmoothing()` of RawGenomicSignals demark locus fields
   that were not binned to be regular fields.  Ideally all locus
   fields (including custom ones) should be binned, but we leave that
   for a future implementation.

 * Added `get-`, `setStateColorMap()`, and `getStateColors()` for
   class SegmentedGenomicSignalsInterface.


# Version 1.1.2 [2009-06-14]

## New Release

 * This is the first version of **aroma.core** on CRAN.


## New Features

 * Added argument `keepUnits = FALSE` to `extractRawGenomicSignals()`
   of AromaUnitSignalBinaryFile.

 * Now `RawGenomicSignals(y = rgs)` sets all locus fields in `rgs` if
   it is a RawGenomicSignals object.


## Software Quality

 * Updated `examples()` that requires "suggested" packages to be ran
   conditionally, so that it does not throw an error (in `R CMD
   check`) if the packages is not available.  This is required for a
   package to be put on CRAN.


## Bug Fixes

 * `exportTotalCnRatioSet()` would return a AromaUnitFracBCnBinarySet.


# Version 1.1.1 [2009-06-10]

## Significant Changes

 * GRAMMAR FIX: `is(Homo|Hetero)zygous()`, not
   `is(Homo|Hetero)zygote()`.


## New Features

 * ADDED: Added support for "birdseed" encoding in
   `extractGenotypes()` and `updateGenotypes()` of
   AromaUnitGenotypeCallFile.

 * Added SegmentedGenomicSignalsInterface, which implements all the
   methods for SegmentedCopyNumbers and the new
   SegmentedAlleleBFractions.

 * Added `getFields()` to Interface as an ad-hoc solutions to avoid
   `print(<Interface>)` throwing `Error in UseMethod("getFields") : no
   applicable method for "getFields"`.


## Performance

 * SPEEDUP: `updateGenotypes()` of AromaUnitGenotypeCallFile is now
   much faster in counting A:s and B:s.


## Bug Fixes

 * `isHomozygote()` of AromaUnitGenotypeCallFile was not correct.

 * `getOutputDataSet()` of AromaTransform failed to identify the
   output files if (and only if) a filename translator was applied to
   the input data set.


# Version 1.1.0 [2009-05-29]

## New Release

 * New public release.

 * No updates.


## Software Quality

 * Package passes `R CMD check` on R v2.9.0 and all redundancy tests.


# Version 1.0.8 [2009-05-25]

## New Features

 * GENERALIZATION: The AromaTransforms class was generalized further
   to handle cases where the number of output files does not map one
   to one to the input files.


# Version 1.0.7 [2009-05-18]

## New Features

 * Added `extractRawAlleleBFractions()` for
   AromaUnitFracBCnBinaryFile.

 * Added `exportFracBDiffSet()` for AromaUnitFracBCnBinarySet.

 * ADDED: Now all `segmentByNnn()` for RawGenomicSignals also returns
   so called `aromaEstimates`, which are additional parameter
   estimates, e.g. robust estimates of the standard deviation of all
   full-resolution CNs as well as per identified region.


## Software Quality

 * ROBUSTNESS: Now `allocate()` for AromaTabularBinaryFile first
   allocates a temporary file which is then renamed.  This makes the
   file allocation more atomic, and therefore less error prone to
   interrupts etc.

 * ROBUSTNESS: Now `indexOf()` for UnitNamesFile assert that exactly
   one of the `pattern` and `names` arguments is given.  It also gives
   an informative error message if `pattern` is a vector.

 * ROBUSTNESS: Now all arguments that are expected to be exactly one
   character string (not an empty vector or a vector of length two)
   are asserted to be that too.  This closes some potential bugs.

 * EXCEPTION HANDLING: All methods that modifies an existing file, are
   now asserting that the file permissions allow modifying it, and if
   not gives a clear error message that this is the case.


## Performance

 * MEMORY OPTIMIZATION: Where ever possible/applicable, we now use
   `Arguments$getNumerics()`, which, in **R.utils** v1.1.5 and new,
   corces to doubles only if the input is not already doubles.  This
   will lower the memory usage in some cases since an integers use 4
   bytes and doubles 8 bytes.  This also save disk space if object is
   saved to disk, e.g. a DNAcopy fit object with integer genomic
   positions instead of double ones, save approx 5-7% disk space.


## Refactorization

 * Moved the Explorer class and its support files under `inst/` from
   **aroma.affymetrix** to **aroma.core**.

 * Moved the AromaCellPositionFile class from **aroma.affymetrix** to
   **aroma.core**.

 * CLEANUP: Moved all file set specific classes and methods to the
   new **R.filesets** package.


## Bug Fixes

 * `allocateFromUnitNamesFile()` for AromaUnitSignalBinaryFile would
   not call generic `allocate()` but the one for this class.

 * `extractMergedRawCopyNumbers(..., unshift = TRUE)` would estimate
   the relative shifts between platforms using smoothed CNs over the
   genomic region defined by the first data set.  Now it is done over
   the region defined by the union of all data sets.  The impact of
   this bug should be neglectable or zero.


# Version 1.0.6 [2009-05-14]

## Significant Changes

 * Now `binnedSmoothing()` of RawGenomicSignals uses weighted
   estimates (by default) if weights exists.


## New Features

 * Added `RawAlleleBFractions()` extending RawGenomicSignals.

 * Added `extractCopyNumberRegions()` for profileCGH, DNAcopy, and
   HaarSeg segmentation object. Before they were in
   **aroma.affymetrix**.

 * Added `segmentByCBS()`, `segmentByGLAD()`, and `segmentByHarSeeg()`
   to RawGenomicSignals, which all support weights if the underlying
   segmentation method does.  To date, it is only CBS and HaarSeg that
   supports weights.  These methods also support memoization.

 * Added `extractRegion()` to RawGenomicSignals.

 * Added `getWeights()` and `hasWeights()` to RawGenomicSignals.

 * Added {add,subtract,multiply,divide}`By()` for RawGenomicSignals
   all utilizing support method `applyBinaryOperator()`.

 * ALPHA: Added classes GenericDataFile{Set}List.

 * ALPHA: Added class AromaUnitTotalCnBinaryFileList with methods
   `extractRawCopyNumbers()` and `extractMergedRawCopyNumbers()`.


## Performance

 * SPEEDUP: Now TextUnitNamesFile caches all unit names in memory.


## Bug Fixes

 * Now **aroma.core** works with the **IRanges** and **grid**
   packages, regardless on the order they were loaded.

 * `getPlatform()` of TextUnitNamesFile would sometimes return a list
   of length one, instead of an single character string.

 * `extractSubset()` of RawGenomicSignals did not recognize all locus
   fields.


# Version 1.0.5 [2009-05-10]

## Significant Changes

 * Now `getOutputDataSet()` of AromaTransform returns a data set with
   files ordered such that the fullnames are ordered the same way as
   the input data set.  Suggested by Xin (Victoria) Wang at UC
   Berkeley.

 * Now `getOutputDataSet()` of AromaTransform scans for the output
   data files with fullnames matching those of the input data set.
   This is one step closer to being able to batch process subsets of
   data sets when the method is, say, a single-array method.

 * UPDATE: Replace argument `robust` of `colBinnedSmoothing()` with a
   more generic `FUN` argument.  The default arguments give identical
   results.


## New Features

 * Now static `fromFiles()` of GenericDataFileSet supports empty data
   sets.

 * Now `readDataFrame()` of AromaUgpFile and
   AromaUnitTabularBinaryFile accepts `rows = integer(0)`.

 * Added abstract class AromaUnitChromosomeTabularBinaryFile to make
   it easier to setup up new annotation file formats based on
   chromosomes. AromaUgpFile is now inheriting from this
   class. `getUnitsOnChromosomes()` now returns a list stratified by
   chromosome.

 * Added `extractByChromosomes()` for AromaUgpFile.

 * Added argument `translate` to `getColumnNames()` of
   TabularTextFile.


## Software Quality

 * Package passes `R CMD check` on R v2.9.0.


## Bug Fixes

 * Our internal `interleave()` for Image (defined by **EBImage**) gave
   `Error in z[idxOdd,, ] : incorrect number of dimensions`. This was
   because internal image structure of the Image class changed (back)
   to being a 2-dim array. Now `interleave()` handles both 2d and 3d
   arrays.

 * `lines()` of RawGenomicSignals did not recognize `xScale` and
   `yScale`.

 * `as.character()` of GenericDataFile would throw `Error in
   sprintf("%d", getFileSize(db, "numeric")) : use format %f, %e, %g
   or %a for numeric objects` whenever the file size is returned as a
   double, which happens for very large files (> 2^31-1 bytes).

 * `as.character()` of GenericDataFileSet would throw an error if the
   data set was empty, because then there was no path.


# Version 1.0.4 [2009-04-07]

## Bug Fixes

 * `getUnitNames(..., units = NULL)` of TextUnitNamesFile would make
   the object believe there are zero units in the file.  Thanks
   Shermane Teo at the National University of Singapore for reporting
   this.

 * `binnedSmoothing(..., byCount = TRUE)` of RawGenomicSignals would
   give error `[...] object "ys" not found`.

 * When passing a single data points to `colBinnedSmoothing()`, it
   would throw the exception: `Range of argument 'by' is out of
   range [0,0]: [<by>,<by>]`.


# Version 1.0.3 [2009-03-23]

## New Features

 * Added the TextUnitNamesFile class.


# Version 1.0.2 [2009-02-26]

## New Features

 * Added argument `units` to `extractRawCopyNumbers()` of
   AromaUnitSignalBinaryFile.

 * Added RawGenomicSignals which RawCopyNumbers now inherits from.

 * Added `readDataFrame(..., units = NULL)` to
   AromaUnitSignalBinaryFile.

 * Added optional argument/field `name` to RawCopyNumbers, which is
   also used by SegmentedCopyNumbers when querying the "truth"
   function(s) for the copy-number state.  This makes it possible to
   use one (conditional) truth functions for all samples.

 * Added `hasBeenModified()` to GenericDataFile.

 * Now `hasTags(..., tags)` of GenericData{File|Set} splits the `tags`
   argument.

 * Now `RawCopyNumbers()` takes RawCopyNumbers objects as input.

 * Now `as.character()` of GenericDataFile also reports the exact file
   size in case the file size is reported in kB, MB, etc.  It also
   tries to report the relative pathname rather than the absolute.


## Performance

 * Now `getChecksum()` of GenericDataFile caches results unless the
   file has been modified since last time.


# Version 1.0.1 [2009-02-12]

## Significant Changes

 * Now `byName()` of AromaUnit(FracB|Total)CnBinarySet searches
   `rawCnData/` then `cnData/`.


## New Features

 * Added SegmentedCopyNumbers class.

 * Added various smoothing methods to RawCopyNumbers.

 * Added `colBinnedSmoothing()` and `colKernelSmoothing()`.

 * Added `getAromaUgpFile()` to UnitNamesFile.

 * Added `shakyText()`.

 * Added static `byChipType()` to UnitNamesFile.

 * Added argument `fullname` to `getChipType()` of
   AromaUnitSignalBinaryFile.

 * Now argument `files` in `extract()` of GenericDataFileSet can also
   be a vector of string.

 * ALPHA: Added support for "smart" (e.g. `"*"`) subdirectories in
   static `findByName()` of GenericDataFileSet.


## Software Quality

 * ROBUSTNESS: Added support for optional validation/selection by the
   number of units/cells to all static `byChipType()` methods.  This
   is done by specifying argument nbrOfUnits/nbrOfCells.  This is
   intend for internal use only.

 * ROBUSTNESS: Added a sanity check to `getAromaUgpFile()` of
   UnitNamesFile and AromaUnitSignalBinaryFile, which asserts that the
   number of units in the located UGP file match that the number of
   units in the data file.

 * ROBUSTNESS: Now `findAnnotationData()` always returns pathnames
   ordered by the length of their fullnames. Before this was only done
   if `firstOnly = TRUE`.


# Version 1.0.0 [2009-01-12]

## New Features

 * Added `getMaxLengthRepeats()` to AromaCellSequenceFile.

 * Added AromaUnitSignalBinary{File|Set},
   AromaUnitTotalCnBinary{File|Set}, AromaUnitFracBCnFinary{File|Set},
   AromaUnitCall{File|Set}, and AromaUnitGenotypeCall{File|Set}.


## Bug Fixes

 * `readFooter()` of AromaTabularBinaryFile did not return the correct
   list for nested structures.

 * `groupBySnpNucleotides()` of AromaCellSequenceFile would return an
   empty element `missing` for some chip types,
   e.g. Mapping10K_Xba142.  Now such empty elements are dropped.

 * `getAttributes()` for GenericDataFile:s would give an error if
   there were no attributes.


# Version 0.9.6 [2008-12-04]

## New Features

 * ALPHA: Added the BinnedScatter class with methods.


## Performance

 * SPEEDUP: Now `predict()` of ProbePositionEffects is 6-7 times
   faster.

 * SPEEDUP: Now the result of `isMissing()` for AromaCellSequenceFile
   can be cached.


## Bug Fixes

 * CLEANUP: `readDataFrame()` of AromaTabularBinaryFile would forget
   to close the connection if verbose output was activated.  When R
   later would close such connections, a warning would be generated.


# Version 0.9.5 [2008-10-17]

## Software Quality

 * Package passes `R CMD check` on R v2.7.2 and R v2.8.0rc.


# Version 0.9.4.5 [2008-10-16]

## Bug Fixes

 * Tried to turn a function passed to `as.GrayscaleImage()` in
   argument `transforms` to a list using `as.list()` and not `list()`.


# Version 0.9.4.4 [2008-09-18]

## New Features

 * Added argument `skip` to `writeChecksum()` of GenericDataFile.


# Version 0.9.4.3 [2008-09-03]

## New Features

 * Added `getSnpPositions()`, `getSnpShifts()`, `getSnpNucleotides()`,
   and `groupBySnpNucleotides()` to AromaCellSequenceFile.


# Version 0.9.4.2 [2008-08-31]

## New Features

 * Update `fitGenotypeCone()` to support both flavors `"sfit"` (old)
   and `"expectile"` (new).


# Version 0.9.4.1 [2008-08-12]

## New Features

 * Added support for argument `positions` to `countBases()` for
   AromaCellSequenceFile.

 * ALPHA: Added `fitMultiDimensionalCone()`.


## Software Quality

 * TESTING: Added redundancy tests to **aroma.core**.


## Bug Fixes

 * `readSequences()` for AromaCellSequenceFile translated raw values
   to incorrect nucleotides.


# Version 0.9.4 [2008-08-02]

## New Release

 * Public release.


## Software Quality

 * Package passes `R CMD check` on R v2.7.1 and R v2.8.0 devel on
   MS Windows XP.


# Version 0.9.3.4 [2008-07-24]

## New Features

 * Added `getCreatedOn()`, `getLastModifiedOn()`, and
   `getLastAccessedOn()` to GenericDataFile.  These a just wrapper
   accessing `file.info()` fields.


## Performance

 * SPEEDUP: Added patch for `base::serialize()` on MS Windows, which
   in turn will speed up `digest::digest()` and all methods that use
   the latter to generate hashcodes.

 * SPEEDUP: Now `as.character()` for GenericTabularFile:s and
   TabularTextFile:s reports the number of data rows and the number of
   text lines as NA if the files are too large and cached results are
   not already available.

 * SPEEDUP: Replaced all `which()` with faster `whichVector()`.


# Version 0.9.3.3 [2008-07-21]

## Significant Changes

 * Now `updateDataColumn()` coerce values to doubles before censoring
   them for raw and integer columns.


## New Features

 * Now `countBases()` of AromaCellSequenceFile returns "raw" counts if
   argument `mode = "raw"`.

 * ALPHA: Added `setFullName()` and `setName()` to GenericDataFile and
   GenericDataFileSet. The plan is to have these replace what
   `getAlias()` and `setAlias()` do today.

 * BETA: Added `setFullNameTranslator()` to GenericDataFileSet.


## Software Quality

 * Now `findByName()` assert that the data set name is not empty.


# Version 0.9.3.2 [2008-07-16]

## New Features

 * BETA: Added `setFullNamesTranslator()` (for the files) to
   AromaGenericFileSet.

 * ALPHA: Added protected `update2()` to GenericDataFileSet.

 * ALPHA: Added private ProbePositionEffects, etc.


# Version 0.9.3.1 [2008-07-12]

## New Features

 * Added a general `importFrom()` for AromaTabularBinaryFile, which
   calls matching `importFrom<ClassName>()`, if found.

 * Added support for `raw` data columns in AromaTabularBinaryFile.

 * BETA: Added `readTableHeader()`.

 * BETA: Added AromaCellSequenceFile.

 * BETA: Added classes AromaMicroarrayTabularBinaryFile and
   AromaCellTabularBinaryFile.


## Performance

 * SPEEDUP: Now all AromaTabularBinaryFile:s, such as AromaUgpFile,
   read data much faster after two modifications to `readDataFrame()`:
   (i) rownames are no longer generate, if not asked for explicitly,
   and (ii) garbage collection is no longer done after each column.


# Version 0.9.3 [2008-06-08]

## Software Quality

 * Package passes `R CMD check` on R v2.7.0 patched.


# Version 0.9.2.6 [2008-06-07]

## Significant Changes

 * Update filename pattern for `getOutputFiles()` of AromaTransform.


# Version 0.9.2.5 [2008-05-25]

## New Features

 * Added AromaTransform (extracted from
   `aroma.affymetrix::Transform`).

 * Added `nbrOfArrays()` to AromaMicroarrayDataSet.

 * Now private `xmlToList()` handles more complex XML strings.


# Version 0.9.2.4 [2008-05-22]

## New Features

 * Added member `chromosome` to RawCopyNumbers.

 * Added `gaussianSmoothing()` to RawCopyNumbers.

 * Added argument `xOut` to `gaussianSmoothing()` in order to specify
   at what loci the smoothed signals should be calculated.


# Version 0.9.2.3 [2008-05-21]

## New Features

 * Added `gzip()`/`gunzip()` to GenericDataFile.

 * Added static `findByName()` and `byName()` to GenericDataFileSet.

 * Added static `getFileClass()` to GenericDataFileSet.  This makes it
   possible to remove most `fromFiles()` from subclasses but also the
   validation of argument `files` of their constructors.

 * Added `validate()` to GenericDataFileSet, which is called at the
   end of `fromFiles(..., .validate = TRUE)`.

 * Added extractMatrix to `GenericTabular(File|Set)` and
   `AromaTabularBinary(File|Set)`.

 * Added `equals()` and `hasFile()` to GenericDataFileSet.

 * Added classes GenericTabularFileSet and AromaTabularBinarySet.

 * Added `stextChipType()` for strings.

 * ALPHA: Now `equals()` for GenericDataFile:s uses the class,
   pathname, file size and file-contents checksum to do the
   comparison.  Similarly, for GenericDataFileSet:s, the class, path,
   number of files, pathnames, and finally `equals()` for each file
   pair is used for the comparison.

 * ALPHA: Added full name translation for GenericDataFile:s.

 * ALPHA: Added UnitNamesFile.


## Software Quality

 * Package passes `R CMD check` on R v2.7.0 patched.

 * Now `findPngDevice()` search for a working PNG device in the
   following order: `png(..., type = "cairo")`, `png(..., type =
   "cairo1")`, `Cairo::CairoPNG()`, `R.utils::png2()`, and finally
   plain `png()`.


## Refactorization

 * CLEANUP: Moved more classes and methods from **aroma.affymetrix**
   to **aroma.core**: RawCopyNumbers, CopyNumberRegions,
   CopyNumberOutliers. Moved attribute methods from
   AffymetrixCel{File|Set} to AromaMicroarrayDataSet.  Moved
   `stextNnn()` methods from AffymetrixFile to
   AffymetrixMicroarrayDataSet.  Created superclass
   AromaMicroarrayDataSetTuple of AffymetrixCelSetTuple.


## Bug Fixes

 * BUG FIX: `readDataFrame()` did not read the first data row if there
   was no column header; it was eaten up by a preceeding
   `readHeader()`.

 * BUG FIX: `findAnnotationDataByChipType(chipType =
   "GenomeWideSNP_6", pattern = "^GenomeWideSNP_6.*[.]ugp$")` would
   find file `GenomeWideSNP_6,Full,na24.ugp` before
   `GenomeWideSNP_6,na24.ugp`. Now we return the one with the shortest
   full name.


# Version 0.9.2 [2008-05-10]

## Significant Changes

 * Package created.

 * Took all core classes and core methods in **aroma.affymetrix** that
   are independent of the Affymetrix platform and placed the here.

 * The version is numbered starting from the current version of
   **aroma.affymetrix**.


## Bug Fixes

 * `interleave()` for Image gave `Error in z[idxOdd, ] : incorrect
   number of dimensions`.  The internal image structure is a 3-dim
   array.

 * When searching with `firstOnly = FALSE`, `findAnnotationData()` was
   identifying files that are in "private" directory.  This is how
   `affxparser::findFiles()` works.  Such files are now filtered out.
