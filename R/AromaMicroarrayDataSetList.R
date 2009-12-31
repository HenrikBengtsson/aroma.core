###########################################################################/**
# @RdocClass AromaMicroarrayDataSetList
#
# @title "The AromaMicroarrayDataSetList class"
#
# \description{
#  @classhierarchy
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "R.filesets::GenericDataFileSetList".}
#   \item{.setClass}{The name of the class of the input set.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# @author
# 
#*/###########################################################################
setConstructorS3("AromaMicroarrayDataSetList", function(..., tags="*", .setClass="AromaMicroarrayDataSet") {
  extend(GenericDataFileSetList(..., .setClass=.setClass), "AromaMicroarrayDataSetList");
})


setMethodS3("as.AromaMicroarrayDataSetList", "AromaMicroarrayDataSetList", function(this, ...) {
  # Nothing to do
  this;
})


setMethodS3("as.character", "AromaMicroarrayDataSetList", function(x, ...) {
  # To please R CMD check
  this <- x;

  s <- sprintf("%s:", class(this)[1]);
  s <- c(s, paste("Name:", getName(this)));
  s <- c(s, paste("Tags:", paste(getTags(this), collapse=",")));
  s <- c(s, paste("Chip types:", paste(getChipTypes(this), collapse=", ")));
  dsList <- getSets(this);
  for (ds in dsList) {
    s <- c(s, as.character(ds));
  }
  s <- c(s, sprintf("RAM: %.2fMB", objectSize(this)/1024^2));

  GenericSummary(s);
}, private=TRUE)



###########################################################################/**
# @RdocMethod extract
#
# @title "Extracts a subset AromaMicroarrayDataSetList"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{arrays}{A @vector of arrays to be extracted.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @see "AromaMicroarrayDataSetList".
# }
#
# \details{
#   If no matching arrays are available for a given chip type, that chip type
#   is excluded in the returned set tuple.  This guarantees that a set tuple
#   always contains existing arrays.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("extract", "AromaMicroarrayDataSetList", function(this, arrays, ..., verbose=FALSE) {
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
  rr <- indexOfArrays(this, arrays);
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
})



setMethodS3("getAsteriskTags", "AromaMicroarrayDataSetList", function(this, ...) {
  "";
}, protected=TRUE)


setMethodS3("getTags", "AromaMicroarrayDataSetList", function(this, collapse=NULL, ...) {
  # Get tags of chip-effect set
  dsList <- getSets(this);

  # Get data set tags
  tags <- lapply(dsList, FUN=getTags);

  # Keep common tags
  tags <- getCommonListElements(tags);
  tags <- tags[[1]];
  tags <- unlist(tags, use.names=FALSE);

  # Add optional tuple tags
  tags <- c(tags, this$.tags);

  # Update asterisk tags
  tags[tags == "*"] <- getAsteriskTags(this, collapse=",");

  # Remove empty tags
  tags <- tags[nchar(tags) > 0];

  # Remove duplicated tags 
  tags <- locallyUnique(tags);

  # Collapsed or split?
  if (!is.null(collapse)) {
    tags <- paste(tags, collapse=collapse);
  } else {
    if (length(tags) > 0)
      tags <- unlist(strsplit(tags, split=","));
  }

  if (length(tags) == 0)
    tags <- NULL;

  tags;
})


###########################################################################/**
# @RdocMethod nbrOfChipTypes
#
# @title "Gets the number of chip types"
#
# \description{
#  @get "title" used in the model.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns an @integer.
# }
#
# @author
#
# \seealso{
#   @seemethod "getChipTypes".
#   @seeclass
# }
#*/###########################################################################
setMethodS3("nbrOfChipTypes", "AromaMicroarrayDataSetList", function(this, ...) {
  length(getChipTypes(this, ...));
})





###########################################################################/**
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
setMethodS3("getTableOfArrays", "AromaMicroarrayDataSetList", function(this, ...) {
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
}, protected=TRUE)


