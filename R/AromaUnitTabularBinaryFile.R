###########################################################################/**
# @RdocClass AromaUnitTabularBinaryFile
#
# @title "The AromaUnitTabularBinaryFile class"
#
# \description{
#  @classhierarchy
#
#  A AromaUnitTabularBinaryFile is an @see "AromaTabularBinaryFile" with
#  the constraint that the rows map one-to-one to, and in the same order as,
#  the units in a annotation chip type file (e.g. CDF file).  
#  The (full) chip type of the annotation chip type file is given by the
#  mandatory file footer \code{chipType}.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "AromaTabularBinaryFile".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#
# %\seealso{
# % @see "AromaCellTabularBinaryFile".
# %}
#*/########################################################################### 
setConstructorS3("AromaUnitTabularBinaryFile", function(...) {
  extend(AromaMicroarrayTabularBinaryFile(...), c("AromaUnitTabularBinaryFile", uses("UnitAnnotationDataFile")),
    "cached:.unf" = NULL
  )
})


setMethodS3("nbrOfUnits", "AromaUnitTabularBinaryFile", function(this, ...) {
  nbrOfRows(this, ...)
})


setMethodS3("byChipType", "AromaUnitTabularBinaryFile", function(static, chipType, tags=NULL, nbrOfUnits=NULL, validate=TRUE, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'chipType':
  chipType <- Arguments$getCharacter(chipType, length=c(1,1))

  # Argument 'nbrOfUnits':
  if (!is.null(nbrOfUnits)) {
    nbrOfUnits <- Arguments$getInteger(nbrOfUnits, range=c(0,Inf))
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  } 


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Scan for all possible matches
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  pathnames <- findByChipType(static, chipType=chipType, tags=tags, 
                                                     firstOnly=FALSE, ...)
  if (is.null(pathnames)) {
    ext <- getDefaultExtension(static)
    note <- attr(ext, "note")
    msg <- sprintf("Failed to create %s object. Could not locate an annotation data file for chip type '%s'", class(static)[1], chipType)
    if (is.null(tags)) {
      msg <- sprintf("%s (without requiring any tags)", msg)
    } else {
      msg <- sprintf("%s with tags '%s'", msg, paste(tags, collapse=","))
    }
    msg <- sprintf("%s and with filename extension '%s'", msg, ext)
    if (!is.null(note)) {
      msg <- sprintf("%s (%s)", msg, note)
    }
    msg <- sprintf("%s.", msg)
    throw(msg)
  }

  verbose && cat(verbose, "Number of tabular binary files located: ", 
                                                        length(pathnames))
  verbose && print(verbose, pathnames)


  verbose && enter(verbose, "Scanning for a valid file")


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Look for first possible valid match
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  for (kk in seq_along(pathnames)) {
    pathname <- pathnames[kk]
    verbose && enter(verbose, "File #", kk, " (", pathname, ")")

    # Create object
    res <- newInstance(static, pathname)

    # Correct number of units?
    if (!is.null(nbrOfUnits)) {
      if (nbrOfUnits(res) != nbrOfUnits) {
        res <- NULL
      }
    }

    if (!is.null(res)) {
      verbose && cat(verbose, "Found a valid tabular binary file")
      verbose && exit(verbose)
      break
    }

    verbose && exit(verbose)
  } # for (kk ...)

  if (is.null(res)) {
    queryStr <- paste(c(chipType, tags), collapse=",")
    throw("Failed to located a (valid) tabular binary file: ", queryStr)
  }

  verbose && print(verbose, res)

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Final validation
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!is.null(nbrOfUnits)) {
    if (nbrOfUnits(res) != nbrOfUnits) {
      throw("The number of units in the loaded ", class(static)[1], " does not match the expected number: ", nbrOfUnits(res), " != ", nbrOfUnits)
    }
  }

  verbose && exit(verbose)

  res
}, static=TRUE)



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# BEGIN: UnitNamesFile
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setMethodS3("indexOfUnits", "AromaUnitTabularBinaryFile", function(this, names, ...) {
  # Map the unit names to the ones in the unit names file
  unf <- getUnitNamesFile(this)
  unitNames <- getUnitNames(unf)
  idxs <- match(names, unitNames)
  idxs
}, protected=TRUE)



setMethodS3("allocateFromUnitNamesFile", "AromaUnitTabularBinaryFile", function(static, unf, ...) {
  # Argument 'unf':
  unf <- Arguments$getInstanceOf(unf, "UnitNamesFile")
  allocateFromUnitAnnotationDataFile(static, udf=unf, ...)
}, static=TRUE, protected=TRUE)


setMethodS3("allocateFromUnitAnnotationDataFile", "AromaUnitTabularBinaryFile", function(static, udf, path=NULL, tags=NULL, footer=list(), ...) {
  # Argument 'udf':
  udf <- Arguments$getInstanceOf(udf, "UnitAnnotationDataFile")

  # Output path
  if (is.null(path)) {
    chipTypeS <- getChipType(udf, fullname=FALSE)
    path <- file.path("annotationData", "chipTypes", chipTypeS)
  }
  path <- Arguments$getWritablePath(path)

  # Get platform
  platform <- getPlatform(udf)

  # Number of units
  nbrOfUnits <- nbrOfUnits(udf)

  # Generate filename: <chipType>(,tags)*.<ext>
  chipType <- getChipType(udf)

  # Exclude 'monocell' tags (AD HOC)
  chipType <- gsub(",monocell", "", chipType, fixed=TRUE)

  fullname <- paste(c(chipType, tags), collapse=",")
  ext <- getFilenameExtension(static)
  filename <- sprintf("%s.%s", fullname, ext)

  # Create microarray tabular binary file
  allocate(static, filename=filename, path=path, nbrOfRows=nbrOfUnits, 
                                platform=platform, chipType=chipType, ...)
}, static=TRUE, protected=TRUE)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# END: UnitNamesFile
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
