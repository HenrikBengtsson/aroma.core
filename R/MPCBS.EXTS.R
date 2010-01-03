setMethodS3("drawCnRegions", "MPCBS", function(object, ...) {
  cnr <- extractCopyNumberRegions(object, ...);
  drawLevels(cnr, ...);
})


setMethodS3("extractCopyNumberRegions", "MPCBS", function(object, ...) {
  # According to example on help("mpcbs-package", package="mpcbs")
  # in mpcbs v1.0.0.

  fit <- object$fit;
  chromosome <- object$chromosome;
  K <- length(fit$yhat);  # Number of sources

  # Compute platform specific variance terms.
  sigma2 <- double(K);
  for(kk in seq(length=K)) {
    y <- fit$y[[kk]];
    y <- y[is.finite(y)];
    sigma2[kk] <- compute.var(y);
  }

  # When data from multiple chromosomes are available,
  # put them in the list "fits".  Now, the list has length 1.
  fits <- vector("list", length=1);
  fits[[1]] <- fit;
  platform.names <- seq(length=K);
  stdout <- capture.output({
    res <- cross.platform.consensus(fits, sigma2, platform.names, plots=FALSE);
  });

  # Target loci  
  x <- fit$anchor$merged.pos;

  # consensus.cn[t] is consensus copy number estimate at x[t]
  y <- res$consensus.cn[[1]];

  # Number of loci
  nbrOfLoci <- length(x);

  # Sanity check
  stopifnot(length(y) == nbrOfLoci);

  # Identify the locus indices where the regions starts and ends
  dy <- diff(y);
  starts <- c(1L, which(dy != 0)+1L);
  ends <- c(starts[-1]-1L, nbrOfLoci);

  # Sanity check
  stopifnot(length(starts) == length(ends));

  counts <- ends - starts + 1L;

  # Get the mean levels of each region
  means <- y[starts];

  # Sanity check
  stopifnot(length(means) == length(starts));

  # Translate to genomic positions
  starts <- x[starts];
  ends <- x[ends];

  CopyNumberRegions(
    chromosome=chromosome,
    start=starts, 
    stop=ends, 
    mean=means,
    count=counts
  );
})


##############################################################################
# HISTORY:
# 2010-01-02
# o Created.
############################################################################## 
