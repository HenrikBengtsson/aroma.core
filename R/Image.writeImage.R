setMethodS3("writeImage", "Image", function(x, file, ...) {
  if (compareVersion(packageDescription("EBImage")$Version, "2.1.23") >= 0) {
    EBImage::writeImage(x, files=file, ...);
  } else {
    EBImage::write.image(x, files=file, ...);
  }
}, protected=TRUE)


############################################################################
# HISTORY:
# 2011-01-30
# o Added in order to clean up aroma.affymetrix, cf. writeImage() for
#   AffymetrixCelFile.
# o Created.
############################################################################
