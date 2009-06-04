###########################################################################/**
# @RdocClass AromaMicroarrayDataSetTuple
#
# @title "The AromaMicroarrayDataSetTuple class"
#
# \description{
#  @classhierarchy
# }
# 
# @synopsis
#
# \arguments{
#   \item{csList}{A single or @list of @see "AromaMicroarrayDataSet":s.}
#   \item{tags}{A @character @vector of tags.}
#   \item{...}{Not used.}
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
setConstructorS3("AromaMicroarrayDataSetTuple", function(csList=NULL, tags="*", ..., .setClass="AromaMicroarrayDataSet") {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'csList':
  if (!is.null(csList)) {
    if (!is.list(csList)) {
      csList <- list(csList);
    }

    for (cs in csList) {
      if (!inherits(cs, .setClass)) {
        throw("Argument 'csList' contains a non-", .setClass, ": ", 
                                                            class(cs)[1]);
      }
    }
  }

  # Argument 'tags':
  if (!is.null(tags)) {
    tags <- Arguments$getCharacters(tags);
    tags <- trim(unlist(strsplit(tags, split=",")));
    tags <- tags[nchar(tags) > 0];
  }

  extend(Object(), "AromaMicroarrayDataSetTuple",
    .csList = csList,
    .tags = tags
  )
})



setMethodS3("as.character", "AromaMicroarrayDataSetTuple", function(x, ...) {
  # To please R CMD check
  this <- x;

  s <- sprintf("%s:", class(this)[1]);
  s <- c(s, paste("Name:", getName(this)));
  s <- c(s, paste("Tags:", paste(getTags(this), collapse=",")));
  s <- c(s, paste("Chip types:", paste(getChipTypes(this), collapse=", ")));
  csList <- getListOfSets(this);
  for (kk in seq(along=csList)) {
    cs <- csList[[kk]];
    s <- c(s, as.character(cs));
  }
  s <- c(s, sprintf("RAM: %.2fMB", objectSize(this)/1024^2));
  class(s) <- "GenericSummary";
  s;
}, private=TRUE)



###########################################################################/**
# @RdocMethod extract
#
# @title "Extracts a subset AromaMicroarrayDataSetTuple"
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
#  Returns a @see "AromaMicroarrayDataSetTuple".
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
setMethodS3("extract", "AromaMicroarrayDataSetTuple", function(this, arrays, ..., verbose=FALSE) {
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
  cc <- whichVector(apply(arrayTable, MARGIN=2, FUN=function(idxs) {
    any(!is.na(idxs));
  }));
  verbose && print(verbose, cc);
  arrayTable <- arrayTable[,cc,drop=FALSE];

  verbose && print(verbose, arrayTable);
  
  # Extract only those arrays
  res <- clone(this);
  csList <- getListOfSets(this)[cc];
  verbose && str(verbose, csList);

  for (kk in seq(along=csList)) {
    cs <- csList[[kk]];
    idxs <- arrayTable[,kk];
    idxs <- na.omit(idxs);
    cs <- extract(cs, idxs);
    csList[[kk]] <- cs;
  }
  res$.csList <- csList;

  verbose && str(verbose, csList);

  verbose && exit(verbose);

  res;
})




setMethodS3("getName", "AromaMicroarrayDataSetTuple", function(this, collapse="+", ...) {
  name <- getAlias(this);

  if (is.null(name)) {
    # Get name of chip-effect sets
    csList <- getListOfSets(this);
  
    # Get names
    names <- lapply(csList, FUN=getName);
    names <- unlist(names, use.names=FALSE);
  
    # Merge names
    names <- mergeByCommonTails(names, collapse=collapse);

    name <- names;
  }

  name;
})


setMethodS3("getAlias", "AromaMicroarrayDataSetTuple", function(this, ...) {
  this$.alias;
})


setMethodS3("setAlias", "AromaMicroarrayDataSetTuple", function(this, alias=NULL, ...) {
  # Argument 'alias':
  alias <- Arguments$getCharacter(alias, length=c(1,1));
  this$.alias <- alias;
  invisible(this);
})


setMethodS3("getAsteriskTags", "AromaMicroarrayDataSetTuple", function(this, ...) {
  "";
}, protected=TRUE)


setMethodS3("setTags", "AromaMicroarrayDataSetTuple", function(this, tags=NULL, ...) {
  # Argument 'tags':
  if (!is.null(tags)) {
    tags <- Arguments$getCharacters(tags);
    tags <- trim(unlist(strsplit(tags, split=",")));
    tags <- tags[nchar(tags) > 0];
  }

  this$.tags <- tags;

  invisible(this);
})


