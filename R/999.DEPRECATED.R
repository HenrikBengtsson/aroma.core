setMethodS3("downloadPackagePatch", "default", function(pkgName, version=NULL, url=NULL, apply=TRUE, rootPath="~/.Rpatches", pkgVer=NULL, ..., verbose=FALSE) {
  .Defunct(msg="downloadPackagePatch() is deprecated without alternatives.");
}, protected=TRUE, deprecated=TRUE)

setMethodS3("patchPackage", "default", function(pkgName, paths=c("~/.Rpatches/", "patches/"), deleteOld=TRUE, verbose=FALSE, ...) {
  .Defunct(msg="patchPackage() is deprecated without alternatives.");
}, protected=TRUE, deprecated=TRUE)


setMethodS3("patch", "AromaPackage", function(this, ..., verbose=FALSE) {
  .Defunct(msg="patch() for AromaPackage is deprecated without alternatives.");
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
}, protected=TRUE, deprecated=TRUE)


# 2013-01-03
# o Deprecated nbrOfArrays() for AromaMicroarrayDataSet and
#   AromaUnitTotalCnBinarySet.
setMethodS3("nbrOfArrays", "AromaMicroarrayDataSet", function(this, ...) {
  .Deprecated("length");
  length(this, ...);
}, protected=TRUE, deprecated=TRUE)

setMethodS3("nbrOfArrays", "AromaUnitTotalCnBinarySet", function(this, ...) {
  .Deprecated("length");
  length(this, ...);
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
