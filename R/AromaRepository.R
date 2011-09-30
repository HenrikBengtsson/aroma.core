setConstructorS3("AromaRepository", function(urlPath="http://www.aroma-project.org/data", verbose=FALSE, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'urlPath':
  urlPath <- Arguments$getCharacter(urlPath);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose, ...);

  extend(Object(), "AromaRepository",
    .urlPath = urlPath,
    .verbose = verbose
  );
})

setMethodS3("getUrlPath", "AromaRepository", function(static, ...) {
  static$.urlPath;
}, static=TRUE, protected=TRUE)


setMethodS3("setVerbose", "AromaRepository", function(this, ...) {
  verbose <- Arguments$getVerbose(verbose, ...);
  this$.verbose <- verbose;
  invisible(this)
}, protected=TRUE)


setMethodS3("getVerbose", "AromaRepository", function(this, ...) {
  this$.verbose;
}, protected=TRUE)


setMethodS3("downloadFile", "AromaRepository", function(static, filename, path=NULL, gzipped=TRUE, skip=TRUE, overwrite=FALSE, ..., verbose=getVerbose(static)) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Arguments 'filename' & 'path':
  pathname <- Arguments$getWritablePathname(filename, path=path, 
                                        mustNotExist=!skip & !overwrite);

  # Argument 'gzipped':
  gzipped <- Arguments$getLogical(gzipped);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Downloading file");

  verbose && cat(verbose, "Local pathname: ", pathname);
  if (skip && isFile(pathname)) {
    verbose && cat(verbose, "Already downloaded: ", pathname);
    verbose && exit(verbose);
    return(pathname);
  }

  # If decompressed, check if already downloaded
  if (gzipped) {
    pathnameD <- sprintf("%s.gz", pathname);
    pathnameD <- Arguments$getWritablePathname(pathnameD,
                                        mustNotExist=!skip & !overwrite);
  } else {
    pathnameD <- pathname;
  }

  # Get the URL to download  
  urlPath <- getUrlPath(static);
  url <- file.path(urlPath, pathnameD);
  verbose && cat(verbose, "URL to download: ", url);

  tryCatch({
    pathnameD <- downloadFile(url, filename=pathnameD, skip=skip, overwrite=overwrite, ..., verbose=less(verbose,5));
  }, error = function(ex) {
    # If gzipped file did not exists, try the regular one
    verbose && cat(verbose, "Failed to download compressed file.");
    if (gzipped) {
      verbose && enter(verbose, "Trying to download non-compressed file");
      url <- file.path(urlPath, pathname);
      verbose && cat(verbose, "URL to download: ", url);
      pathname <- downloadFile(url, filename=pathname, skip=skip, overwrite=overwrite, ..., verbose=less(verbose,5));
      gzipped <<- FALSE;
      verbose && exit(verbose);
    } else {
      throw(ex);
    }
  })

  if (gzipped) {
    verbose && enter(verbose, "Decompressing file");
    gunzip(pathnameD, overwrite=overwrite, remove=TRUE);
    verbose && exit(verbose);
  }

  # Sanity check
  stopifnot(isFile(pathname));

  verbose && exit(verbose);

  pathname;
}, static=TRUE, protected=TRUE) # downloadFile()



setMethodS3("downloadChipTypeFile", "AromaRepository", function(static, chipType, tags=NULL, suffix, ..., verbose=getVerbose(static)) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'chipType':
  chipType <- Arguments$getCharacter(chipType);

  # Argument 'tags':
  tags <- Arguments$getTags(tags);

  # Argument 'suffix':
  suffix <- Arguments$getCharacter(suffix);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Downloading chiptype file");

  path <- file.path("annotationData", "chipTypes", chipType);
  verbose && cat(verbose, "Path: ", path);

  fullname <- paste(c(chipType, tags), collapse=",");
  filename <- sprintf("%s%s", fullname, suffix);
  verbose && cat(verbose, "Filename: ", filename);

  res <- downloadFile(static, filename, path=path, ..., verbose=less(verbose,1));

  verbose && exit(verbose);

  res;
}, static=TRUE, protected=TRUE) # downloadChipTypeFile()


setMethodS3("downloadACS", "AromaRepository", function(static, ...) {
  downloadChipTypeFile(static, ..., suffix=".acs");
}, static=TRUE)

setMethodS3("downloadUFL", "AromaRepository", function(static, ...) {
  downloadChipTypeFile(static, ..., suffix=".ufl");
}, static=TRUE)

setMethodS3("downloadUGP", "AromaRepository", function(static, ...) {
  downloadChipTypeFile(static, ..., suffix=".ugp");
}, static=TRUE)

setMethodS3("downloadCDF", "AromaRepository", function(static, ...) {
  downloadChipTypeFile(static, ..., suffix=".cdf");
}, static=TRUE)

setMethodS3("downloadTXT", "AromaRepository", function(static, ...) {
  downloadChipTypeFile(static, ..., suffix=".txt");
}, static=TRUE)

setMethodS3("downloadProbeSeqsTXT", "AromaRepository", function(static, ...) {
  downloadChipTypeFile(static, ..., suffix=",probeSeqs.txt");
}, static=TRUE)


######################################################################
# HISTORY:
# 2011-09-29
# o The purpose of this class is to simplify downloading of
#   data files needed in the Aroma Framework.
# o Created.
######################################################################
