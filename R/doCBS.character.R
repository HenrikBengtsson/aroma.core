setMethodS3("doCBS", "character", function(dataSet, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'dataSet':
  dataSet <- Arguments$getCharacter(dataSet);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  verbose && enter(verbose, "CBS");

  verbose && enter(verbose, "CBS/Setting up data set");
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
