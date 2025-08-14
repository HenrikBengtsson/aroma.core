###########################################################################/**
# @RdocClass AromaTransform
#
# @title "The AromaTransform class"
#
# \description{
#  @classhierarchy
#
#  This abstract class represents a transform (algorithm/operator) that
#  transforms data.  A transform has an input data set, which is
#  transformed into an output data set.
# }
#
# @synopsis
#
# \arguments{
#   \item{dataSet}{The input data set as an @see "AromaMicroarrayDataSet".}
#   \item{tags}{A @character @vector of tags to be appended to the tags of
#      the input data set.}
#   \item{...}{Not used.}
#   \item{.reqSetClass}{Internal argument.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# \details{
#   Subclasses must implement the \code{process()} method.
# }
#
# @author
#*/###########################################################################
setConstructorS3("AromaTransform", function(dataSet=NULL, tags="*", ..., .reqSetClass="AromaMicroarrayDataSet") {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'dataSet':
  if (!is.null(dataSet)) {
    dataSet <- Arguments$getInstanceOf(dataSet, .reqSetClass)
  }

  # Arguments '...':
  args <- list(...)
  if (length(args) > 0) {
    argsStr <- paste(names(args), collapse=", ")
    throw("Unknown arguments: ", argsStr)
  }


  this <- extend(Object(), c("AromaTransform", uses("ParametersInterface")),
    .tags = tags,
    .inputDataSet = dataSet,
    "cached:.outputDataSet" = NULL
  )

  setTags(this, tags)

  this
}, abstract=TRUE)



setMethodS3("getAsteriskTags", "AromaTransform", function(this, ...) {
  # Create a default asterisk tags for any class by extracting all
  # capital letters and pasting them together, e.g. AbcDefGhi => ADG.
  name <- class(this)[1]

  # Remove any 'Model' suffixes
  name <- gsub("Model$", "", name)

  name <- capitalize(name)

  # Vectorize
  name <- strsplit(name, split="")[[1]]

  # Identify upper case
  name <- name[(toupper(name) == name)]

  # Paste
  name <- paste(name, collapse="")

  tags <- name

  tags
}, protected=TRUE)


###########################################################################/**
# @RdocMethod getRootPath
#
# @title "Gets the root path of the output directory"
#
# \description{
#  @get "title" that is returned by @seemethod "getPath".
#  A root path is a directory in the current working directory.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seemethod "getPath".
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getRootPath", "AromaTransform", function(this, ...) {
  sprintf("pp%s", capitalize(class(this)[1]))
})


setMethodS3("as.character", "AromaTransform", function(x, ...) {
  # To please R CMD check
  this <- x

  s <- sprintf("%s:", class(this)[1])
  ds <- getInputDataSet(this)
  s <- c(s, sprintf("Data set: %s", getName(ds)))
  tags <- paste(getTags(ds), collapse=",")
  s <- c(s, sprintf("Input tags: %s", tags))
  s <- c(s, sprintf("User tags: %s", paste(this$.tags, collapse=",")))
  s <- c(s, sprintf("Asterisk ('*') tags: %s", getAsteriskTags(this, collapse=",")))
  s <- c(s, sprintf("Output tags: %s", paste(getTags(this), collapse=",")))
  s <- c(s, sprintf("Number of files: %d (%s)", length(ds),
                      hsize(getFileSize(ds), digits = 2L, standard = "IEC")))
  s <- c(s, sprintf("Platform: %s", getPlatform(ds)))
  s <- c(s, sprintf("Chip type: %s", getChipType(ds)))
  s <- c(s, sprintf("Algorithm parameters: %s", getParametersAsString(this)))
  s <- c(s, sprintf("Output path: %s", getPath(this)))
  s <- c(s, sprintf("Is done: %s", isDone(this)))

  GenericSummary(s)
}, protected=TRUE)


###########################################################################/**
# @RdocMethod getName
#
# @title "Gets the name of the output data set"
#
# \description{
#  @get "title", which is the same as the input data set.
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getName", "AromaTransform", function(this, ...) {
  ds <- getInputDataSet(this)
  getName(ds)
})


