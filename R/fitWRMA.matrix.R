setMethodS3("fitWRMA", "matrix", function(y, w, psiCode=0, psiK=1.345, .log2=TRUE, ..., .loadDeps=FALSE) {
  # Constants
  PACKAGE <- "preprocessCore";
  if (.loadDeps) {
    require(PACKAGE, character.only=TRUE) || throw("Package not loaded: ", PACKAGE);
  }

  # Transform 'y' to log2 scale?
  if (.log2)
    y <- log2(y);

  I <- ncol(y);
  K <- nrow(y);

  fit <- .Call("R_wrlm_rma_default_model", y, psiCode, psiK, w, PACKAGE=PACKAGE);

  est <- fit$Estimates;
  se <- fit$StdErrors;

  # Chip effects
  theta <- est[1:I];

  # Probe affinities
  phi <- est[(I+1):length(est)];
  phi[length(phi)] <- -sum(phi[1:(length(phi)-1)]);

  # Weighted-average affinity
  avgPhi <- sum(w*phi, na.rm=TRUE) / sum(w, na.rm=TRUE);

  # Estimates on the intensity scale?
  if (.log2) {
    theta <- 2^theta;
    phi <- 2^phi;
    avgPhi <- 2^avgPhi;
  }

  list(theta=theta, phi=phi, avgPhi=avgPhi);
}, protected=TRUE) # fitWRMA()


############################################################################
# HISTORY:
# 2012-08-08
# o Added argument '.loadDeps' to fitWRMA().
# 2007-09-18
# o Created.
############################################################################
