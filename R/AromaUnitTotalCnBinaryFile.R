###########################################################################/**
# @RdocClass AromaUnitTotalCnBinaryFile
#
# @title "The AromaUnitTotalCnBinaryFile class"
#
# \description{
#  @classhierarchy
#
#  An AromaUnitTotalCnBinaryFile is a @see "AromaUnitSignalBinaryFile".
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
setConstructorS3("AromaUnitTotalCnBinaryFile", function(...) {
  extend(AromaUnitSignalBinaryFile(...), c("AromaUnitTotalCnBinaryFile", uses("CopyNumberDataFile"))
  );
})


setMethodS3("hasAlleleBFractions", "AromaUnitTotalCnBinaryFile", function(this, ...) {
  # By definition, always FALSE
  FALSE;
})

setMethodS3("hasStrandiness", "AromaUnitTotalCnBinaryFile", function(this, ...) {
  # For now always FALSE, due to how the (super)classes are defined. 
  # /HB 2009-11-19
  FALSE;
})
 

setMethodS3("extractRawCopyNumbers", "AromaUnitTotalCnBinaryFile", function(this, ..., clazz=RawCopyNumbers) {
  extractRawGenomicSignals(this, ..., clazz=clazz);
})



############################################################################
# HISTORY:
# 2009-05-17
# o Now extractRawCopyNumbers() of AromaUnitTotalCnBinaryFile utilized
#   extractRawGenomicSignals() of the superclass.
# 2009-02-17
# o Added argument 'units' to extractRawCopyNumbers().
# 2009-02-16
# o Now extractRawCopyNumbers() also includes the full (sample) name.
# 2008-06-12
# o Now extractRawCopyNumbers() adds annotation data to the returned object,
#   i.e. platform, chipType, and fullname.
# 2008-05-21
# o Added extractRawCopyNumbers().
# 2008-05-11
# o Created.
############################################################################