###########################################################################/**
# @RdocMethod getTags
#
# @title "Gets the tags of the output data set"
#
# \description{
#  @get "title", which equals the tags of the input data set plus the tags
#  of this transformation.
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Not used.}
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
setMethodS3("getTags", "AromaTransform", function(this, collapse=NULL, ...) {
  # "Pass down" tags from input data set
  ds <- getInputDataSet(this)
  tags <- getTags(ds, collapse=collapse)

  # Get class-specific tags
  tags <- c(tags, this$.tags)

  # In case this$.tags is not already split
  tags <- strsplit(tags, split=",", fixed=TRUE)
  tags <- unlist(tags)

  # Update default tags
  tags[tags == "*"] <- getAsteriskTags(this, collapse=",")

  # Collapsed or split?
  tags <- Arguments$getTags(tags, collapse=collapse)

  tags
})


setMethodS3("setTags", "AromaTransform", function(this, tags="*", ...) {
  # Argument 'tags':
  if (!is.null(tags)) {
    tags <- Arguments$getCharacters(tags, collapse=NULL)
  }
  this$.tags <- tags
  invisible(this)
})



###########################################################################/**
# @RdocMethod getFullName
#
# @title "Gets the full name of the output data set"
#
# \description{
#  @get "title", which is the name with comma separated tags.
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getFullName", "AromaTransform", function(this, ...) {
  name <- getName(this)
  tags <- getTags(this)
  fullname <- paste(c(name, tags), collapse=",")
  fullname <- gsub("[,]$", "", fullname)
  fullname
})



###########################################################################/**
# @RdocMethod getPath
#
# @title "Gets the path of the output directory"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{create}{If @TRUE, the path is created, otherwise not.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string.
# }
#
# \details{
#   Windows Shortcut links are recognized.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getPath", "AromaTransform", function(this, create=TRUE, ...) {
  # Create the (sub-)directory tree for the data set

  # Root path
  rootPath <- getRootPath(this)

  # Full name
  fullname <- getFullName(this)

  # Chip type
  ds <- getInputDataSet(this)
  chipType <- getChipType(ds, fullname=FALSE)

  # The full path
  path <- filePath(rootPath, fullname, chipType)

  # Create path?
  if (create) {
    path <- Arguments$getWritablePath(path)
  } else {
    path <- Arguments$getReadablePath(path, mustExist=FALSE)
  }

  # Verify that it is not the same as the input path
  inPath <- getPath(getInputDataSet(this))
  if (getAbsolutePath(path) == getAbsolutePath(inPath)) {
    throw("The generated output data path equals the input data path: ", path, " == ", inPath)
  }

  path
})



###########################################################################/**
# @RdocMethod getInputDataSet
#
# @title "Gets the input data set"
#
# \description{
#  @get "title" that is to be (or has been) transformed.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns an @see "AromaMicroarrayDataSet".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getInputDataSet", "AromaTransform", function(this, ...) {
  this$.inputDataSet
})


###########################################################################/**
# @RdocMethod findFilesTodo
#
# @title "Finds files in the data set still not processed"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
#   \item{verbose}{See @see "R.utils::Verbose".}
# }
#
# \value{
#  Returns a named @integer @vector specifying the indices of the files
#  still not processed.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("findFilesTodo", "AromaTransform", function(this, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }


  verbose && enter(verbose, "Checking which data files are not \"done\"")
  # Get the fullnames of the expected output data files
  fullnames <- getExpectedOutputFullnames(this, verbose=less(verbose, 25))

  # Scan for matching output files
  dsOut <- getOutputDataSet(this, incomplete=TRUE, ...,
                                                  verbose=less(verbose,5))
  fullnamesOut <- getFullNames(dsOut)

  verbose && exit(verbose)

  # Missing
  idxs <- match(fullnames, fullnamesOut)
  missing <- which(is.na(idxs))

  # Always return sorted and unique set of indices
  missing <- sort(unique(missing))
  names(missing) <- fullnames[missing]

  missing
}, protected=TRUE) # findFilesTodo()



###########################################################################/**
# @RdocMethod isDone
#
# @title "Checks if the data set is processed or not"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @seemethod "findFilesTodo".}
# }
#
# \value{
#  Returns @TRUE if the data set is processed, otherwise @FALSE.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("isDone", "AromaTransform", function(this, ...) {
  missing <- findFilesTodo(this, ...)
  (length(missing) == 0L)
})


