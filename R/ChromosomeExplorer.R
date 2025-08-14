###########################################################################/**
# @RdocClass ChromosomeExplorer
#
# @title "The ChromosomeExplorer class"
#
# \description{
#  @classhierarchy
# }
#
# @synopsis
#
# \arguments{
#   \item{model}{A @see "CopyNumberChromosomalModel" object.}
#   \item{zooms}{An positive @integer @vector specifying for which zoom
#    levels the graphics should be generated.}
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# \section{Generating PNG images}{
#   In order to get better looking graphs, but also to be able to generate
#   bitmap images on systems without direct bitmap support, which is the case
#   when running R in batch mode or on Unix without X11 support, images are
#   created using the @see "R.devices::png2" device (a wrapper for
#   \code{bitmap()} imitating \code{png()}).  The \code{png()} is only
#   used if \code{png2()}, which requires Ghostscript, does not.
#   Note, when images are created using \code{png2()}, the images does
#   not appear immediately, although the function call is completed,
#   so be patient.
# }
#
# @author
#
# \seealso{
#  @see "CopyNumberChromosomalModel".
# }
#*/###########################################################################
setConstructorS3("ChromosomeExplorer", function(model=NULL, zooms=2^(0:6), ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'model':
  if (!is.null(model)) {
    model <- Arguments$getInstanceOf(model, "CopyNumberChromosomalModel")
  }

  # Argument 'zooms':
  if (is.null(zooms)) {
    zooms <- 2^(0:7)
  } else {
    zooms <- Arguments$getDoubles(zooms, range=c(0, Inf))
  }


  extend(Explorer(...), c("ChromosomeExplorer"),
    .model = model,
    .arrays = NULL,
    .plotCytoband = TRUE,
    .zooms = zooms
  )
})


setMethodS3("as.character", "ChromosomeExplorer", function(x, ...) {
  # To please R CMD check
  this <- x

  s <- sprintf("%s:", class(this)[1])
  s <- c(s, sprintf("Name: %s", getName(this)))
  s <- c(s, sprintf("Tags: %s", paste(getTags(this), collapse=",")))
  s <- c(s, sprintf("Number of arrays: %d", nbrOfArrays(this)))
  s <- c(s, sprintf("Path: %s", getPath(this)))

  GenericSummary(s)
}, protected=TRUE)


setMethodS3("setCytoband", "ChromosomeExplorer", function(this, status=TRUE, ...) {
  # Argument 'status':
  status <- Arguments$getLogical(status)

  this$.plotCytoband <- status
})


###########################################################################/**
# @RdocMethod getModel
#
# @title "Gets the model"
#
# \description{
#  @get "title" for which the explorer is displaying it results.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @see "CopyNumberChromosomalModel".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getModel", "ChromosomeExplorer", function(this, ...) {
  this$.model
})

setMethodS3("getNames", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this)
  getNames(model, ...)
})

setMethodS3("getFullNames", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this)
  getFullNames(model, ...)
})

setMethodS3("indexOf", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this)
  indexOf(model, ...)
})



setMethodS3("getArraysOfInput", "ChromosomeExplorer", function(this, ...) {
  getNames(this, ...)
}, protected=TRUE)



###########################################################################/**
# @RdocMethod setArrays
#
# @title "Sets the arrays"
#
# \description{
#  @get "title" to be processed by the explorer.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character @vector.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("setArrays", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this)
  idxs <- indexOf(model, ...)

  # Get the names of the arrays
  arrayNames <- getNames(model)[idxs]

  # Sanity check
  .stop_if_not(!any(duplicated(arrayNames)))

  this$.arrays <- arrayNames
})

setMethodS3("getNameOfInput", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this)
  getName(model, ...)
}, protected=TRUE)


setMethodS3("getTagsOfInput", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this)
  getTags(model)
}, protected=TRUE)


setMethodS3("getPath", "ChromosomeExplorer", function(this, ...) {
  mainPath <- getMainPath(this)

  # Chip type
  model <- getModel(this)
  chipType <- getChipType(model)

  # Image set
  set <- getSetTag(model)

  # The full path
  path <- filePath(mainPath, chipType, set)
  path <- Arguments$getWritablePath(path)

  path
})


###########################################################################/**
# @RdocMethod getChromosomes
#
# @title "Gets the chromosomes available"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @integer @vector.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getChromosomes", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this)
  getChromosomes(model)
})


setMethodS3("getChromosomeLabels", "ChromosomeExplorer", function(this, ...) {
  chrs <- getChromosomes(this)

  # Sanity check
  chrs <- Arguments$getIntegers(chrs)

  chrsL <- character(length=max(chrs, na.rm=TRUE))
  chrsL[chrs] <- sprintf("%02d", chrs)

  if (length(chrsL) >= 23) {
    chrsL[23] <- "X"
  }
  if (length(chrsL) >= 24) {
    chrsL[24] <- "Y"
  }
  if (length(chrsL) >= 25) {
    chrsL[25] <- "M"
  }

  chrsL
}, protected=TRUE)


