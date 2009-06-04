setMethodS3("rescale", "Image", function(this, scale=1, blur=FALSE, ..., verbose=FALSE) {
  require("EBImage") || throw("Package not loaded: EBImage.");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'scale':
  scale <- Arguments$getNumeric(scale, range=c(0,Inf));

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  # Nothing to do?
  if (scale == 1)
    return(this);

  verbose && enter(verbose, "Rescaling image");
  verbose && sprintf(verbose, "Scale: %.2g\n", scale);
  img <- EBImage::resize(this, w=scale*dim(this)[1], blur=blur);
  verbose && exit(verbose);

  img;
})


############################################################################
# HISTORY:
# 2009-05-16
# o Now rescale() for Image uses Arguments$getNumerics(), not 
#   getDoubles(), where possible.  This will save memory in some cases.
# 2008-03-14
# o Created from getImage() of AffymetrixCelFile.
############################################################################

