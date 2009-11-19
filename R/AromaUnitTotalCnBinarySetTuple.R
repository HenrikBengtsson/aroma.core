setConstructorS3("AromaUnitTotalCnBinarySetTuple", function(..., .setClass="AromaUnitTotalCnBinarySet") {
  extend(AromaMicroarrayDataSetTuple(..., .setClass=.setClass), c("AromaUnitTotalCnBinarySetTuple", uses("CopyNumberDataSetTuple")));
})


setMethodS3("as.AromaUnitTotalCnBinarySetTuple", "AromaUnitTotalCnBinarySetTuple", function(this, ...) {
  # Nothing do to
  this;
})


setMethodS3("nbrOfArrays", "AromaUnitTotalCnBinarySet", function(this, ...) {
  nbrOfFiles(this, ...);
})


setMethodS3("getListOfUnitNamesFiles", "AromaUnitTotalCnBinarySetTuple", function(this, ...) {
  sets <- getListOfSets(this);
  lapply(sets, FUN=getUnitNamesFile);
})


setMethodS3("getUnitNamesFile", "AromaUnitTotalCnBinarySet", function(this, ...) {
  if (nbrOfFiles(this) == 0) {
    throw("Cannot locate unit names file. Data set is empty: ", getFullName(this));
  }

  df <- getFile(this, 1);
  getUnitNamesFile(df, ...);
})


###########################################################################
# HISTORY:
# 2009-11-19
# o Created.
###########################################################################
