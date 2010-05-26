setMethodS3("doCBS", "character", function(dataSets, tags=NULL, chipTypes, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'dataSets':
  dataSets <- Arguments$getCharacter(dataSets);

  # Argument 'tags':
  if (!is.null(tags)) {
    tags <- Arguments$getCharacters(tags);
    tags <- paste(tags, collapse=",");
  }

  # Argument 'chipTypes':
  chipTypes <- Arguments$getCharacters(chipTypes);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  verbose && enter(verbose, "CBS");


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Parsing arguments into data set tuple
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "CBS/Parsing arguments");
  args <- list(
    dataSet=dataSets,
    tags=tags,
    chipType=chipTypes
  );
  ns <- sapply(args, FUN=length);
  args <- args[ns > 0];

  verbose && cat(verbose, "Original arguments:");
  verbose && str(verbose, args);

  # Split
  args <- lapply(args, FUN=function(arg) {
    unlist(strsplit(arg, split="|", fixed=TRUE), use.names=FALSE);
  });

  # Sanity check
  ns <- sapply(args, FUN=length);
  nbrOfDataSets <- max(ns);
  if (any(ns[ns > 1] != nbrOfDataSets)) {
    throw("The arguments 'dataSets', 'tags', and 'chipTypes' do not specifies the same number of data sets: ", paste(ns, collapse=", "));
  }

  # Expand
  args <- lapply(args, FUN=rep, length.out=nbrOfDataSets);
  args <- as.data.frame(args, stringsAsFactors=FALSE);

  verbose && cat(verbose, "Parsed and expanded arguments:");
  verbose && str(verbose, args);
  verbose && exit(verbose);


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Setting up data set tuple
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "CBS/Setting up data set tuple");
  verbose && cat(verbose, "Number of data sets: ", nbrOfDataSets);

  dsList <- vector("list", nbrOfDataSets);
  for (kk in seq(length=nbrOfDataSets)) {
    verbose && enter(verbose, sprintf("Data set #%d of %d", kk, nbrOfDataSets));
    argsKK <- args[kk,];
    verbose && cat(verbose, "Arguments:");
    verbose && str(verbose, args);

    # Defaults overwritten by attachLocally()/To please R CMD check.
    dataSet <- tags <- chipType <- NULL;
    attachLocally(argsKK);

    ds <- AromaUnitTotalCnBinarySet$byName(dataSet, tags=tags, 
      chipType=chipType, verbose=less(verbose, 50), .onUnknownArgs="ignore");
    verbose && print(verbose, ds);
  
    dsList[[kk]] <- ds;
    rm(ds);

    verbose && exit(verbose);
  } # for (kk ...)

  # Coerce to a dataset tuple
  dsTuple <- as.CopyNumberDataSetTuple(dsList);
  verbose && print(verbose, dsTuple);

  # Not needed anymore
  rm(dsList);
  verbose && exit(verbose);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Segmentating genomic signals
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  res <- doCBS(dsTuple, ..., verbose=verbose);

  # Clean up
  rm(ds);
  gc <- gc();

  verbose && exit(verbose);

  invisible(res);
})


############################################################################
# HISTORY:
# 2010-05-25
# o Added support for data set tuples.
# o Renamed arguments with plural 's'.
# 2010-02-18
# o Created.
############################################################################
