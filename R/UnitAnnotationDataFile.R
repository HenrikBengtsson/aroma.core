###########################################################################/**
# @RdocClass UnitAnnotationDataFile
#
# @title "The UnitAnnotationDataFile interface class"
#
# \description{
#  @classhierarchy
#
#  A UnitAnnotationDataFile provides methods for querying certain types
#  of chip type annotation data by units.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "R.oo::Interface".}
# }
#
# \section{Methods}{
#  @allmethods "public"
# }
#
# @author
#*/###########################################################################
setConstructorS3("UnitAnnotationDataFile", function(...) {
  extend(Interface(), "UnitAnnotationDataFile");
})

setMethodS3("getChipType", "UnitAnnotationDataFile", abstract=TRUE);

setMethodS3("getPlatform", "UnitAnnotationDataFile", abstract=TRUE);

setMethodS3("nbrOfUnits", "UnitAnnotationDataFile", abstract=TRUE);


setMethodS3("byChipType", "UnitAnnotationDataFile", function(static, chipType, tags=NULL, nbrOfUnits=NULL, ..., verbose=FALSE) {
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
                             firstOnly=FALSE, ..., verbo=less(verbose, 5));
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



setMethodS3("getAromaUgpFile", "UnitAnnotationDataFile", function(this, ..., validate=FALSE, force=FALSE) {
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
# 2009-07-08
# o Extracted methods from the UnitNamesFile interface class.
# o Created from UnitNamesFile.R.
############################################################################
