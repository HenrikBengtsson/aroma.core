weightedMad <- function(x, w, na.rm=FALSE, constant=1.4826, center=NULL, ...) {
  if (na.rm) {
    keep <- which(!is.na(x) & !is.na(w));
    x <- x[keep];
    w <- w[keep];
  }
  n <- length(x);

  # Standardize weights
  w <- w / sum(w);

  # Estimate the mean?
  if (is.null(center)) {
    center <- weightedMedian(x, w=w);
  }

  # Estimate the standard deviation
  x <- abs(x - center);
  sigma <- weightedMedian(x, w=w);

  # Rescale for normal distributions
  sigma <- constant * sigma;

  sigma;
} # weightedMad()


weightedMean <- weighted.mean;


############################################################################
# HISTORY:
# 2009-05-13
# o Added weightedMad().
# o Created.
############################################################################
