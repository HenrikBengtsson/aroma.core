setMethodS3("interleave", "Image", function(this, what=c("none", "h", "v", "auto"), ..., verbose=TRUE) {
  require("EBImage") || throw("Package not loaded: EBImage.");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  safeMeans <- function(x) {
    mean(x[is.finite(x)]);
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'what':
  what <- match.arg(what);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Interleave
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Nothing todo?
  if (what == "none")
    return(this);

  verbose && enter(verbose, "Interleaving image");

  # Get image data
  z <- this@.Data;
  verbose && cat(verbose, "z:");
  verbose && str(verbose, z);
  zDim <- dim(z);
  ndim <- length(zDim);
  dim(z) <- zDim;

  # Sanity check
  stopifnot(ndim == 2 || ndim == 3);
  if (ndim == 2) {
    dim(z) <- c(zDim, 1);
  }

  # if only PM locations have signal, add a fake row
  if (what == "auto") {
    verbose && enter(verbose, "Infering horizontal, vertical, or no interleaving");
    n <- 2*(nrow(z) %/% 2);
    idxOdd <- seq(from=1, to=n, by=2);
    zOdd <- z[idxOdd,,,drop=FALSE];
    zEven <- z[idxOdd+1,,,drop=FALSE];
    hOdd <- safeMeans(abs(zOdd));
    hEven <- safeMeans(abs(zEven));
    verbose && printf(verbose, "hOdd=%.2g\n", hOdd);
    verbose && printf(verbose, "hEven=%.2g\n", hEven);
    hRatio <- log(hOdd/hEven);
    verbose && printf(verbose, "hRatio=%.2g\n", hRatio);

    n <- 2*(ncol(z) %/% 2);
#    n <- max(n, 40);  # Infer from the first 40 rows.
    idxOdd <- seq(from=1, to=n, by=2);
    zOdd <- z[,idxOdd,,drop=FALSE];
    zEven <- z[,idxOdd+1,,drop=FALSE];
    vOdd <- safeMeans(abs(zOdd));
    vEven <- safeMeans(abs(zEven));
    verbose && printf(verbose, "vOdd=%.2g\n", vOdd);
    verbose && printf(verbose, "vEven=%.2g\n", vEven);
    vRatio <- log(vOdd/vEven);
    verbose && printf(verbose, "vRatio=%.2g\n", vRatio);

    what <- "none";
    if (abs(vRatio) > abs(hRatio)) {
      if (abs(vRatio) > 0.25) {
        if (vRatio > 0)
          what <- "v"
        else
          what <- "v";
      }
    } else {
      if (abs(hRatio) > 0.25) {
        if (hRatio > 0)
          what <- "h"
        else
          what <- "h";
      }
    }
    verbose && cat(verbose, "what: ", what);
    verbose && exit(verbose);
  }

  isUpdated <- FALSE;
  if (what == "h") {
    idxOdd <- seq(from=1, to=2*(nrow(z) %/% 2), by=2);
    z[idxOdd,,] <- z[idxOdd+1,,,drop=FALSE];
  } else if (what == "v") {
    idxOdd <- seq(from=1, to=2*(ncol(z) %/% 2), by=2);
    z[,idxOdd,] <- z[,idxOdd+1,,drop=FALSE];
  } else {
    isUpdated <- FALSE;
  }

  if (ndim == 2) {
    z <- z[,,1,drop=TRUE];
  }

  # Update?
  if (isUpdated) {
    this@.Data <- z;
  }

  verbose && exit(verbose);

  this;
})



############################################################################
# HISTORY:
# 2009-05-10
# o Forgot argument 'verbose'.
# o BUG FIX: interleave() for Image gave 'Error in z[idxOdd,, ] : incorrect 
#   number of dimensions'.  The internal image structure is now a 2-dim #   matrix, again(?!?).
# 2008-05-10
# o BUG FIX: interleave() for Image gave 'Error in z[idxOdd, ] : incorrect 
#   number of dimensions'.  The internal image structure is a 3-dim array.
# 2008-03-14
# o Created from getImage() of AffymetrixCelFile.
############################################################################

