setMethodS3("extractRawCopyNumbers", "RawSequenceReads", function(this, ref=NULL, region=NULL, by, ..., force=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'ref':
  className <- class(this)[1];
  if (!is.null(ref)) {
    if (!inherits(ref, className)) {
      throw("Argument 'ref' is not of class '", className, "': ", class(ref)[1]);
    }
  }

  # Argument 'region':
  if (!is.null(region)) {
    region <- Arguments$getIntegers(region, range=c(0,Inf), length=c(2,2));
  }

  # Argument 'by':
  by <- Arguments$getInteger(by, range=c(1, Inf));

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Compiling list of ", className);
  rsrList <- list(this, ref);
  rsrList <- rsrList[!sapply(rsrList, is.null)];
  verbose && print(verbose, rsrList);
  verbose && exit(verbose);

  if (is.null(region)) {
    region <- xRange(this);
  } else {
    verbose && enter(verbose, "Extracting region");
    rsrList <- lapply(rsrList, FUN=extractRegion, region=region);
    verbose && print(verbose, rsrList);
    verbose && exit(verbose);
  }
  
  verbose && enter(verbose, "Smoothing");
  verbose && printf(verbose, "Bin width: %.1fkb\n", by/1e3);
  byTag <- sprintf("by=%.0f", by);

  cntList <- lapply(rsrList, FUN=function(rsr) {
    verbose && enter(verbose, "Smoothing");
    rsr <- clone(rsr);
    fields <- setdiff(getLocusFields(rsr), "id");
    setLocusFields(rsr, fields);
    print(verbose, rsr);
    key <- list(method="binnedSums", class=class(rsr)[1], 
         dataChecksum=digest(as.data.frame(rsr)), by=by, region=region);
    print(verbose, digest(key));
    dirs <- c("aroma.core", className);
    if (!force) {
      res <- loadCache(key=key, dirs=dirs);
      if (!is.null(res))
        return(res);
    }

    t <- system.time({
      res <- binnedSums(rsr, by=by, from=region[1], to=region[2]);
    });
    printf(verbose, "Binning time: %gs = %gms/bin\n", 
                                       t[3], 1000*t[3]/nbrOfLoci(res));
    print(verbose, res);

    saveCache(res, key=key, dirs=dirs);
    verbose && exit(verbose);
    res;
  });

  print(verbose, cntList);
  verbose && exit(verbose);

  verbose && enter(verbose, "Calculating CN ratios");
  if (length(cntList) == 1) {
    cn <- cntList[[1]];
  } else {
    cn <- divideBy(cntList[[1]], cntList[[2]]);
  }
  cn$y <- 2 * cn$y;
  cn <- RawCopyNumbers(cn);
  print(verbose, cn);
  verbose && exit(verbose);

  cn;
}) # extractRawCopyNumbers()

############################################################################
# HISTORY:
# 2009-09-07
# o BUG FIX: extractRawCopyNumbers() for RawSequenceReads refered to 
#   to global variables in the code for file caching.
# 2009-07-06
# o Added extractRawCopyNumbers() for RawSequenceReads.
# o Created.
############################################################################