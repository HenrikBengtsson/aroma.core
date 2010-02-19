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
  verbose && cat(verbose, "arrays:");
  verbose && str(verbose, arraysTag);

  verbose && cat(verbose, "Data set");
  verbose && print(verbose, ds);

  if (!is.null(arrays)) {
    verbose && enter(verbose, "CBS/Extracting subset of arrays");
    ds <- extract(ds, arrays);
    verbose && cat(verbose, "Data subset");
    verbose && print(verbose, ds);
    verbose && exit(verbose);
  }

  verbose && enter(verbose, "CBS/segmentation");
  cbs <- CbsModel(ds, ...);
  verbose && print(verbose, cbs);
  fit(cbs, ..., verbose=verbose);
  verbose && exit(verbose);

  res <- getOutputSet(cbs);
  verbose && print(verbose, res);

  # Clean up
  rm(cbs);
  gc <- gc();
  
  verbose && exit(verbose);

  invisible(res);
}) # doCBS()


setMethodS3("doCBS", "character", function(dataSet, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'dataSet':
  dataSet <- Arguments$getCharacter(dataSet);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  verbose && enter(verbose, "CBS");

  verbose && enter(verbose, "CBS/Setting up CEL set");
  ds <- AromaUnitTotalCnBinarySet$byName(dataSet, ..., 
                       verbose=less(verbose, 50), .onUnknownArgs="ignore");
  verbose && print(verbose, ds);
  verbose && exit(verbose);

  res <- doCBS(ds, ..., verbose=verbose);

  # Clean up
  rm(ds);
  gc <- gc();

  verbose && exit(verbose);

  invisible(res);
})


############################################################################
# HISTORY:
# 2010-02-18
# o Created.
############################################################################
