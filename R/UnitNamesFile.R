###########################################################################/**
# @RdocClass UnitNamesFile
#
# @title "The UnitNamesFile class"
#
# \description{
#  @classhierarchy
#
#  A UnitNamesFile provides methods for querying the unit names of
#  a given chip type.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "Interface".}
# }
#
# \section{Methods}{
#  @allmethods "public"
# }
#
# @author
#*/###########################################################################
setConstructorS3("UnitNamesFile", function(...) {
  extend(Interface(), "UnitNamesFile");
})


setMethodS3("getUnitNames", "UnitNamesFile", abstract=TRUE);

setMethodS3("nbrOfUnits", "UnitNamesFile", function(this, ...) {
  length(getUnitNames(this));
})


setMethodS3("getChipType", "UnitNamesFile", abstract=TRUE);

setMethodS3("getPlatform", "UnitNamesFile", abstract=TRUE);


setMethodS3("byChipType", "UnitNamesFile", function(static, chipType, tags=NULL, nbrOfUnits=NULL, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'chipType':
  chipType <- Arguments$getCharacter(chipType, length=c(1,1));

  # Argument 'nbrOfUnits':
  if (!is.null(nbrOfUnits)) {
    nbrOfUnits <- Arguments$getInteger(nbrOfUnits, range=c(0,Inf));
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  } 


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Scan for all possible matches
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  pathnames <- findByChipType(static, chipType=chipType, tags=tags, 
                                                     firstOnly=FALSE, ...);
  if (is.null(pathnames)) {
    throw("Could not locate a file for this chip type: ", 
                                   paste(c(chipType, tags), collapse=","));
  }

  verbose && cat(verbose, "Number of ", class(static)[1], " located: ", 
                                                        length(pathnames));
  verbose && print(verbose, pathnames);


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Look for first possible valid match
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Scanning for a valid file");

  for (kk in seq(along=pathnames)) {
    pathname <- pathnames[kk];
    verbose && enter(verbose, "File #", kk, " (", pathname, ")");

    # Create object
    res <- newInstance(static, pathname);

    # Correct number of units?
    if (!is.null(nbrOfUnits)) {
      if (nbrOfUnits(res) != nbrOfUnits) {
        res <- NULL;
      }
    }

    if (!is.null(res)) {
      verbose && cat(verbose, "Found a valid ", class(static)[1]);
      verbose && exit(verbose);
      break;
    }

    verbose && exit(verbose);
  } # for (kk ...)

  if (is.null(res)) {
    queryStr <- paste(c(chipType, tags), collapse=",");
    throw("Failed to located a (valid) tabular binary file: ", queryStr);
  }

  verbose && print(verbose, res);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Final validation
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!is.null(nbrOfUnits)) {
    if (nbrOfUnits(res) != nbrOfUnits) {
      throw("The number of units in the loaded ", class(static)[1], " does not match the expected number: ", nbrOfUnits(res), " != ", nbrOfUnits);
    }
  }

  verbose && exit(verbose);

  res;
}, static=TRUE)


###########################################################################/**
# @RdocMethod indexOf
#
# @title "Gets the indices of units by their names"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{pattern}{A pattern to be used for identifying unit names of 
#      interest.  If @NULL, no regular expression matching is done.}
#   \item{names}{Names to be match exactly to the unit names.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @vector of @integers in [1,N] where N is the number of units
#  in the underlying annotation chip type file.
# }
#
# @author
#
# \seealso{
#   @seemethod "getUnitNames".
#   @seeclass
# }
#
# @keyword IO
#*/###########################################################################
setMethodS3("indexOf", "UnitNamesFile", function(this, pattern=NULL, names=NULL, ...) {
  # Arguments 'pattern' & 'names':
  if (!is.null(pattern) && !is.null(names)) {
    throw("Only one of arguments 'pattern' and 'names' can be specified.");
  }

  if (is.null(pattern) && is.null(names)) {
    throw("Either argument 'names' or 'pattern' must be specified.");
  }

  if (!is.null(pattern)) {
    if (length(pattern) != 1) {
      throw("If specified, argument 'pattern' must be a single string. Did you mean to use argument 'names'?");
    }
    pattern <- Arguments$getRegularExpression(pattern);
    idxs <- grep(pattern, getUnitNames(this));
  } else if (!is.null(names)) {
    idxs <- match(names, getUnitNames(this));
  }

  idxs;
})


setMethodS3("getAromaUgpFile", "UnitNamesFile", function(this, ..., validate=FALSE, force=FALSE) {
  ugp <- this$.ugp;
  if (force || is.null(ugp)) {
    chipType <- getChipType(this, ...);
    ugp <- AromaUgpFile$byChipType(chipType, nbrOfUnits=nbrOfUnits(this), validate=validate);
    # Sanity check
    if (nbrOfUnits(ugp) != nbrOfUnits(this)) {
      throw("The number of units in located UGP file ('", getPathname(ugp), "') is not compatible with the data file ('", getPathname(this), "'): ", nbrOfUnits(ugp), " != ", nbrOfUnits(this));
    }
    this$.ugp <- ugp;
  }
  ugp;
}) 

 

############################################################################
# HISTORY:
# 2009-05-18
# o Now indexOf() for UnitNamesFile assert that exactly one of the 'pattern'
#   and 'names' arguments is given.  It also gives an informative error
#   message if 'pattern' is a vector.
# 2009-02-10
# o Added static byChipType() to UnitNamesFile.
# o Added a sanity check to getAromaUgpFile() of UnitNamesFile,
#   which asserts that the number of units in the located UGP file match
#   that of the data file. 
# 2009-01-26
# o Added getAromaUgpFile() to UnitNamesFile.
# 2008-07-21
# o Renamed UnitNamesInterface to UnitNamesFile.
# 2008-05-18
# o Created.
############################################################################
