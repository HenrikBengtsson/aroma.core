setMethodS3("extractOld", "AromaMicroarrayDataSetTuple", function(this, arrays, ..., verbose=FALSE) {
  throw("DEPRECATED");
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Extracting subset of arrays");

  # Identify the array indices for each chip type
  arrayTable <- getTableOfArrays(this);
  rr <- indexOf(this, arrays);
  verbose && print(verbose, rr);
  arrayTable <- arrayTable[rr,,drop=FALSE];
  ccs <- whichVector(apply(arrayTable, MARGIN=2, FUN=function(idxs) {
    any(!is.na(idxs));
  }));
  verbose && print(verbose, ccs);
  arrayTable <- arrayTable[,ccs,drop=FALSE];

  verbose && print(verbose, arrayTable);
  
  # Extract only those arrays
  res <- clone(this);
  dsList <- getSets(this)[ccs];
  verbose && str(verbose, dsList);

  for (kk in seq(along=dsList)) {
    cs <- dsList[[kk]];
    idxs <- arrayTable[,kk];
    idxs <- na.omit(idxs);
    cs <- extract(cs, idxs);
    dsList[[kk]] <- cs;
  }
  res$.dsList <- dsList;

  verbose && str(verbose, dsList);

  verbose && exit(verbose);

  res;
}, deprecated=TRUE)




setMethodS3("getArrays", "AromaMicroarrayDataSetTuple", function(this, ...) {
  throw("DEPRECATED");
  arrays <- getNames(this, ...);
  names(arrays) <- getFullNames(this, ...);
  arrays;
}, deprecated=TRUE)



###########################################################################/**
# @set "class=AromaMicroarrayDataSetTuple"
# @RdocMethod getTableOfArrays
#
# @title "Gets a table of arrays"
#
# \description{
#  @get "title" showing their availability across chip types.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a \eqn{NxK} @matrix of positive @integers where \eqn{N} is the 
#  total number of arrays and \eqn{K} is the number of chip types in 
#  the model.  The row names are the names of the arrays, and 
#  the column names are the chip types.
#  If data is available for array \eqn{n} and chip type \eqn{k}, cell 
#  \eqn{(n,k)} has value \eqn{n}, otherwise @NA.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getTableOfArrays", "AromaMicroarrayDataSetTuple", function(this, ...) {
  throw("DEPRECATED");
  dsList <- getSets(this);

  # Get all chip types for this data set
  chipTypes <- getChipTypes(this);
  nbrOfChipTypes <- length(dsList);

  # Get all sample names
  names <- lapply(dsList, FUN=getNames, ...);
  names(names) <- chipTypes;

  # Get all sample names
  allNames <- unlist(names, use.names=FALSE);

  # Get all unique names
  allNames <- unique(allNames);
  lens <- sapply(names, FUN=length);
  nbrOfArrays <- max(lens, length(allNames));
  allNames <- rep(allNames, length.out=nbrOfArrays);

  # Create table of arrays
  nbrOfArrays <- length(allNames);
  X <- matrix(NA, nrow=nbrOfArrays, ncol=nbrOfChipTypes);
  dimnames(X) <- list(allNames, chipTypes);
  for (chipType in chipTypes) {
    idxs <- match(rownames(X), names[[chipType]]);
    X[,chipType] <- idxs;
  }

  X;
}, protected=TRUE, deprecated=TRUE)




###########################################################################/**
# @RdocMethod getArrayTuple
#
# @title "Gets arrays across chip types for one sample"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{array}{Sample of interest.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a named @list of @see "AromaMicroarrayDataSet":s.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getArrayTuple", "AromaMicroarrayDataSetTuple", function(this, array, ...) {
  throw("DEPRECATED");
  # Get table of arrays
  arrayTable <- getTableOfArrays(this, ...);

  # Argument 'array':
  if (is.numeric(array)) {
    array <- Arguments$getIndex(array, max=nrow(arrayTable));
  } else {
    array <- Arguments$getCharacter(array, length=c(1,1));
    arrayNames <- rownames(arrayTable);
    if (!array %in% arrayNames)
      throw("Argument 'array' refers to a non-existing array: ", array);
  }


  # Get tuple of array indices across chip types
  idxs <- arrayTable[array,];

  # Allocated array tuple
  chipTypes <- colnames(arrayTable);
  tuple <- vector("list", length(chipTypes));

  # Extract tuple
  dsList <- getSets(this);
  for (kk in seq(along=dsList)) {
    idx <- idxs[kk];
    if (is.na(idx))
      next;
    cs <- dsList[[kk]];
    tuple[[kk]] <- getFile(cs, idx);
  }
  names(tuple) <- chipTypes;

  tuple;
}, deprecated=TRUE)


setMethodS3("asMatrixOfFiles", "AromaMicroarrayDataSetTuple", function(this, ..., verbose=FALSE) {
  throw("DEPRECATED");
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Extracting matrix of files");

  dsList <- getSets(this);

  # Identify the array indices for each chip type
  arrayTable <- getTableOfArrays(this, ...);
  verbose && print(verbose, arrayTable);

  arrayOfFiles <- rep(NA, length(arrayTable));
  arrayOfFiles <- as.list(arrayOfFiles);
  dim(arrayOfFiles) <- dim(arrayTable);
  dimnames(arrayOfFiles) <- dimnames(arrayTable);

  for (cc in seq(length=ncol(arrayOfFiles))) {
    files <- as.list(dsList[[cc]]);
    files <- files[arrayTable[,cc]];
    arrayOfFiles[,cc] <- files;
  }
  rm(files, arrayTable, dsList);

  verbose && exit(verbose);

  arrayOfFiles;
}, protected=TRUE, deprecated=TRUE)





##############################################################################
# HISTORY:
# 2011-02-18
# o CLEANUP: Removed deprecated AromaMicroarrayDataSetTuple methods: 
#   extractOld(), getArrays(), getTableOfArrays(), getArrayTuple(), 
#   and asMatrixOfFiles().
# 2009-12-30
# o Renamed indexOfArrays() to indexOf().
# o Dropped nbrOfArrays(); use nbrOfFiles() instead.
# o CLEAN UP: Dropped get- and setAlias().
# o Made into a GenericDataFileSetList.
# o Create from AromaMicroarrayDataSetTuple.R.
# 2008-06-03
# o Added argument 'fullnames=FALSE' to getChipTypes() for 
#   AromaMicroarrayDataSetTuple.
# 2008-05-21
# o BUG FIX: getFullNames() was not passing down new 'translate' correctly.
# 2008-05-16
# o Abstract methods right now: byPath().
# o Made getChipTypes() platform independent (not querying CDF:s anymore).
# o Now getFullName() getTableOfArrays(), getArrays(), indexOfArrays(), 
#   getArrayTuple(), and asMatrixOfFiles() passes down '...' (for the 
#   purpose passing down argument 'translate').
# o Now getFullNames() passes down 'translate'.
# 2008-03-29
# o getTableOfArrays() of AromaMicroarrayDataSetTuple returned the incorrect 
#   array indices for the 2nd chip type if different arrays in the two sets.
# 2008-03-11
# o Renamed getTuple() to getArrayTuple().
# 2007-03-29
# o Added asMatrixOfFiles().
# 2007-03-20
# o Now getArrays() returns a named list where the names are the result from
#   getFullNames().
# 2007-03-19
# o TODO: Handle replicated sample names. It is not clear how this should be
#   done.
# o Created from GladModel.R.
##############################################################################
