###########################################################################/**
# @RdocClass AromaUnitCallFile
#
# @title "The AromaUnitCallFile class"
#
# \description{
#  @classhierarchy
#
#  An AromaUnitCallFile is a @see "AromaUnitSignalBinaryFile".
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "AromaUnitSignalBinaryFile".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#*/########################################################################### 
setConstructorS3("AromaUnitCallFile", function(...) {
  extend(AromaUnitSignalBinaryFile(...), "AromaUnitCallFile"
  );
})


setMethodS3("allocate", "AromaUnitCallFile", function(static, ..., types=c("integer"), sizes=rep(1, length(types)), signed=rep(FALSE, length(types))) { 
  res <- allocate.AromaUnitSignalBinaryFile(static, types=types, sizes=sizes, signed=signed, ...);

  # Default call is NA
  nbrOfBits <- 8*sizes[1];
  valueForNA <- as.integer(2^nbrOfBits-1);

  for (cc in seq(length=nbrOfColumns(res))) {
    res[,cc] <- valueForNA;
  }

  res;
}, static=TRUE)


setMethodS3("findUnitsTodo", "AromaUnitCallFile", function(this, units=NULL, ..., force=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Identifying non-fitted units in file");
  verbose && cat(verbose, "Pathname: ", getPathname(this));

  # Reading all calls
  calls <- this[,1,drop=TRUE];

  # Locate the non-fitted ones
  hdr <- readHeader(this)$dataHeader;
  nbrOfBits <- 8*hdr$sizes[1];
  valueForNA <- as.integer(2^nbrOfBits-1);
  isNA <- (calls == valueForNA);

  units <- whichVector(isNA);
  rm(isNA);
  verbose && exit(verbose);

  units;
})


setMethodS3("extractMatrix", "AromaUnitCallFile", function(this, ...) {
  data <- NextMethod("extractMatrix", ...);

  hdr <- readHeader(this)$dataHeader;
  nbrOfBits <- 8*hdr$sizes[1];
  valueForNA <- as.integer(2^nbrOfBits-1);
  naValue <- as.integer(NA);

  isNA <- whichVector(data == valueForNA);
  data[isNA] <- naValue;
 
  data;
})


setMethodS3("extractCallArray", "AromaUnitCallFile", function(this, units=NULL, ..., drop=FALSE, verbose=FALSE) {
  hdr <- readHeader(this)$dataHeader;
  nbrOfBits <- 8*hdr$sizes[1];
  valueForNA <- as.integer(2^nbrOfBits-1);
  naValue <- as.integer(NA);

  res <- NULL;
  for (cc in seq(length=nbrOfColumns(this))) {  
    values <- extractMatrix(this, units=units, column=cc, drop=TRUE, ...);
    isNA <- whichVector(values == valueForNA);
    values[isNA] <- naValue;

    if (is.null(res)) {
      dim <- list(length(values), nbrOfColumns(this), 1);
      res <- array(naValue, dim=dim);
    }
    res[,cc,] <- values;
  } # for (cc ...)

  # Drop singletons?
  if (drop) {
    res <- drop(res);
  }

  res;
})


setMethodS3("extractCalls", "AromaUnitCallFile", function(this, ...) {
  extractCallArray(this, ...);
})




############################################################################
# HISTORY:
# 2009-01-04
# o Created from AromaGenotypeCallFile.R.
############################################################################
