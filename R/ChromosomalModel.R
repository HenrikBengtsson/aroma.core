###########################################################################/**
# @RdocClass ChromosomalModel
#
# @title "The ChromosomalModel class"
#
# \description{
#  @classhierarchy
#
#  This \emph{abstract} class represents a chromosomal model.
# }
# 
# @synopsis
#
# \arguments{
#   \item{cesTuple}{A @see "AromaMicroarrayDataSetTuple".}
#   \item{tags}{A @character @vector of tags.}
#   \item{genome}{A @character string specifying what genome is process.}
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# \section{Requirements}{
#   This class requires genome information annotation files for 
#   every chip type.
# }
#
# @author
#*/###########################################################################
setConstructorS3("ChromosomalModel", function(cesTuple=NULL, tags="*", genome="Human", ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'cesTuple':
  if (!is.null(cesTuple)) {
    # Coerce, if needed
    if (!inherits(cesTuple, "AromaMicroarrayDataSetTuple")) {
      cesTuple <- as.AromaMicroarrayDataSetTuple(cesTuple);
    }
  }

  # Argument 'tags':
  tags <- Arguments$getTags(tags, collapse=NULL);

  this <- extend(Object(), "ChromosomalModel",
    .alias = NULL,
    .cesTuple = cesTuple,
    .chromosomes = NULL,
    .tags = tags,
    .genome = genome
  );

  # Validate?
  if (!is.null(this$.cesTuple)) {
    # Validate genome
    pathname <- getGenomeFile(this);
  }

  this;
}, abstract=TRUE)


setMethodS3("as.character", "ChromosomalModel", function(x, ...) {
  # To please R CMD check
  this <- x;

  s <- sprintf("%s:", class(this)[1]);
  s <- c(s, paste("Name:", getName(this)));
  s <- c(s, paste("Tags:", getTags(this, collapse=",")));
  s <- c(s, paste("Chip type (virtual):", getChipType(this)));
  s <- c(s, sprintf("Path: %s", getPath(this)));
  tuple <- getSetTuple(this);
  chipTypes <- getChipTypes(tuple);
  nbrOfChipTypes <- length(chipTypes);
  s <- c(s, sprintf("Number of chip types: %d", nbrOfChipTypes));
  s <- c(s, sprintf("Chip types: %d", paste(chipTypes, collapse=", ")));

  s <- c(s, "List of data sets:");
  s <- c(s, as.character(tuple));

  s <- c(s, sprintf("RAM: %.2fMB", objectSize(this)/1024^2));
  class(s) <- "GenericSummary";
  s;
}, protected=TRUE)


setMethodS3("clearCache", "ChromosomalModel", function(this, ...) {
  # Clear all cached values.
  # /AD HOC. clearCache() in Object should be enough! /HB 2007-01-16
  for (ff in c()) {
    this[[ff]] <- NULL;
  }

  if (!is.null(this$.cesTuple)) {
    clearCache(this$.cesTuple);
  }

  # Then for this object
  NextMethod(generic="clearCache", object=this, ...);
})


setMethodS3("getRootPath", "ChromosomalModel", function(this, ...) {
  tag <- getAsteriskTags(this)[1];
  sprintf("%sData", tolower(tag));
})


setMethodS3("getParentPath", "ChromosomalModel", function(this, ...) {
  # Root path
  rootPath <- getRootPath(this);

  # Full name
  fullname <- getFullName(this);

  # The full path
  path <- filePath(rootPath, fullname, expandLinks="any");

  # Create path?
  if (!isDirectory(path)) {
    mkdirs(path);
    if (!isDirectory(path)) {
      throw("Failed to create directory: ", path);
    }
  }

  path;
})

setMethodS3("getPath", "ChromosomalModel", function(this, ...) {
  path <- getParentPath(this, ...);

  # Chip type
  chipType <- getChipType(this);

  # The full path
  path <- filePath(path, chipType, expandLinks="any");

  # Create path?
  if (!isDirectory(path)) {
    mkdirs(path);
    if (!isDirectory(path)) {
      throw("Failed to create output directory: ", path);
    }
  }

  path;
})

