###########################################################################/**
# @RdocDefault doCBS
# @alias doCBS.CopyNumberDataSetTuple
# @alias doCBS.CopyNumberDataSet
# @alias doCBS.character
#
# @title "Performs Circular Binary Segmentation (CBS) on a data set"
#
# \description{
#  @get "title" for one or more chip types.
# }
#
# \usage{
#   @usage doCBS,default
#   @usage doCBS,CopyNumberDataSet
#   @usage doCBS,CopyNumberDataSetTuple
# }
#
# \arguments{
#  \item{ds, dsTuple, dataSet}{A @see "CopyNumberDataSet", a @see "CopyNumberDataSetTuple" or a @character string with the name of one of them.}
#   \item{tags}{An optional @character @vector of data set tags (only when \code{dataSet} is specified).}
#   \item{chipTypes}{A @character @vector specifying the chip types
#     for the different data sets (only when \code{dataSet} is specified).}
#   \item{arrays}{An optional @vector specifying the subset of arrays to process.}
#   \item{...}{Additional arguments passed to @see "CbsModel" and
#     its \code{fit()} method.}
#   \item{verbose}{A @logical or @see "R.utils::Verbose".}
# }
#
# \value{
#  Returns the output dataset of @see "CbsModel".
# }
#
# \examples{\dontrun{
#   @include "../incl/doCBS.Rex"
# }}
#
# @author "HB"
#*/###########################################################################
setMethodS3("doCBS", "CopyNumberDataSetTuple", function(dsTuple, arrays=NULL, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'dsTuple':
  dsTuple <- as.CopyNumberDataSetTuple(dsTuple);

  # Argument 'arrays':
  if (!is.null(arrays)) {
    arrays <- Arguments$getIndices(arrays, max=length(dsTuple));
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

  # Not needed anymore
  cbs <- NULL;
  gc <- gc();

  verbose && exit(verbose);

  invisible(res);
}) # doCBS()


setMethodS3("doCBS", "default", function(dataSet, tags=NULL, chipTypes, arrays=NULL, ..., verbose=FALSE) {
  pkg <- "aroma.core";
  require(pkg, character.only=TRUE) || throw("Package not loaded: ", pkg);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'dataSet':
  dataSet <- Arguments$getCharacter(dataSet);

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
    dataSet=dataSet,
    tags=tags,
    chipType=chipTypes
  );
  ns <- sapply(args, FUN=length);
  args <- args[ns > 0L];

  verbose && cat(verbose, "Original arguments:");
  verbose && str(verbose, args);

  # Split
  args <- lapply(args, FUN=function(arg) {
    unlist(strsplit(arg, split="|", fixed=TRUE), use.names=FALSE);
  });

  # Sanity check
  ns <- sapply(args, FUN=length);
  nbrOfDataSets <- max(ns);
  if (any(ns[ns > 1L] != nbrOfDataSets)) {
    throw("The arguments 'dataSet', 'tags', and 'chipTypes' do not specifies the same number of data sets: ", paste(ns, collapse=", "));
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
  for (kk in seq_len(nbrOfDataSets)) {
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
    # Not needed anymore
    ds <- NULL;

    verbose && exit(verbose);
  } # for (kk ...)

  # Coerce to a dataset tuple
  dsTuple <- as.CopyNumberDataSetTuple(dsList);
  verbose && print(verbose, dsTuple);

  # Not needed anymore
  dsList <- NULL;
  verbose && exit(verbose);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Segmentating genomic signals
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  res <- doCBS(dsTuple, arrays=arrays, ..., verbose=verbose);

  # Not needed anymore
  dsTuple <- NULL;
  gc <- gc();

  verbose && exit(verbose);

  invisible(res);
})


setMethodS3("doCBS", "CopyNumberDataSet", function(ds, arrays=NULL, ...) {
  dsTuple <- as.CopyNumberDataSetTuple(ds);

  res <- doCBS(dsTuple, arrays=arrays, ...);

  invisible(res);
}) # doCBS()
