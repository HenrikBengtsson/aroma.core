.patchSmoothScatter <- function(...) {
  # Nothing to do?
  if (compareVersion(as.character(getRversion()), "2.9.0") >= 0)
    return();

  # smootherScatter() et al. were migrated from the Bioconductor 
  # 'geneplotter' package v1.21.4 to the grDevices part of the 
  # R v2.9.0 distro.  It is not available in geneplotter v1.21.5.
  pd <- packageDescription("geneplotter");
  if (!is.list(pd) || compareVersion(pd$Version, "1.21.5") >= 0) {
    smoothScatter <- function(...) {
      stop("smoothScatter() is not available in geneplotter v1.21.5 or newer.  It was move from geneplotter to the graphics package in R v2.9.0.  Update to R v2.9.0 or newer.");
    }
    envir <- as.environment("package:aroma.core");
    assign("smoothScatter", smoothScatter, envir=envir);
  } else {
    require("geneplotter") || stop("Package not loaded: geneplotter");
  }
} # .patchSmoothScatter()


############################################################################
# HISTORY:
# 2009-09-05
# o Wrong version number used in the geneplotter test.
# 2009-09-04
# o Created.
############################################################################
