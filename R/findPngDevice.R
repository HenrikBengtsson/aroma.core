setMethodS3("findPngDevice", "default", function(transparent=TRUE, ...) {
  devices <- list();

  isRv270plus <- (compareVersion(as.character(getRversion()), "2.7.0") >= 0);
  pngHasType <- ("type" %in% names(formals(png)));

  # To fool R CMD check code validation
  pngTyped <- function(...) png(...);
  
  if (transparent) {
    if (isRv270plus && pngHasType) {
      # png(..., type="cairo");
      pngCairoDefault <- function(...) pngTyped(..., bg=NA, type="cairo");
      pngCairo1 <- function(...) pngTyped(..., bg=NA, type="cairo1");
      devices <- c(devices, pngCairoDefault, pngCairo1);
    }

    # Cairo::CairoPNG()
    if (require("Cairo")) {
      CairoPNGtrans <- function(...) {
        Cairo::CairoPNG(..., bg=NA);
      };
      devices <- c(devices, CairoPNGtrans);
    }

    # R.utils::png2()
    png2trans <- function(...) {
      png2(..., type="pngalpha");
      par(bg=NA);
      # The 'pngalpha' ghostscript device is quite slow, so to avoid
      # overloading the CPU, we add an ad hoc sleep here.
#      Sys.sleep(0.3);
    }
    devices <- c(devices, png2trans);

    # grDevices::png()
    pngtrans <- function(...) {
      png(..., bg=NA);
    }
    devices <- c(devices, pngtrans);
  } else {
    if (isRv270plus && pngHasType) {
      # png(..., type="cairo");
      pngCairoDefault <- function(...) pngTyped(..., type="cairo");
      pngCairo1 <- function(...) pngTyped(..., type="cairo1");
      devices <- c(devices, pngCairoDefault, pngCairo1);
    }

    # R.utils::png2()
    devices <- c(devices, png2);

    # Cairo::CairoPNG()
    if (require("Cairo")) {
      devices <- c(devices, Cairo::CairoPNG);
    }

    # grDevices::png()
    devices <- c(devices, grDevices::png);
  }

  
  System$findGraphicsDevice(devices=devices);
}, protected=TRUE)


##############################################################################
# HISTORY:
# 2008-05-21
# o Added png(..., type="cairo") and png(..., type="cairo1") for cases when
#   png() has argument 'type' and R is v2.7.0 or newer.
# 2007-11-25
# o We'll wait a bit making the Cairo PNG device the default *non-transparent*
#   device; the reason for this is that I still haven't figured out what the
#   all requirements are and if it is possible to use it in a "nohup" batch
#   mode without an X11 device.
# 2007-10-11
# o Created.
##############################################################################
