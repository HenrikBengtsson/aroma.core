setMethodS3("extractDataForSegmentation", "RawGenomicSignals", function(this, order=TRUE, useWeights=TRUE, dropNonFinite=TRUE, dropZeroWeights=TRUE, dropWeightsIfAllEqual=TRUE, defaultChromosome=0L, defaultSampleName="Unnamed sample", ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Extracting data used by segmentaion algorithms");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Retrieving data
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  sampleName <- this$fullname;
  if (is.null(sampleName)) {
    sampleName <- defaultSampleName;
  }

  chromosome <- as.integer(this$chromosome);
  if (is.na(chromosome)) {
    chromosome <- defaultChromosome;
  }
  nbrOfLoci <- nbrOfLoci(this);
  verbose && cat(verbose, "Sample name: ", sampleName);
  verbose && cat(verbose, "Chromosome: ", chromosome);
  verbose && cat(verbose, "Number of loci: ", nbrOfLoci);

  # Extracting data of interest
  data <- as.data.frame(this, translate=FALSE);
  data <- cbind(chromosome=chromosome, data);
#  verbose && str(verbose, data);

  # Use weights, if they exists?
  hasWeights <- useWeights && (length(data$w) > 0);
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Drop loci with unknown locations?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Dropping loci with unknown locations");
  keep <- whichVector(is.finite(data$x));
  nbrOfDropped <- nbrOfLoci-length(keep);
  verbose && cat(verbose, "Number of dropped loci: ", nbrOfDropped);
  if (nbrOfDropped > 0) {
    data <- data[keep,,drop=FALSE];
    nbrOfLoci <- nrow(data);
#    verbose && str(verbose, data);
  }
  rm(keep);
  verbose && exit(verbose);


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Drop non-finite signals?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (dropNonFinite) {
    verbose && enter(verbose, "Dropping loci with non-finite signals");
    keep <- whichVector(is.finite(data$y));
    nbrOfDropped <- nbrOfLoci-length(keep);
    verbose && cat(verbose, "Number of dropped loci: ", nbrOfDropped);
    if (nbrOfDropped > 0) {
      data <- data[keep,,drop=FALSE];
      nbrOfLoci <- nrow(data);
#      verbose && str(verbose, data);
    }
    rm(keep);
    verbose && exit(verbose);
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Order along genome?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (order) {
    verbose && enter(verbose, "Order data along genome");
    # Order signals by their genomic location
    o <- order(data$x);
    data <- data[o,,drop=FALSE];
#    verbose && str(verbose, data);
    verbose && exit(verbose);
    rm(o);
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Weights
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (hasWeights && dropZeroWeights) {
    # Dropping loci with non-positive weights
    verbose && enter(verbose, "Dropping loci with non-positive weights");
    keep <- whichVector(data$w > 0);
    nbrOfDropped <- nbrOfLoci-length(keep);
    verbose && cat(verbose, "Number of loci dropped: ", nbrOfDropped);
    if (nbrOfDropped > 0) {
      data <- data[keep,,drop=FALSE];
      nbrOfLoci <- nrow(data);
#      verbose && str(verbose, data);
    }
    rm(keep);
    verbose && exit(verbose);
  }


  if (hasWeights && dropWeightsIfAllEqual) {
    # Are all weights equal?
    verbose && enter(verbose, "Checking if all (remaining) weights are identical");
    t <- data$w - data$w[1];
    if (all(isZero(t))) {
      verbose && cat(verbose, "Dropping weights, because all weights are equal: ", data$w[1]);
      hasWeights <- FALSE;
      data$w <- NULL;
    }
    rm(t);
    verbose && exit(verbose);
  }

  attr(data, "sampleName") <- sampleName;
  verbose && str(verbose, data);
  
  verbose && exit(verbose);

  data;
}, protected=TRUE)

############################################################################
# HISTORY:
# 2009-05-10
# o This method supports all the segmentByNnn() methods.
# o Created.
############################################################################
