setMethodS3("exportAromaUnitPscnBinarySet", "AromaUnitTotalCnBinarySet", function(dsT, dsB="*", dataSet="*", tags="*", ..., rootPath="totalAndFracBData/", overwrite=!skip, skip=TRUE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'dsT':
  dsT <- Arguments$getInstanceOf(dsT, "AromaUnitTotalCnBinarySet");
 
  # Argument 'dsB':
  if (!identical(dsB, "*")) {
    dsB <- Arguments$getInstanceOf(dsB, "AromaUnitFracBCnBinarySet");
    # Sanity check
    stopifnot(nbrOfFiles(dsB) == nbrOfFiles(dsT));
    # Reorder
    dsB <- extract(dsB, indexOf(dsB, names=getNames(dsT)));
    # Sanity check
    stopifnot(getNames(dsB) ==  getNames(dsT));
  }

  # Argument 'tags':
  tags <- Arguments$getTags(tags, collapse=NULL);

  # Argument 'rootPath':
  rootPath <- Arguments$getWritablePath(rootPath);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  clazz <- AromaUnitPscnBinaryFile;

  verbose && enter(verbose, "Exporting to AromaUnitPscnBinarySet");
  if (identical(dsB, "*")) {
    verbose && enter(verbose, "Locating AromaUnitFracBCnBinarySet");
    path <- getPath(dsT);
    verbose && cat(verbose, "Path: ", path);
    pattern <- ",fracB[.]asb$";
    dsB <- AromaUnitFracBCnBinarySet$byPath(path, pattern=pattern);
    verbose && cat(verbose, "Number of files: ", nbrOfFiles(dsB));
    dsB <- extract(dsB, indexOf(dsB, names=getNames(dsT)));
    verbose && cat(verbose, "Number of files kept: ", nbrOfFiles(dsB));
    # Sanity check
    stopifnot(nbrOfFiles(dsB) == nbrOfFiles(dsT));
    verbose && exit(verbose);
  }

  verbose && cat(verbose, "Root path: ", rootPath);
  if (any(dataSet == "*")) {
    default <- getName(dsT, collapse=",");
    dataSet[dataSet == "*"] <- default;
  }
  if (any(tags == "*")) {
    default <- getTags(dsT, collapse=",");
    tags[tags == "*"] <- default;
  }
  dataSetF <- fullname(dataSet, tags=tags);
  verbose && cat(verbose, "Output data set: ", dataSetF);

  chipType <- getChipType(dsT, fullname=FALSE);
  verbose && cat(verbose, "Output chip type: ", chipType);
  
  path <- filePath(rootPath, dataSetF, chipType);
  path <- Arguments$getWritablePath(path);
  verbose && cat(verbose, "Output path: ", path);

  nbrOfArrays <- nbrOfFiles(dsT);
  verbose && cat(verbose, "Number of arrays: ", nbrOfArrays);
  ugp <- getAromaUgpFile(dsT);
  verbose && cat(verbose, "Chip type: ", getChipType(ugp));
  nbrOfUnits <- nbrOfUnits(ugp);

  for (ii in seq(length=nbrOfArrays)) {
    dfT <- getFile(dsT, ii);
    dfB <- getFile(dsB, ii);
    name <- getName(dfT);
    verbose && enter(verbose, sprintf("Array #%d ('%s') of %d", ii, name, nbrOfArrays));
    # Sanity check
    stopifnot(getName(dfB) == name);
    stopifnot(nbrOfUnits(dfT) == nbrOfUnits);
    stopifnot(nbrOfUnits(dfB) == nbrOfUnits);

    # Convert to original scale
    ratioTag <- NULL;
    logBase <- NULL;
    if (hasTag(dfT, "log2ratio")) {
      logBase <- 2;
      ratioTag <- "ratio";
    } else if (hasTag(dfT, "log10ratio")) {
      logBase <- 10;
      ratioTag <- "ratio";
    } else if (hasTag(dfT, "logRatio")) {
      logBase <- 10;
      ratioTag <- "ratio";
    }

    tagsT <- intersect(getTags(dfT), getTags(dfB));
    tagsT <- c(tagsT, ratioTag);
    fullname <- fullname(name, tags=tagsT);
    filename <- sprintf("%s,pscn.asb", fullname);
    pathname <- Arguments$getWritablePathname(filename, path=path, 
                                           mustNotExist=(!overwrite && !skip));
    verbose && cat(verbose, "Pathname: ", pathname);
  
    if (isFile(pathname)) {
      if (skip) {
        df <- newInstance(clazz, pathname);
        # TODO: We might retrieve an incompatible file.  Validate!
        verbose && cat(verbose, "Already exported. Skipping.");
        verbose && exit(verbose);
        next;
      } else if (!overwrite) {
        throw("Cannot allocate/create file. File already exists: ", pathname);
      }
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Create empty temporary file
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Overwrite?
    if (overwrite && isFile(pathname)) {
      # TODO: Added a backup/restore feature in case new writing fails.
      file.remove(pathname);
      verbose && cat(verbose, "Removed pre-existing file (overwrite=TRUE).");
    }
  
    pathnameT <- pushTemporaryFile(pathname, verbose=verbose);

    # Read (total,fracB) data
    verbose && enter(verbose, "Reading (total,fracB) data");
    dataT <- extractMatrix(dfT, drop=TRUE);
    dataB <- extractMatrix(dfB, drop=TRUE);
    if (!is.null(logBase)) {
      dataT <- logBase^dataT;
    }
    verbose && exit(verbose);

    # Allocate
    df <- clazz$allocateFromUnitAnnotationDataFile(ugp, filename=pathnameT);

    # Populate
    df[,1L] <- dataT;
    df[,2L] <- dataB;

    # Not needed anymore
    rm(dataT, dataB);

    # Write footer
##    writeFooter(df, footer);

    # Rename temporary file
    pathname <- popTemporaryFile(pathnameT, verbose=verbose);

    # Object to be returned
    df <- newInstance(clazz, pathname);
    
    verbose && exit(verbose);
  } # for (ii ...)
  
  verbose && cat(verbose, "Exported data set:");
  pattern <- ",pscn[.]asb$";
  ds <- AromaUnitPscnBinarySet$byPath(path, pattern=pattern);
  ds <- extract(ds, indexOf(ds, names=getNames(dsT)));
  verbose && print(verbose, ds);

  # Sanity check
  stopifnot(nbrOfFiles(ds) == nbrOfFiles(dsT));
  stopifnot(all(getNames(ds) == getNames(dsT)));

  verbose && exit(verbose);

  ds;
})

############################################################################
# HISTORY:
# 2012-07-21
# o Added exportAromaUnitPscnBinarySet() for AromaUnitTotalCnBinarySet.
# o Created.
############################################################################
