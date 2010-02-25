setMethodS3("doCBS", "CopyNumberDataSet", function(ds, ..., arrays=NULL, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'ds':
  className <- "CopyNumberDataSet";
  if (!inherits(ds, className)) {
    throw(sprintf("Argument 'ds' is not a %s: %s", className, class(ds)[1]));
  }

  # Argument 'arrays':
  if (!is.null(arrays)) {
    arrays <- Arguments$getIndices(arrays, max=nbrOfArrays(ds));
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  verbose && enter(verbose, "CBS");
  verbose && cat(verbose, "Arguments:");
  arraysTag <- seqToHumanReadable(arrays);
  verbose && cat(verbose, "arrays (to be segmented):");
  verbose && str(verbose, arraysTag);

  verbose && cat(verbose, "Data set");
  verbose && print(verbose, ds);

  verbose && enter(verbose, "CBS/segmentation");
  cbs <- CbsModel(ds, ...);
  verbose && print(verbose, cbs);
  fit(cbs, arrays=arrays, ..., verbose=verbose);
  verbose && exit(verbose);

  res <- getOutputSet(cbs);
  verbose && print(verbose, res);

  # Clean up
  rm(cbs);
  gc <- gc();
  
  verbose && exit(verbose);

  invisible(res);
}) # doCBS()


############################################################################
# HISTORY:
# 2010-02-25
# o CHANGE: Argument 'arrays' of doCBS() for CopyNumberDataSet no longer
#   subset the input data set, but instead is passed to the fit() function
#   of the segmentation model.  This way all arrays in the input data set 
#   are still used for calculating the pooled reference.
# 2010-02-18
# o Created.
############################################################################