setMethodS3("getTags", "AromaMicroarrayDataSetTuple", function(this, collapse=NULL, ...) {
  # Get tags of chip-effect set
  csList <- getListOfSets(this);

  # Get data set tags
  tags <- lapply(csList, FUN=getTags);

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


setMethodS3("getFullName", "AromaMicroarrayDataSetTuple", function(this, ...) {
  name <- getName(this, ...);
  tags <- getTags(this, ...);
  fullname <- paste(c(name, tags), collapse=",");
  fullname <- gsub("[,]$", "", fullname);
  fullname;
})



setMethodS3("getListOfSets", "AromaMicroarrayDataSetTuple", function(this, ...) {
  sets <- this$.csList;
  if (is.null(names(sets))) {
    names(sets) <- sapply(sets, FUN=function(set) {
      getChipType(set, fullname=FALSE);
    });
    this$.csList <- sets;
  }
  sets;
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
#   @seeclass
# }
#*/###########################################################################
setMethodS3("nbrOfChipTypes", "AromaMicroarrayDataSetTuple", function(this, ...) {
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
#  Returns a \eqn{NxK} @matrix of @integers where \eqn{N} is the total number 
#  of arrays and \eqn{K} is the number of chip types in the model.  The row 
#  names are the names of the arrays, and the column names are the chip types.
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
  csList <- getListOfSets(this);

  # Get all chip types for this data set
  chipTypes <- getChipTypes(this);
  nbrOfChipTypes <- length(csList);

  # Get all sample names
  names <- lapply(csList, FUN=getNames, ...);
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


setMethodS3("getNames", "AromaMicroarrayDataSetTuple", function(this, ...) {
  rownames(getTableOfArrays(this, ...));
})


setMethodS3("getFullNames", "AromaMicroarrayDataSetTuple", function(this, arrays=NULL, exclude=NULL, aliased=FALSE, translate=TRUE, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  getFullNameOfTuple <- function(cfList, ...) {
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
  } # getFullNameOfTuple()


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'arrays':
  if (is.null(arrays)) {
    arrays <- seq_len(nbrOfArrays(this));
} else {
    arrays <- Arguments$getIndices(arrays, range=c(1, nbrOfArrays(this)));
  }

  # Argument 'exclude':
  exclude <- Arguments$getCharacters(exclude);

  
  fullnames <- c();
  for (kk in arrays) {
    cfList <- getArrayTuple(this, array=kk, ...);
    fullname <- getFullNameOfTuple(cfList, aliased=aliased, 
                                                        translate=translate);
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
setMethodS3("getArrays", "AromaMicroarrayDataSetTuple", function(this, ...) {
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
setMethodS3("indexOfArrays", "AromaMicroarrayDataSetTuple", function(this, arrays=NULL, ...) {
  allNames <- getNames(this, ...);

  # Argument 'arrays':
  if (is.null(arrays)) {
    arrays <- seq(along=allNames);
  } else if (is.numeric(arrays)) {
    arrays <- Arguments$getIndices(arrays, range=c(1,length(allNames)));
  } else {
    missing <- whichVector(!(arrays %in% allNames));
    if (length(missing) > 0) {
      missing <- paste(arrays[missing], collapse=", ");
      throw("Argument 'arrays' contains unknown arrays: ", missing);
    }
    arrays <- match(arrays, allNames);
  }

  arrays;
}, private=TRUE)



###########################################################################/**
# @RdocMethod nbrOfArrays
#
# @title "Gets the number of arrays"
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
#   @seeclass
# }
#*/###########################################################################
setMethodS3("nbrOfArrays", "AromaMicroarrayDataSetTuple", function(this, ...) {
  length(getNames(this, ...));
})


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
  csList <- getListOfSets(this);
  for (kk in seq(along=csList)) {
    idx <- idxs[kk];
    if (is.na(idx))
      next;
    cs <- csList[[kk]];
    tuple[[kk]] <- getFile(cs, idx);
  }
  names(tuple) <- chipTypes;

  tuple;
})


setMethodS3("asMatrixOfFiles", "AromaMicroarrayDataSetTuple", function(this, ..., verbose=FALSE) {
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

  csList <- getListOfSets(this);

  # Identify the array indices for each chip type
  arrayTable <- getTableOfArrays(this, ...);
  verbose && print(verbose, arrayTable);

  arrayOfFiles <- rep(NA, length(arrayTable));
  arrayOfFiles <- as.list(arrayOfFiles);
  dim(arrayOfFiles) <- dim(arrayTable);
  dimnames(arrayOfFiles) <- dimnames(arrayTable);

  for (cc in seq(length=ncol(arrayOfFiles))) {
    files <- as.list(csList[[cc]]);
    files <- files[arrayTable[,cc]];
    arrayOfFiles[,cc] <- files;
  }
  rm(files, arrayTable, csList);

  verbose && exit(verbose);

  arrayOfFiles;
}, protected=TRUE)




setMethodS3("getChipTypes", "AromaMicroarrayDataSetTuple", function(this, fullname=FALSE, merge=FALSE, collapse="+", ...) {
  csList <- getListOfSets(this);
  chipTypes <- sapply(csList, FUN=getChipType, fullname=fullname);

  # Invariant for order
#  chipTypes <- sort(chipTypes);

  # Merge to a single string?
  if (merge)
    chipTypes <- mergeByCommonTails(chipTypes, collapse=collapse);

  chipTypes;
})



setMethodS3("byPath", "AromaMicroarrayDataSetTuple", abstract=TRUE, static=TRUE);




##############################################################################
# HISTORY:
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
