## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## DEFUNCT
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 2015-09-17
# o Defunct.
# 2008-05-16
# o Removed deprecated readData().
setMethodS3("readData", "SampleAnnotationFile", function(this, ...) {
  .Defunct("readDataFrame")
  readDataFrame(this, ...)
}, protected=TRUE, deprecated=TRUE)


# 2015-09-17
# o Defunct.
# 2009-12-30
# o Dropped nbrOfArrays() use nbrOfFiles() instead.
setMethodS3("nbrOfArrays", "AromaMicroarrayDataSetTuple", function(this, ...) {
  .Defunct("length")
  length(this, ...)
}, protected=TRUE, deprecated=TRUE)


# 2015-09-17
# o Defunct.
# 2013-01-03
# o Deprecated nbrOfArrays() for AromaMicroarrayDataSet and
#   AromaUnitTotalCnBinarySet.
setMethodS3("nbrOfArrays", "AromaMicroarrayDataSet", function(this, ...) {
  .Defunct("length")
  length(this, ...)
}, protected=TRUE, deprecated=TRUE)

setMethodS3("nbrOfArrays", "AromaUnitTotalCnBinarySet", function(this, ...) {
  .Defunct("length")
  length(this, ...)
}, protected=TRUE, deprecated=TRUE)



############################################################################
# HISTORY:
# 2014-02-28
# o CLEANUP: Defuncted previously deprecated downloadPackagePatch() and
#   patchPackage() as well as patch() for AromaPackage.
# 2014-02-28
# o CLEANUP: Removed defunct methods, i.e. is(Homo|Hetero)zygote() and
#   getPhysicalPositions().
# 2013-04-20
# o CLEANUP: Made is(Homo|Hetero)zygote() & getPhysicalPositions() defunct.
# 2012-10-14
# o Created 999.DEPRECATED.R.
# 2011-02-18
# o CLEANUP: Deprecated static method importFromTable() for FileMatrix.
############################################################################