setMethodS3("getExpectedOutputFiles", "AromaTransform", function(this, ...) {
  ds <- getInputDataSet(this)
  pathnames <- getPathnames(ds)
  basename(pathnames)
}, protected=TRUE)


setMethodS3("getExpectedOutputFullnames", "AromaTransform", function(this, ...) {
  ds <- getInputDataSet(this)
  getFullNames(ds)
}, protected=TRUE)


setMethodS3("getOutputFiles", "AromaTransform", function(this, pattern=NULL, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }

  # Argument 'pattern':
  if (is.null(pattern)) {
    # Default filename pattern find non-private (no dot prefix) files with
    # the same file name extension as the input data set.
    ds <- getInputDataSet(this)
    df <- getOneFile(ds)
    pattern <- sprintf("^[^.].*[.]%s$", getFilenameExtension(df))
  } else {
    pattern <- Arguments$getRegularExpression(pattern=pattern)
  }

  outPath <- getPath(this)
  findFiles(pattern=pattern, paths=outPath, firstOnly=FALSE)
}, protected=TRUE)


setMethodS3("getOutputDataSet0", "AromaTransform", function(this, pattern=NULL, className=NULL, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }

  # Argument 'pattern':
  if (!is.null(pattern)) {
    pattern <- Arguments$getRegularExpression(pattern=pattern)
  }


  verbose && enter(verbose, "Retrieving existing set of output files")
  ds <- getInputDataSet(this)
  outPath <- getPath(this)
  if (is.null(className)) {
    className <- class(ds)[1]
    verbose && cat(verbose, "Using the same class name as the input data set.")
  }
  verbose && cat(verbose, "Class: ", className)

  path <- getPath(this)
  verbose && cat(verbose, "Path: ", path)

  if (is.null(pattern)) {
    # Default filename pattern find non-private (no dot prefix) files with
    # the same file name extension as the input data set.
    df <- getOneFile(ds)
    fileExt <- gsub(".*[.]([^.]*)$", "\\1", getFilename(df))
    fileExt <- c(fileExt, tolower(fileExt), toupper(fileExt))
    fileExt <- sprintf("(%s)", paste(unique(fileExt), collapse="|"))
    verbose && cat(verbose, "Expected file extensions: ", fileExt)
    pattern <- sprintf("^[^.].*[.]%s$", fileExt)
  }
  verbose && cat(verbose, "Pattern: ", pattern)

  verbose && enter(verbose, sprintf("Calling %s$forName()", className))
  clazz <- Class$forName(className)
  args <- list(path=path, pattern=pattern, ...)
  verbose && str(verbose, args)
  args$verbose <- less(verbose)
  staticMethod <- clazz$byPath
  dsOut <- do.call(staticMethod, args=args)
  # Not needed anymore
  staticMethod <- args <- NULL
  verbose && exit(verbose)

  verbose && exit(verbose)

  dsOut
}, protected=TRUE)




