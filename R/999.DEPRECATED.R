# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 2009-06-09
# o Grammar fix: is(Homo|Hetero)zygous(), not is(Homo|Hetero)zygote().
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setMethodS3("isHomozygote", "AromaUnitGenotypeCallFile", function(...) {
  .Defunct("isHomozygous");
  isHomozygous(...);
}, private=TRUE, deprecated=TRUE)

setMethodS3("isHeterozygote", "AromaUnitGenotypeCallFile", function(...) {
  .Defunct("isHeterozygous");
  isHeterozygous(...);
}, private=TRUE, deprecated=TRUE)


setMethodS3("getPhysicalPositions", "RawCopyNumbers", function(this, ...) {
  .Defunct("getPositions");
  getPositions(this, ...);
}, protected=TRUE, deprecated=TRUE)


# 2008-05-16
# o Removed deprecated readData().
setMethodS3("readData", "SampleAnnotationFile", function(this, ...) {
  .Deprecated("readDataFrame");
  readDataFrame(this, ...);
}, protected=TRUE, deprecated=TRUE)



# 2009-12-30
# o Dropped nbrOfArrays(); use nbrOfFiles() instead.
setMethodS3("nbrOfArrays", "AromaMicroarrayDataSetTuple", function(this, ...) {
  .Deprecated("length");
  length(this, ...);
}, protected=TRUE)


# 2013-01-03
# o Deprecated nbrOfArrays() for AromaMicroarrayDataSet and
#   AromaUnitTotalCnBinarySet.
setMethodS3("nbrOfArrays", "AromaMicroarrayDataSet", function(this, ...) {
  .Deprecated("length");
  length(this, ...);
})

setMethodS3("nbrOfArrays", "AromaUnitTotalCnBinarySet", function(this, ...) {
  .Deprecated("length");
  length(this, ...);
}, protected=TRUE)



############################################################################
# HISTORY:
# 2013-04-20
# o CLEANUP: Made is(Homo|Hetero)zygote() defunct.
# 2012-10-14
# o Created 999.DEPRECATED.R.
# 2011-02-18
# o CLEANUP: Deprecated static method importFromTable() for FileMatrix.
############################################################################
