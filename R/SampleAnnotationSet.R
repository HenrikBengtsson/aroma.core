setConstructorS3("SampleAnnotationSet", function(...) {
  extend(GenericDataFileSet(...), "SampleAnnotationSet")
})


setMethodS3("findSAFs", "SampleAnnotationSet", function(static, path, pattern="[.](saf|SAF)$", ...) {
  # Search all paths to the root path
  pathnames <- list();
  lastPath <- NA;
  depth <- 10;
  while(depth > 0 && !is.null(path) && !identical(path, lastPath)) {
    lastPath <- path;
    pathnames0 <- list.files(path=path, pattern=pattern, full.names=TRUE);
    pathnames0 <- sort(pathnames0);
    pathnames <- c(pathnames, list(pathnames0));
#    path <- getParent(path);
    path <- dirname(path);
    depth <- depth - 1;
  }

  # Return from top to bottom
  pathnames <- rev(pathnames);

  pathnames <- unlist(pathnames, use.names=FALSE);
  
  pathnames;
}, static=TRUE, private=TRUE)


setMethodS3("fromPath", "SampleAnnotationSet", function(static, path, pattern="[.](saf|SAF)$", ..., fileClass="SampleAnnotationFile", verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'path':
  path <- Arguments$getReadablePath(path, mustExist=TRUE);

  # Argument 'pattern':
  if (!is.null(pattern))
    pattern <- Arguments$getRegularExpression(pattern);

  # Argument 'fileClass':
  clazz <- Class$forName(fileClass);
  dfStatic <- getStaticInstance(clazz);
  dfStatic <- Arguments$getInstanceOf(dfStatic, "SampleAnnotationFile");

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  pathnames <- findSAFs(static, path=path, pattern=pattern, ...);

  verbose && enter(verbose, "Defining ", length(pathnames), " files");
  files <- list();
  for (kk in seq(along=pathnames)) {
    if (as.logical(verbose)) cat(kk, ", ", sep="");
    df <- newInstance(dfStatic, pathnames[kk]);
    files[[kk]] <- df;
    if (kk == 1) {
      # Update the static class instance.  The reason for this is
      # that if the second file cannot be instanciated with the same
      # class as the first one, then the files are incompatible.
      # Note that 'df' might be of a subclass of 'dfStatic'.
      clazz <- Class$forName(class(df)[1]);
      dfStatic <- getStaticInstance(clazz);
    }
  }
  if (as.logical(verbose)) cat("\n");
  verbose && exit(verbose);

  # Create the file set object
  set <- newInstance(static, files, ...);

  set;
}, static=TRUE)


############################################################################
# HISTORY:
# 2008-05-09
# o Now SampleAnnotationSet inherits from GenericDataFileSet and no longer
#   from AffymetrixFileSet.
# 2007-03-06
# o Created.
############################################################################