setMethodS3("getNames", "AromaMicroarrayDataSetList", function(this, ...) {
  rownames(getTableOfArrays(this, ...));
})


setMethodS3("getFullNames", "AromaMicroarrayDataSetList", function(this, arrays=NULL, exclude=NULL, translate=TRUE, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  getFullNameOfList <- function(cfList, ...) {
    # Get sample name
    first <- whichVector(!sapply(cfList, FUN=is.null))[1];
    name <- getName(cfList[[first]], ...);
  
    # Get chip-effect tags *common* across chip types
    tags <- lapply(cfList, FUN=function(ce) {
      if (is.null(ce)) NULL else getTags(ce, ...);
    });
    tags <- base::lapply(tags, setdiff, exclude);
    tags <- getCommonListElements(tags);
    tags <- tags[[1]];
    tags <- unlist(tags, use.names=FALSE);
    tags <- locallyUnique(tags);
    
    fullname <- paste(c(name, tags), collapse=",");
    
    fullname;
  } # getFullNameOfList()


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'arrays':
  n <- nbrOfFiles(this);
  if (is.null(arrays)) {
    arrays <- seq(length=n);
} else {
    arrays <- Arguments$getIndices(arrays, range=c(min(0L,n), n));
  }

  # Argument 'exclude':
  exclude <- Arguments$getCharacters(exclude);

  
  fullnames <- c();
  for (kk in arrays) {
    cfList <- getArrayList(this, array=kk, ...);
    fullname <- getFullNameOfList(cfList, translate=translate);
    fullnames <- c(fullnames, fullname);
  }

  fullnames;
})



###########################################################################/**
# @RdocMethod getArrays
#
# @title "Gets the names of the arrays"
#
# \description{
#  @get "title" available in the model.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character @vector.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getArrays", "AromaMicroarrayDataSetList", function(this, ...) {
  arrays <- getNames(this, ...);
  names(arrays) <- getFullNames(this, ...);
  arrays;
})



###########################################################################/**
# @RdocMethod indexOfArrays
#
# @title "Gets the indices of the arrays"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{arrays}{A @character @vector of arrays names.
#     If @NULL, all arrays are considered.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns an @integer @vector.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("indexOfArrays", "AromaMicroarrayDataSetList", function(this, arrays=NULL, ...) {
  if (is.numeric(arrays)) {
    n <- nbrOfFiles(this);
    arrays <- Arguments$getIndices(arrays, range=c(min(0L,n),n));
  } else {
    arrays <- indexOf(this, arrays, onMissing="error");
  }

  arrays;
}, private=TRUE)




###########################################################################/**
# @RdocMethod getArrayList
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
setMethodS3("getArrayList", "AromaMicroarrayDataSetList", function(this, array, ...) {
  # Get table of arrays
  arrayTable <- getTableOfArrays(this, ...);

  # Argument 'array':
  if (is.numeric(array)) {
    array <- Arguments$getIndex(array, range=c(1, nrow(arrayTable)));
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
})


setMethodS3("asMatrixOfFiles", "AromaMicroarrayDataSetList", function(this, ..., verbose=FALSE) {
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
}, protected=TRUE)




setMethodS3("getChipTypes", "AromaMicroarrayDataSetList", function(this, fullname=FALSE, merge=FALSE, collapse="+", ...) {
  dsList <- getSets(this);
  chipTypes <- sapply(dsList, FUN=getChipType, fullname=fullname);

  # Invariant for order
#  chipTypes <- sort(chipTypes);

  # Merge to a single string?
  if (merge) {
    chipTypes <- mergeByCommonTails(chipTypes, collapse=collapse);
  }

  chipTypes;
})



setMethodS3("byPath", "AromaMicroarrayDataSetList", abstract=TRUE, static=TRUE);




##############################################################################
# HISTORY:
# 2009-12-30
# o indexOfArrays() makes more use of indexOf().
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
