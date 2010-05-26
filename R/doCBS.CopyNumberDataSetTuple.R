setMethodS3("doCBS", "CopyNumberDataSetTuple", function(dsTuple, ..., arrays=NULL, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'dsTuple':
  dsTuple <- as.CopyNumberDataSetTuple(dsTuple);

  # Argument 'arrays':
  if (!is.null(arrays)) {
    arrays <- Arguments$getIndices(arrays, max=nbrOfFiles(dsTuple));
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  verbose && enter(verbose, "CBS");
  verbose && cat(verbose, "Arguments:");
  arraysTag <- seqToHumanReadable(arrays);
  verbose && cat(verbose, "arrays (to be segmented):");
  verbose && str(verbose, arraysTag);

  verbose && cat(verbose, "Data set tuple");
  verbose && print(verbose, dsTuple);

  verbose && enter(verbose, "CBS/segmentation");
  cbs <- CbsModel(dsTuple, ...);
  verbose && print(verbose, cbs);
  fit(cbs, arrays=arrays, ..., verbose=verbose);
  verbose && exit(verbose);

  res <- getOutputSet(cbs, verbose=less(verbose, 5));
  verbose && print(verbose, res);

  # Clean up
  rm(cbs);
  gc <- gc();
  
  verbose && exit(verbose);

  invisible(res);
}) # doCBS()


############################################################################
# HISTORY:
# 2010-05-25
# o Created from ditto for CopyNumberDataSet.
# 2010-02-25
# o CHANGE: Argument 'arrays' of doCBS() for CopyNumberDataSet no longer
#   subset the input data set, but instead is passed to the fit() function
#   of the segmentation model.  This way all arrays in the input data set 
#   are still used for calculating the pooled reference.
# 2010-02-18
# o Created.
############################################################################