setMethodS3("getReportPath", "ChromosomalModel", function(this, ...) {
  rootPath <- "reports";

  # Data set name
  name <- getName(this);

  # Data set tags
  tags <- getTags(this, collapse=",");

  # Get chip type
  chipType <- getChipType(this);

  # Image set
  set <- getSetTag(this);

  # The report path
  path <- filePath(rootPath, name, tags, chipType, set, expandLinks="any");

  path;
}, protected=TRUE)



setMethodS3("getSetTuple", "ChromosomalModel", function(this, ...) {
  this$.cesTuple;
}, protected=TRUE)



setMethodS3("getSets", "ChromosomalModel", function(this, ...) {
  tuple <- getSetTuple(this);
  getSets(tuple);
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
setMethodS3("nbrOfChipTypes", "ChromosomalModel", function(this, ...) {
  tuple <- getSetTuple(this);
  nbrOfChipTypes(tuple, ...);
})



setMethodS3("getListOfUnitNamesFiles", "ChromosomalModel", function(this, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Retrieving unit names files");

  tuple <- getSetTuple(this);

  tryCatch({
    unfList <- getListOfUnitNamesFiles(tuple, ...);
  }, error = function(ex) {
    msg <- sprintf("Failed to located unit-names files for one of the chip types (%s). The error message was: %s", paste(getChipTypes(this), collapse=", "), ex$message);
    throw(msg);
  });

  verbose && exit(verbose);

  unfList;
}, private=TRUE)


setMethodS3("getListOfAromaUgpFiles", "ChromosomalModel", function(this, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Retrieving list of UGP files");

  tuple <- getSetTuple(this);
#  unfList <- getListOfUnitNamesFiles(this);

  ugpList <- NULL;
  tryCatch({
    verbose && enter(verbose, "Retrieving UGP files from unit names files");
#    ugpList <- lapply(unfList, getAromaUgpFile, verbose=less(verbose));
#   TODO: Why not do this?  /HB 2010-01-12
    ugpList <- lapply(tuple, getAromaUgpFile, verbose=less(verbose));
    verbose && exit(verbose);
  }, error = function(ex) {
    msg <- sprintf("Failed to located UGP files for one of the chip types (%s). Please note that DChip GenomeInformation files are no longer supported.  The error message was: %s", paste(getChipTypes(this), collapse=", "), ex$message);
    throw(msg);
  });

  verbose && exit(verbose);

  ugpList;
})


setMethodS3("getListOfUnitTypesFiles", "ChromosomalModel", function(this, ...) {
  tuple <- getSetTuple(this);
  getListOfUnitTypesFiles(tuple, ...);
}, private=TRUE)



setMethodS3("getChipTypes", "ChromosomalModel", function(this, ...) {
  tuple <- getSetTuple(this);
  getChipTypes(tuple, ...);
})


###########################################################################/**
# @RdocMethod getChipType
#
# @title "Gets a label for all chip types merged"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getChipType", "ChromosomalModel", function(this, ...) {
  getChipTypes(this, merge=TRUE, ...);
})



###########################################################################/**
# @RdocMethod getNames
#
# @title "Gets the names of the arrays"
#
# \description{
#  @get "title" available to the model.
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
setMethodS3("getNames", "ChromosomalModel", function(this, ...) {
  tuple <- getSetTuple(this);
  getNames(tuple, ...);
})