###########################################################################/**
# @RdocMethod getOutputDataSet
#
# @title "Gets the transformed data set"
#
# \description{
#  @get "title", if processed.
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Arguments passed to static method \code{byPath()} of
#   the class of the input @see "AromaMicroarrayDataSet".}
#  \item{onMissing}{A @character string specifying how non-processed files
#   should be returned.
#   If \code{"drop"}, they are ignored and not part of the returned
#   data set.
#   If \code{"dropall"}, @NULL is returned unless all files are processed.
#   If \code{"NA"}, they are represented as a "missing" file.
#   If \code{"error"}, they are not accepted and an exception is thrown.
#  }
#  \item{incomplete}{[DEPRECATED] If the output data set is incomplete,
#   then @NULL is returned unless \code{incomplete} is @TRUE.}
#  \item{force}{If @TRUE, any in-memory cached results are ignored.}
#  \item{verbose}{See @see "R.utils::Verbose".}
# }
#
# \value{
#  Returns an @see "AromaMicroarrayDataSet" or @NULL.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getOutputDataSet", "AromaTransform", function(this, onMissing=c("dropall", "drop", "NA", "error"), ..., incomplete=FALSE, className=NULL, force=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Backward compatibility /HB 2013-11-15
  if (missing(onMissing)) {
    incomplete <- Arguments$getLogical(incomplete)
    if (incomplete) {
      onMissing <- "drop"
    } else {
      onMissing <- "dropall"
    }
  } else if (missing(incomplete)) {
    onMissing <- match.arg(onMissing)
    incomplete <- (onMissing != "dropall")
  }

  # Argument 'onMissing':
  onMissing <- match.arg(onMissing)

  # Argument 'incomplete':
  incomplete <- Arguments$getLogical(incomplete)

  # Sanity check /HB 2013-11-15
  if ((incomplete && onMissing == "dropall") || (!incomplete && onMissing != "dropall")) {
    throw("INTERNAL ERROR: Detected incompatible arguments 'onMissing' and 'incomplete': ", dQuote(onMissing), " <-> ", incomplete)
  }
  incomplete <- NULL # Not needed anymore

  # Argument 'className':
  if (!is.null(className)) {
    className <- Arguments$getCharacter(className)
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }

  verbose && enter(verbose, "Getting output data set for ", class(this)[1])

  # Already retrieved?
  dsOut <- this$.outputDataSet
  if (!force && !is.null(dsOut)) {
    verbose && cat(verbose, "Already retrived.")
    verbose && exit(verbose)
    return(dsOut)
  }

  verbose && enter(verbose, "Retrieving expected set of output files")
  fullnames <- getExpectedOutputFullnames(this)
  verbose && cat(verbose, "Expected fullnames:")
  verbose && str(verbose, fullnames)
  verbose && exit(verbose)

  nbrOfFiles <- length(fullnames)
  if (nbrOfFiles == 0L) {
    verbose && cat(verbose, "No output files are expected: Input data set could be empty.")
    verbose && exit(verbose)
    return(NULL)
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Identifying existing output files
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Retrieving all existing output files")
  dsOut <- getOutputDataSet0(this, ..., verbose=less(verbose, 10))
  verbose && print(verbose, dsOut)
  # Sanity check
  .stop_if_not(!is.null(dsOut))
  verbose && exit(verbose)

  verbose && enter(verbose, "Map output data set to input data set by fullnames")
  ## Order according to expected fullnames
  verbose && cat(verbose, "Expected fullnames:")
  verbose && str(verbose, fullnames)

  verbose && exit(verbose)


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Handle missing output files
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  dsOut <- extract(dsOut, fullnames, by="exact", onMissing=onMissing, onDuplicates="error")

  # Special backward compatible case. /HB 2013-11-15
  if (onMissing == "dropall" && length(dsOut) == 0L) {
    dsOut <- NULL
    gotten <- character(0L)
  } else {
    gotten <- getFullNames(dsOut)
  }
  verbose && print(verbose, dsOut)

  # Sanity checks
  expected <- fullnames

  isError <- FALSE
  msg <- sprintf("Got %d (%s) output file, but expected %d (%s).", length(gotten), hpaste(gotten), length(expected), hpaste(expected))

  # Check for duplicated output files
  dups <- gotten[duplicated(gotten)]
  if (length(dups) > 0) {
    msg <- sprintf("%s Among the output files, %d (%s) have duplicated names, which is an error.", msg, length(dups), hpaste(unique(dups)))
    isError <- TRUE
  }

  # Check for unexpected and missing files
  unexpected <- setdiff(gotten, expected)
  if (length(unexpected) > 0) {
    msg <- sprintf("%s There were %d (%s) unexpected/non-matching output files, which is an error.", msg, length(unexpected), hpaste(unexpected))
    isError <- TRUE
  }

  missing <- setdiff(expected, gotten)
  if (length(missing) > 0) {
    msg <- sprintf("%s Also, but not an error, there are %d (%s) missing output files.", msg, length(missing), hpaste(missing))
  }

  if (isError) throw(msg)

  verbose && exit(verbose)

  dsOut
}) # getOutputDataSet() for AromaTransform



###########################################################################/**
# @RdocMethod process
#
# @title "Processes the data set"
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
#  Returns a @double @vector.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("process", "AromaTransform", abstract=TRUE)
