setMethodS3("getAromaFullNameTranslatorSet", "character", function(dataSet, chipType=NULL, ..., paths=c("annotationData/dataSets/"), verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Arguments 'dataSet':
  dataSet <- Arguments$getCharacter(dataSet);

  # Arguments 'chipType':
  if (!is.null(dataSet)) {
    chipType <- Arguments$getCharacter(chipType);
  }

  # Arguments 'paths':
  paths <- Arguments$getCharacters(paths);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Locating fullname TabularTextFileSet:s");
  verbose && cat(verbose, "Data set: ", dataSet);
  verbose && cat(verbose, "Chip type: ", chipType);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Find all existing search paths
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Expand root paths
  rootPaths <- sapply(paths, FUN=function(path) {
    Arguments$getReadablePath(path, mustExist=FALSE);
  });
  # Keep only existing root paths
  rootPaths <- paths[sapply(rootPaths, FUN=isDirectory)];

  verbose && cat(verbose, "Existing root paths:");
  verbose && print(verbose, rootPaths);

  # For each root path
  paths <- NULL;
  for (rootPath in rootPaths) {
    # Append */<dataSet>/ directory
    path <- file.path(rootPath, dataSet);
    path <- Arguments$getReadablePath(path, mustExist=FALSE);
    # Nothing to do?
    if (!isDirectory(path)) {
      next;
    }
    paths <- c(paths, path);

    # Nothing to do?
    if (is.null(chipType)) {
      next;
    }

    # Append (optional) **/<dataSet>/<chipType>/ directory
    path <- file.path(path, chipType);
    path <- Arguments$getReadablePath(path, mustExist=FALSE);
    # Nothing to do?
    if (!isDirectory(path)) {
      next;
    }
    paths <- c(paths, path);
  } # for (rootPath ...)

  verbose && cat(verbose, "Search path:");
  verbose && print(verbose, paths);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Scan for existing fullname translator files
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Allocate empty result
  res <- TabularTextFileSet();

  for (path in paths) {
    ds <- TabularTextFileSet$byPath(path, pattern=",fullnames[.]txt$");
    append(res, ds);
  } # for (path ...)

  verbose && print(verbose, res);

  verbose && exit(verbose);

  res;
}, protected=TRUE) # getAromaFullNameTranslatorSet()


#############################################################################
# HISTORY:
# 2010-05-26
# o Added auxillary getAromaFullNameTranslatorSet().  We should ideally 
#   define a class and corresponding findByName() and byName() for this.
# o Created.
#############################################################################
