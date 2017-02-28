## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## DEFUNCT
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setMethodS3("whatDataType", "default", function(type, ...) {
  .Defunct(msg = "whatDataType() is deprecated (as of aroma.core 2.14.0) with no alternative implementation. Please contact the maintainer of the aroma.core package if you wish that this function should remain available.")
}, private=TRUE, deprecated=TRUE)


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## DEPRECATED
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## TO DEPRECATE
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



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