setMethodS3("getZooms", "ChromosomeExplorer", function(this, ...) {
  zooms <- this$.zooms
  if (is.null(zooms))
    zooms <- 2^(0:7)
  zooms <- as.integer(zooms)
  zooms
})


setMethodS3("setZooms", "ChromosomeExplorer", function(this, zooms=NULL, ...) {
  # Argument 'zooms':
  if (is.null(zooms)) {
    zooms <- 2^(0:7)
  } else {
    zooms <- Arguments$getIntegers(zooms, range=c(1, Inf))
  }
  zooms <- unique(zooms)
  zooms <- as.integer(zooms)
  this$.zooms <- zooms
  invisible(this)
})

setMethodS3("getSampleLabels", "ChromosomeExplorer", function(this, ...) {
  labels <- getNames(this, ...)
  labels
}, protected=TRUE)


setMethodS3("writeGraphs", "ChromosomeExplorer", function(x, arrays=NULL, ...) {
  # To please R CMD check.
  this <- x

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'arrays':
  arrays <- indexOf(this, arrays)

  # Get the model
  model <- getModel(this)

  path <- getPath(this)
  path <- Arguments$getWritablePath(path)

  plotband <- this$.plotCytoband # Plot cytoband?
  plot(model, path=path, imageFormat="png", plotband=plotband, arrays=arrays, ...)

  invisible(path)
}, private=TRUE)



setMethodS3("writeRegions", "ChromosomeExplorer", function(this, arrays=NULL, nbrOfSnps=c(3,Inf), smoothing=c(-Inf,-0.15, +0.15,+Inf), ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'arrays':
  arrays <- indexOf(this, arrays)

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }


  model <- getModel(this)

  # Not supported?
  if (!inherits(model, "CopyNumberSegmentationModel"))
    return(NULL)

  verbose && enter(verbose, "Writing CN regions")

  path <- getPath(this)
  path <- Arguments$getWritablePath(path)

  dest <- filePath(path, "regions.xls")
  dest <- Arguments$getWritablePathname(dest)


  # Extract and write regions
  pathname <- writeRegions(model, arrays=arrays, nbrOfSnps=nbrOfSnps, smoothing=smoothing, ..., skip=FALSE, verbose=less(verbose))
  res <- copyFile(pathname, dest, overwrite=TRUE, copy.mode=FALSE)
  if (!res)
    dest <- NULL

  verbose && exit(verbose)

  invisible(dest)
}, private=TRUE)




setMethodS3("addIndexFile", "ChromosomeExplorer", function(this, filename="ChromosomeExplorer.html", ...) {
  NextMethod("addIndexFile", filename=filename)
}, protected=TRUE)



###########################################################################/**
# @RdocMethod updateSetupExplorerFile
#
# @title "Updates the Javascript file"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
#   \item{verbose}{A @logical or @see "R.utils::Verbose".}
# }
#
# \value{
#  Returns (invisibly) the pathname to the samples.js file.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("updateSetupExplorerFile", "ChromosomeExplorer", function(this, ..., verbose=FALSE) {
  pkg <- "R.rsp"
  require(pkg, character.only=TRUE) || throw("Package not loaded: ", pkg)

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }

  path <- getPath(this)
  parentPath <- getParent(path)
  parent2Path <- getParent(parentPath)
  parent3Path <- getParent(parent2Path)

  srcPath <- getTemplatePath(this)
  pathT <- file.path(srcPath, "rsp", "ChromosomeExplorer")
  filenameT <- "setupExplorer.js.rsp"
  pathname <- filePath(pathT, filenameT)

  verbose && enter(verbose, "Compiling ", basename(pathname))
  verbose && cat(verbose, "Source: ", pathname)
  outFile <- gsub("[.]rsp$", "", basename(pathname))
  outPath <- parent2Path
  outPath <- Arguments$getWritablePath(outPath)
  verbose && cat(verbose, "Output path: ", outPath)

  verbose && enter(verbose, "Scanning directories for available chip types")
  # Find all directories matching these
  dirs <- list.files(path=parent2Path, full.names=TRUE)
  dirs <- dirs[sapply(dirs, FUN=isDirectory)]

  # Get possible chip types
  model <- getModel(this)
  chipTypes <- c(getChipType(model), getChipTypes(model))
  chipTypes <- intersect(chipTypes, basename(dirs))
  verbose && cat(verbose, "Detected chip types: ",
                                           paste(chipTypes, collapse=", "))
  verbose && exit(verbose)

  # Get available zooms
  verbose && enter(verbose, "Scanning image files for available zooms")
  pattern <- ".*,x([0-9][0-9]*)[.]png$"
  zooms <- list.files(path=path, pattern=pattern)
  zooms <- gsub(pattern, "\\1", zooms)
  zooms <- gsub("^0*", "", zooms)
  if (length(zooms) == 0) {
    # Default zooms
    zooms <- getZooms(this)
  }
  zooms <- unique(zooms)
  zooms <- as.integer(zooms)
  zooms <- sort(zooms)
  verbose && cat(verbose, "Detected (or default) zooms: ", paste(zooms, collapse=", "))
  verbose && exit(verbose)

  # Get available subdirectories
  verbose && enter(verbose, "Scanning directory for subdirectories")
  subdirs <- list.files(path=parentPath, full.names=TRUE)
  # Keep only directories
  subdirs <- subdirs[sapply(subdirs, FUN=isDirectory)]

  isChrLayer <- (regexpr(",chrLayer", subdirs) != -1)
  isSampleLayer <- (regexpr(",sampleLayer", subdirs) != -1)
  isLayer <- (isChrLayer | isSampleLayer)
  hasLayers <- any(isLayer)

  # Remove anything that is a layer
  sets <- basename(subdirs)[!isLayer]

  if (length(sets) == 0) {
    sets <- c("glad", "cbs")
    warning("No 'set' directories detected. Using defauls: ", paste(sets, collapse=", "))
  } else {
    sets <- basename(sets)
  }
  sets <- sort(unique(sets))
  verbose && cat(verbose, "Detected (or default) sets: ", paste(sets, collapse=", "))
  verbose && exit(verbose)

  if (hasLayers) {
    sets <- c("-LAYERS-", sets)
  }

  chrLayers <- gsub(",chrLayer", "", basename(subdirs)[isChrLayer])
  sampleLayers <- gsub(",sampleLayer", "", basename(subdirs)[isSampleLayer])

  # Compile RSP file
  verbose && enter(verbose, "Compiling RSP")
  env <- new.env()
  env$chromosomeLabels <- getChromosomeLabels(this)
  env$chipTypes <- chipTypes
  env$samples <- getFullNames(this, ...)
  env$sampleLabels <- getNames(this)
  env$zooms <- zooms
  env$sets <- sets
  env$chrLayers <- chrLayers
  env$sampleLayers <- sampleLayers
  verbose && print(verbose, ll(envir=env))

  verbose && cat(verbose, "Sample names:")
  verbose && print(verbose, env$sampleLabels)

  verbose && cat(verbose, "Full sample names:")
  verbose && print(verbose, env$samples)

  js <- rfile(pathname, workdir=outPath, envir=env, postprocess=FALSE)

  verbose && exit(verbose)


  verbose && exit(verbose)

  invisible(js)
}, protected=TRUE) # updateSetupExplorerFile()



