setConstructorS3("SegmentationDataFile", function(...) {
  extend(GenericDataFile(...), c("SegmentationDataFile"
                                        , uses("FileCacheKeyInterface")));
}, abstract=TRUE)


setMethodS3("getChromosome", "SegmentationDataFile", function(this, ..., force=FALSE) {
  chromosome <- this$.chromosome;

  if (force || is.null(chromosome)) {
    # Infer the set of chromosomes from the tags
    tags <- getTags(this, collapse=NULL);
    chrTag <- grep("^chr", tags, value=TRUE);
    chrTag <- gsub("^chr", "", chrTag);
    chromosome <- as.integer(chrTag);
    # Sanity check
    stop_if_not(is.finite(chromosome));
    this$.chromosome <- chromosome;
  }

  chromosome;
})

setMethodS3("getSampleName", "SegmentationDataFile", function(this, ...) {
  getName(this, ...);
})


setMethodS3("getReferenceName", "SegmentationDataFile", function(this, ..., force=FALSE) {
  referenceName <- this$.referenceName;

  if (force || is.null(referenceName)) {
    # Infer the set of references from the tags
    tags <- getTags(this, collapse=NULL);
    idx <- grep("^chr", tags, value=FALSE);
    # Sanity check
    stop_if_not(length(idx) == 1);
    tags <- tags[seq(from=idx+1, to=length(tags))];
    referenceName <- paste(tags, collapse=",");
    # Sanity check
    stop_if_not(nchar(referenceName) > 0);
    this$.referenceName <- referenceName;
  }

  referenceName;
})

setMethodS3("loadFit", "SegmentationDataFile", abstract=TRUE)




setMethodS3("extractCopyNumberRegions", "SegmentationDataFile", function(this, ...) {
  fit <- loadFit(this, ...);
  res <- extractCopyNumberRegions(fit);
  res$sampleName <- getSampleName(this);
  res;
}, protected=TRUE);
