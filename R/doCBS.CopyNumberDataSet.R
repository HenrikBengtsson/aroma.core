setMethodS3("doCBS", "CopyNumberDataSet", function(ds, ...) {
  dsTuple <- as.CopyNumberDataSetTuple(ds);

  res <- doCBS(dsTuple, ...);

  invisible(res);
}) # doCBS()


############################################################################
# HISTORY:
# 2010-05-25
# o Now doCBS() for CopyNumberDataSet calls same for CopyNumberDataSetTuple.
# 2010-02-25
# o CHANGE: Argument 'arrays' of doCBS() for CopyNumberDataSet no longer
#   subset the input data set, but instead is passed to the fit() function
#   of the segmentation model.  This way all arrays in the input data set 
#   are still used for calculating the pooled reference.
# 2010-02-18
# o Created.
############################################################################
