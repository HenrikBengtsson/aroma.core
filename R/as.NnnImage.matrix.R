###########################################################################/**
# @set "class=matrix"
# @RdocMethod as.GrayscaleImage
# @aliasmethod as.TrueColorsImage
#
# @title "Creates a Grayscale (TrueColor) Image from a matrix file"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{z}{A KxN @matrix.}
#   \item{transforms}{A @list of transform @functions.}
#   \item{interleaved}{A @character string specifying how the image data
#     should be interleaved, if at all.}
#   \item{scale}{A @numeric scale factor in (0,+Inf) for resizing the 
#     imaging. If \code{1}, no resizing is done.}
#   \item{...}{Passed to \code{colorize()} of @see "EBImage::Image".}
#   \item{verbose}{A @logical or a @see "R.utils::Verbose" object.}
# }
#
# \value{
#   Returns an @see "EBImage::Image" object.
# }
#
# \author{Henrik Bengtsson and Ken Simpson.}
#
# \seealso{
#   @see "EBImage::Image".
#   @seeclass
# }
#
# @keyword IO
#*/###########################################################################
setMethodS3("as.GrayscaleImage", "matrix", function(z, transforms=NULL, interleaved=c("none", "h", "v", "auto"), scale=1, ..., verbose=FALSE) {
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
  # Argument 'transforms':
  if (!is.null(transforms)) {
    if (!is.list(transforms)) {
      transforms <- list(transforms);
    }
  }

  for (transform in transforms) {
    if (!is.function(transform)) {
      throw("Argument 'transforms' contains a non-function: ", 
                                                        mode(transform));
    }
  }

  # Argument 'interleaved':
  interleaved <- match.arg(interleaved);

  # Argument 'scale':
  scale <- Arguments$getNumeric(scale, range=c(0,Inf));

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Read data
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  verbose && enter(verbose, "Creating Image object from matrix");

  # Transform signals?
  for (transform in transforms) {
    dim <- dim(z);
    z <- transform(z);
    dim(z) <- dim;
  }

  # Transform into [0,1]
  # EBImage: "Grayscale values are assumed to be in the range [0,1], 
  # although this is not a requirement in sense of data storage. Although,
  # many image processing functions will assume data in this range or will
  # generate invalid results for the data out of this range."
  verbose && enter(verbose, "Rescaling to [0,1]");
  r <- range(z, na.rm=TRUE, finite=TRUE);
  z <- (z - r[1])/(r[2]-r[1]);
  verbose && summary(verbose, as.vector(z));
  verbose && exit(verbose);

  # Create an EBImage Image object
  z <- t(z);
  img <- EBImage::Image(data=z, dim=dim(z), colormode=EBImage::Grayscale);

  # if only PM locations have signal, add a fake row?
  img <- interleave(img, what=interleaved);

  # Scale (if scale ==1, it does nothing)
  img <- rescale(img, scale=scale);

  verbose && exit(verbose);

  img;
}, protected=TRUE)


setMethodS3("as.TrueColorImage", "matrix", function(z, ...) {
  img <- as.GrayscaleImage(z, ...);
  img <- colorize(img, ...);
  img;
}, protected=TRUE)


setMethodS3("as.TrueColorImage", "Image", function(img, ...) {
  colorMode <- colorMode(img);
  if (colorMode == EBImage::TrueColor)
    return(img);

  img <- colorize(img, ...);

  img;
}, protected=TRUE)


############################################################################
# HISTORY:
# 2010-06-22
# o BUG FIX: as.GrayscaleImage(..., transforms=NULL) for 'matrix' would
#   throw "Exception: Argument 'transforms' contains a non-function: NULL".
# 2009-05-16
# o Now argument 'scale' of as.GrayscaleImage() is validated using 
#   Arguments$getNumeric() [not getDouble()].
# 2008-10-16
# o BUG FIX: Tried to turn a function passed by 'transforms' to a list using
#   as.list() and not list().
# 2008-03-14
# o Added getImage().
# o Added as.GrayscaleImage() and as.TrueColorImage().
# o Created from getImage() of AffymetrixCelFile.
############################################################################
