# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# 2009-06-09
# o Grammar fix: is(Homo|Hetero)zygous(), not is(Homo|Hetero)zygote().
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
setMethodS3("isHomozygote", "AromaUnitGenotypeCallFile", function(...) {
  .Deprecated("isHomozygous");
  isHomozygous(...);
}, private=TRUE, deprecated=TRUE)

setMethodS3("isHeterozygote", "AromaUnitGenotypeCallFile", function(...) {
  .Deprecated("isHeterozygous");
  isHeterozygous(...);
}, private=TRUE, deprecated=TRUE)

setMethodS3("getPhysicalPositions", "RawCopyNumbers", function(this, ...) {
  .Deprecated("getPositions");
  getPositions(this, ...);
}, protected=TRUE, deprecated=TRUE)


# 2008-05-16
# o Removed deprecated readData().
setMethodS3("readData", "SampleAnnotationFile", function(this, ...) {
  .Deprecated("readDataFrame");
  readDataFrame(this, ...);
}, protected=TRUE, deprecated=TRUE)
 

############################################################################
# HISTORY:
# 2012-10-14
# o Created 999.DEPRECATED.R.
# 2011-02-18
# o CLEANUP: Deprecated static method importFromTable() for FileMatrix.
############################################################################