setMethodS3("getFullNames", "ChromosomalModel", function(this, ...) {
  tuple <- getSetTuple(this);
  getFullNames(tuple, ...);
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
setMethodS3("getTableOfArrays", "ChromosomalModel", function(this, ...) {
  tuple <- getSetTuple(this);
  getTableOfArrays(tuple, ...);
}, deprecated=TRUE)


setMethodS3("indexOf", "ChromosomalModel", function(this, patterns=NULL, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  getFullNames <- function(fullnames=NULL, ...) {
    if (!is.null(fullnames))
      return(fullnames);
    getFullNames(this);
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  names <- getNames(this);

  # Return all indices
  if (is.null(patterns)) {
    res <- seq(along=names);
    names(res) <- names;
    return(res);
  } else if (is.numeric(patterns)) {
    n <- length(names);
    res <- Arguments$getIndices(patterns, max=n);
    names(res) <- names[res];
    return(res);
  }

  fullnames <- NULL;

  naValue <- as.integer(NA);

  patterns0 <- patterns;
  res <- lapply(patterns, FUN=function(pattern) {
    pattern <- sprintf("^%s$", pattern);
    pattern <- gsub("\\^\\^", "^", pattern);
    pattern <- gsub("\\$\\$", "$", pattern);

    # Specifying tags?
    if (regexpr(",", pattern) != -1) {
      fullnames <- getFullNames(fullnames);
      idxs <- grep(pattern, fullnames);
    } else {
      idxs <- grep(pattern, names);
    }
    if (length(idxs) == 0)
      idxs <- naValue;

    # Note that 'idxs' may return more than one match
    idxs;
  });

  ns <- sapply(res, FUN=length);
  names <- NULL;
  for (kk in seq(along=ns)) {
    names <- c(names, rep(patterns0[kk], times=ns[kk]));
  }
  res <- unlist(res, use.names=FALSE);
  names(res) <- names;

  # Not allowing missing values?
  if (any(is.na(res))) {
    names <- names(res)[is.na(res)];
    throw("Some names where not match: ", paste(names, collapse=", "));
  }

  res;
})




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
setMethodS3("nbrOfArrays", "ChromosomalModel", function(this, ...) {
  length(getNames(this, ...));
})


setMethodS3("getName", "ChromosomalModel", function(this, collapse="+", ...) {
  name <- getAlias(this);

  if (is.null(name)) {
    tuple <- getSetTuple(this);
    name <- getName(tuple, ...);
  }

  name;
})


setMethodS3("getAsteriskTags", "ChromosomalModel", function(this, collapse=NULL, ...) {
  # Create a default asterisk tags for any class by extracting all
  # capital letters and pasting them together, e.g. AbcDefGhi => ADG.
  name <- class(this)[1];

  # Remove any 'Model' suffixes
  name <- gsub("Model$", "", name);

  name <- capitalize(name);

  # Vectorize
  name <- strsplit(name, split="")[[1]];

  # Identify upper case
  name <- name[(toupper(name) == name)];

  # Paste
  name <- paste(name, collapse="");

  tag <- name;
}, protected=TRUE)




setMethodS3("getTags", "ChromosomalModel", function(this, collapse=NULL, ...) {
  tuple <- getSetTuple(this);
  tags <- getTags(tuple, collapse=collapse, ...);

  # Add model tags
  tags <- c(tags, this$.tags);

  # In case this$.tags is not already split
  tags <- strsplit(tags, split=",", fixed=TRUE);
  tags <- unlist(tags);

  # Update default tags
  asteriskTags <- getAsteriskTags(this, collapse=",");
  if (length(asteriskTags) == 0)
    asteriskTags <- "";
  tags[tags == "*"] <- asteriskTags;

  tags <- Arguments$getTags(tags, collapse=NULL);

  # Get unique tags
  tags <- locallyUnique(tags);

  # Collapsed or split?
  tags <- Arguments$getTags(tags, collapse=collapse);

  tags;
})


setMethodS3("getFullName", "ChromosomalModel", function(this, ...) {
  name <- getName(this);
  tags <- getTags(this);
  fullname <- paste(c(name, tags), collapse=",");
  fullname <- gsub("[,]$", "", fullname);
  fullname;
})



###########################################################################/**
# @RdocMethod getChromosomes
#
# @title "Gets the chromosomes available"
#
# \description{
#  @get "title".
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
setMethodS3("getChromosomes", "ChromosomalModel", function(this, ...) {
  ugpList <- getListOfAromaUgpFiles(this);
  chromosomes <- lapply(ugpList, getChromosomes);
  chromosomes <- unlist(chromosomes, use.names=TRUE);
  chromosomes <- sort(unique(chromosomes));
  chromosomes;
})






setMethodS3("getGenome", "ChromosomalModel", function(this, ...) {
  this$.genome;
})


setMethodS3("getGenomeFile", "ChromosomalModel", function(this, ..., genome=getGenome(this), tags="chromosomes", pattern="^%s(,.*)*[.]txt$", onMissing=c("error", "warning", "ignore"), verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'genome':
  genome <- Arguments$getCharacter(genome);

  # Argument 'tags':
  tags <- Arguments$getTags(tags, collapse=",");

  # Argument 'pattern':
  if (!is.null(pattern)) {
    pattern <- Arguments$getRegularExpression(pattern);
  }

  # Argument 'onMissing':
  onMissing <- match.arg(onMissing);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Locating genome annotation file");

  fullname <- paste(c(genome, tags), collapse=",");

  verbose && cat(verbose, "Genome name: ", genome);
  verbose && cat(verbose, "Genome tags: ", tags);
  verbose && cat(verbose, "Genome fullname: ", fullname);

  pattern <- sprintf(pattern, fullname);
  verbose && cat(verbose, "Pattern: ", pattern);

  # Paths to search in
  paths <- c(
    system.file("annotationData", package="aroma.core"),
    system.file("annotationData", package="aroma.affymetrix")
  );
  keep <- (nchar(paths) > 0);
  paths <- paths[keep];
  keep <- sapply(paths, FUN=isDirectory);
  paths <- paths[keep];
  paths <- lapply(paths, FUN=function(path) Arguments$getReadablePath(path));
  paths <- c(list(NULL), paths);

  verbose && cat(verbose, "Paths to be searched:");
  verbose && str(verbose, paths);

  for (kk in seq(along=paths)) {
    path <- paths[[kk]];
    verbose && cat(verbose, "Path: ", path);
    pathname <- findAnnotationData(name=fullname, set="genomes", 
                pattern=pattern, ..., paths=path, verbose=less(verbose, 10));
    if (!is.null(pathname)) {
      verbose && cat(verbose, "Found file: ", pathname);
      break;
    }
  }

  # Failed to locate a file?
  if (is.null(pathname)) {
    msg <- sprintf("Failed to locate a genome annotation data file with pattern '%s' for genome '%s'.", pattern, genome);
    verbose && cat(verbose, msg);

    # Action?
    if (onMissing == "error") {
      throw(msg);
    } else if (onMissing == "warning") {
      warning(msg);
    } else if (onMissing == "ignore") {
    }
  }

  verbose && exit(verbose);

  pathname;
}, protected=TRUE)


setMethodS3("setGenome", "ChromosomalModel", function(this, genome, tags=NULL, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'genome':
  genome <- Arguments$getCharacter(genome, length=c(1,1));

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  oldGenome <- this$.genome;

  fullname <- paste(c(genome, tags), collapse=",");
  verbose && cat(verbose, "Fullname: ", fullname);

  # Verify that there is an existing genome file
  tryCatch({
    this$.genome <- fullname;
    pathname <- getGenomeFile(this, verbose=less(verbose, 10));
  }, error = function(ex) {
    this$.genome <- oldGenome;
    throw(ex$message);
  })

  invisible(oldGenome);
})



setMethodS3("getGenomeData", "ChromosomalModel", function(this, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Reading genome chromosome annotation file");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get genome annotation data
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Searching for the file");
  # Search annotationData/genomes/
  pathname <- getGenomeFile(this, verbose=less(verbose, 10));
  verbose && exit(verbose);

  verbose && enter(verbose, "Reading data file");
  verbose && cat(verbose, "Pathname: ", pathname);
  data <- readTable(pathname, header=TRUE, 
                            colClasses=c(nbrOfBases="integer"), row.names=1);
  verbose && exit(verbose);

  verbose && enter(verbose, "Translating chromosome names");
  chromosomes <- row.names(data);
  map <- c("X"=23, "Y"=24, "Z"=25);
  for (kk in seq(along=map)) {
    chromosomes <- gsub(names(map)[kk], map[kk], chromosomes, fixed=TRUE);
  }
  row.names(data) <- chromosomes;
  verbose && exit(verbose);

  verbose && exit(verbose);

  data;
}, protected=TRUE)


setMethodS3("fit", "ChromosomalModel", abstract=TRUE);


setMethodS3("getSetTag", "ChromosomalModel", function(this, ...) {
  tolower(getAsteriskTags(this)[1]);
}, private=TRUE)


setMethodS3("getOutputSet", "ChromosomalModel", function(this, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Retrieving output set");

  verbose && enter(verbose, "Scanning output path");
  # Locate all 
  path <- getPath(this);
  verbose && cat(verbose, "Path: ", path);
  fs <- GenericDataFileSet$byPath(path, ...);
  verbose && cat(verbose, "Number of matching files located: ", nbrOfFiles(fs));
  verbose && exit(verbose);

  verbose && enter(verbose, "Keep those with fullnames matching the input data set");
  fullnames <- getFullNames(fs);
  
  # Drop extranous files
  keepFullnames <- getFullNames(this);
  patterns <- sprintf("^%s", fullnames);
  keep <- rep(FALSE, times=length(fullnames));
  for (pattern in patterns) {
    keep <- keep | (regexpr(pattern, fullnames) != -1);
  }
  if (any(!keep)) {
    fs <- extract(fs, keep);
  }
  verbose && exit(verbose);

  verbose && print(verbose, fs);

  verbose && exit(verbose);

  fs;
}, private=TRUE)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# BEGIN: DEPRECATED
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
setMethodS3("getChipEffectFiles", "ChromosomalModel", function(this, ...) {
  tuple <- getSetTuple(this);
  getArrayTuple(tuple, ...);
}, deprecated=TRUE)



setMethodS3("getArrays", "ChromosomalModel", function(this, ...) {
  getNames(this, ...);
}, deprecated=TRUE)


setMethodS3("getListOfChipEffectSets", "ChromosomalModel", function(this, ...) {
  getSets(this, ...);
}, deprecated=TRUE)



setMethodS3("getAlias", "ChromosomalModel", function(this, ...) {
  this$.alias;
})


setMethodS3("setAlias", "ChromosomalModel", function(this, alias=NULL, ...) {
  # Argument 'alias':
  if (!is.null(alias)) {
    alias <- Arguments$getCharacter(alias, length=c(1,1));
  }
  this$.alias <- alias;
  invisible(this);
})
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# END: DEPRECATED
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 



##############################################################################
# HISTORY:
# 2010-02-19
# o Updated getGenomeFile() for ChromosomalModel such that it can be used
#   to locate other types of genome annotation files as well, files that
#   may be optional (without giving an error).
# 2010-02-18
# o Added getOutputSet() for ChromosomalModel.
# 2010-01-13
# o getListOfAromaUgpFiles() for ChromosomalModel no longer goes via 
#   getListOfUnitNamesFiles().  This opens up the possibility to work with
#   data files without unit names files, e.g. smoothed CN data.
# 2009-11-18
# o CLEAN UP: Removed all Affymetrix specific classes/methods.
# 2009-11-16
# o CLEAN UP: The ChromosomalModel no longer checks 'combineAlleles'.
# o Now getChromosomes() of ChromosomalModel locates UGP files.
#   DChip GenomeInformation files are no longer supported for this.
# 2009-07-08
# o Added getListOfUnitTypesFiles() for ChromosomalModel.
# 2009-01-26
# o Removed get[]ListOfCdfs() from ChromosomalModel.
# o Removed deprectated get[]ListOfChipEffects() from ChromosomalModel.
# o Added getListOfAromaUgpFiles() to ChromosomalModel.
# o Added getListOfUnitNamesFiles() to ChromosomalModel.
# 2007-09-25
# o Extracted ChromosomalModel from CopyNumberSegmentationModel.  For 
#   previous HISTORY, see that class.
##############################################################################
