setConstructorS3("CbsSegmentationDataSet", function(...) {
  extend(SegmentationDataSet(...), "CbsSegmentationDataSet");
})

setMethodS3("byPath", "CbsSegmentationDataSet", function(static, ..., pattern=",chr[0-9]+,.*[.]xdr$") {
  byPath.GenericDataFileSet(static, ..., pattern=pattern);
}, static=TRUE)


setMethodS3("byName", "CbsSegmentationDataSet", function(static, ..., chipType, paths="cbsData/") {
  # Argument 'chipType':
  chipType <- Arguments$getCharacter(chipType);

  byName.GenericDataFileSet(static, ..., subdirs=chipType, paths=paths);
}, static=TRUE)






############################################################################
# HISTORY:
# 2010-08-06
# o Added getDefaultFullName() and getChipType().
# o Added byName().
# 2010-08-05
# o Created.
############################################################################
