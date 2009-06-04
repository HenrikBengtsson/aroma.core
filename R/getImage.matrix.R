setMethodS3("getImage", "matrix", function(z, ..., palette=NULL) {
  img <- as.GrayscaleImage(z, ...);

  if (!is.null(palette)) {
    img <- colorize(img, palette=palette, ...);
  }

  img;
}, protected=TRUE)



############################################################################
# HISTORY:
# 2008-03-14
# o Added getImage().
# o Added as.GrayscaleImage() and as.TrueColorImage().
# o Created from getImage() of AffymetrixCelFile.
############################################################################