###########################################################################/**
# @RdocMethod process
#
# @title "Generates image files, scripts and dynamic pages for the explorer"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{arrays}{A @vector of arrays specifying which arrays to
#    be considered.  If @NULL, all are processed.}
#   \item{chromosomes}{A @vector of chromosomes specifying which
#     chromosomes to be considered.  If @NULL, all are processed.}
#   \item{...}{Not used.}
#   \item{verbose}{A @logical or @see "R.utils::Verbose".}
# }
#
# \value{
#  Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("process", "ChromosomeExplorer", function(this, arrays=NULL, chromosomes=NULL, ..., zooms=getZooms(this), layers=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'arrays':
  arrays <- indexOf(this, arrays)

  # Argument 'chromosomes':
  allChromosomes <- getChromosomes(this)
  if (is.null(chromosomes)) {
    chromosomes <- allChromosomes
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }


  verbose && enter(verbose, "Generating ChromosomeExplorer report")

  # Setup HTML, CSS, Javascript files first
  setup(this, ..., verbose=less(verbose))

  model <- getModel(this)

  # Generate layers?
  if (layers) {
    verbose && enter(verbose, "Generating image layers")

    # 1. Non-sample specific layers
    verbose && enter(verbose, "Non-sample specific layers")
    writeAxesLayers(this, chromosomes=chromosomes, zooms=zooms, ..., verbose=less(verbose))
    writeGridHorizontalLayers(this, chromosomes=chromosomes, zooms=zooms, ..., verbose=less(verbose))
    writeCytobandLayers(this, chromosomes=chromosomes, zooms=zooms, ..., verbose=less(verbose))
    verbose && exit(verbose)

    # 2. Sample specific layers
    verbose && enter(verbose, "Sample-specific layers")
    writeRawCopyNumberLayers(this, arrays=arrays, chromosomes=chromosomes,
                                     zooms=zooms, ..., verbose=less(verbose))

    if (inherits(model, "CopyNumberSegmentationModel")) {
      writeCopyNumberRegionLayers(this, arrays=arrays,
           chromosomes=chromosomes, zooms=zooms, ..., verbose=less(verbose))
    }
    verbose && exit(verbose)

    verbose && exit(verbose)
  } else {
    # Generate bitmap images
    writeGraphs(this, arrays=arrays, chromosomes=chromosomes,
                                   zooms=zooms, ..., verbose=less(verbose))
  }

  # Update samples.js
  updateSetupExplorerFile(this, ..., verbose=less(verbose))

  # Write regions file
  if (inherits(model, "CopyNumberSegmentationModel")) {
    writeRegions(this, arrays=arrays, chromosomes=chromosomes, ..., verbose=less(verbose))
  }

  verbose && exit(verbose)
})


setMethodS3("display", "ChromosomeExplorer", function(this, filename="ChromosomeExplorer.html", ...) {
  NextMethod("display", filename=filename)
})
