###########################################################################/**
# @RdocClass AromaUnitCallSet
#
# @title "The AromaUnitCallSet class"
#
# \description{
#  @classhierarchy
#
#  An AromaUnitCallSet object represents a set of 
#  @see "AromaUnitCallFile"s with \emph{identical} chip types.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "AromaUnitSignalBinarySet".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#*/###########################################################################
setConstructorS3("AromaUnitCallSet", function(...) {
  extend(AromaUnitSignalBinarySet(...), "AromaUnitCallSet");
})


setMethodS3("findByName", "AromaUnitCallSet", function(static, ..., paths="callData") {
  findByName.AromaUnitSignalBinarySet(static, ..., paths=paths);
}, static=TRUE) 


setMethodS3("byPath", "AromaUnitCallSet", function(static, ..., pattern=".*[.]acf$") {
  suppressWarnings({
    byPath.GenericDataFileSet(static, ..., pattern=pattern);
  })
})


setMethodS3("findUnitsTodo", "AromaUnitCallSet", function(this, ...) {
  # Look into the last chip-effect file since that is updated last
  df <- getFile(this, length(this));
  findUnitsTodo(df, ...);
})


setMethodS3("extractCallArray", "AromaUnitCallSet", function(this, ..., drop=FALSE) {
  res <- NULL;
  for (kk in seq(length=nbrOfFiles(this))) {  
    df <- getFile(this, kk);
    values <- extractCalls(df, ..., drop=FALSE);

    if (is.null(res)) {
      dim <- dim(values);
      dim[length(dim)] <- nbrOfFiles(this);
      res <- array(values[1], dim=dim);
    }

    res[,,kk] <- values;
  } # for (kk ...)

  # Drop singletons?
  if (drop) {
    res <- drop(res);
  }

  res;
})


setMethodS3("extractCalls", "AromaUnitCallSet", function(this, ...) {
  extractCallArray(this, ...);
})


############################################################################
# HISTORY:
# 2009-01-04
# o Created.
############################################################################
