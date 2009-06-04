###########################################################################/**
# @set "class=matrix"
# @RdocMethod colBinnedSmoothing
# @alias colBinnedSmoothing
# @alias binnedSmoothing
# @alias binnedSmoothing.numeric
#
# @title "Binned smoothing of a matrix column by column"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{Y}{A @numeric JxI @matrix (or a @vector of length J.)}
#   \item{x}{A (optional) @numeric @vector specifying the positions of
#     the J entries. The default is to assume uniformly distributed 
#     positions.}
#   \item{w}{A optional @numeric @vector of prior weights for each of 
#     the J entries.}
#   \item{from,to}{The center location of the first and the last bin.}
#   \item{by}{The distance between the center locations of each bin.}
#   \item{length.out}{The number of bins.}
#   \item{xOut}{Prespecified center locations.}
#   \item{na.rm}{If @TRUE, missing values are excluded, otherwise not.}
#   \item{FUN}{A @function.}
#   \item{...}{Not used.}
#   \item{verbose}{See @see "R.utils::Verbose".}
# }
#
# \value{
#   Returns a @numeric KxI @matrix (or a @vector of length K) where
#   K is the total number of bins.
#   Attribute 'xOut' specifies the center locations of each bin.
#   The center locations are always uniformly distributed.
#   Attribute 'binWidth' specifies the width of the bins.  
#   The width of the bins are always the same and identical to the
#   distance between two adjacent bin centers.
# }
#
# @examples "../incl/colBinnedSmoothing.Rex"
#
# @author
#
# \seealso{
#   @seemethod "colKernelSmoothing".
# }
#
# @keyword array
# @keyword iteration
# @keyword robust
# @keyword univar 
#*/###########################################################################
setMethodS3("colBinnedSmoothing", "matrix", function(Y, x=seq(length=ncol(Y)), w=NULL, from=min(x, na.rm=TRUE), to=max(x, na.rm=TRUE), by=NULL, length.out=length(x), xOut=NULL, na.rm=TRUE, FUN="median", ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'Y'
  n <- nrow(Y);
  k <- ncol(Y);
  
  # Argument 'x'
  if (length(x) != n) {
    throw("Argument 'x' has different number of values than rows in 'Y': ", 
                                                     length(x), " != ", n);
  }

  # Argument 'w'
  if (is.null(w)) {
  } else {
    if (length(w) != n) {
      throw("Argument 'w' has different number of values than rows in 'Y': ", 
                                                       length(w), " != ", n);
    }
  }

  # Argument 'from' & 'to':
  disallow <- c("NA", "NaN", "Inf");
  from <- Arguments$getNumeric(from, disallow=disallow);
  to <- Arguments$getNumeric(to, range=c(from,Inf), disallow=disallow);

  # Arguments 'by' & 'length.out':
  if (is.null(by) & is.null(length.out)) {
    throw("Either argument 'by' or 'length.out' needs to be given.");
  }
  if (n > 1 && !is.null(by)) {
    by <- Arguments$getNumeric(by, range=c(0,Inf));
  }
  if (!is.null(length.out)) {
    length.out <- Arguments$getInteger(length.out, range=c(0,Inf));
  }

  # Argument 'xOut':
  if (!is.null(xOut)) {
    xOut <- Arguments$getNumerics(xOut);
  }

  # Arguments 'na.rm':
  na.rm <- Arguments$getLogical(na.rm);

  # Arguments 'FUN':
  if (is.character(FUN)) {
    if (FUN == "median") {
      FUN <- colWeightedMedians;
    } else if (FUN == "mean") {
      FUN <- colWeightedMeans;
    } else {
      throw("Unknown value of argument 'FUN': ", FUN);
    }
  } else if (is.function(FUN)) {
  } else {
    throw("Argument 'FUN' is not a function: ", class(FUN)[1]);
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Binned smoothing column by column");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Setup (precalculations)
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Generate center locations of bins?
  if (is.null(xOut)) {
    if (!is.null(by)) {
      xOut <- seq(from=from, to=to, by=by);
    } else {
      xOut <- seq(from=from, to=to, length.out=length.out);
    }
  }

  verbose && cat(verbose, "xOut:");
  verbose && str(verbose, xOut);

  # Infer 'by' from 'xOut'?
  if (is.null(by)) {
    by <- mean(diff(xOut), na.rm=TRUE);
  }

  # Width of each bin
  h <- by;
  radius <- h/2;

  # Number of bins
  nOut <- length(xOut);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Smoothing in bins
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Allocate vector of smoothed signals
  Ys <- matrix(NA, nrow=nOut, ncol=k);

  verbose && enter(verbose, "Estimating signals in each bin");

  verbose && cat(verbose, "Output locations (centers of bins):");
  verbose && str(verbose, xOut);

  verbose && cat(verbose, "Distance between bins (width of each bin):");
  verbose && str(verbose, h);

  # For each bin...
  for (kk in seq_len(nOut)) {
    if (kk %% 100 == 0)
      verbose && cat(verbose, kk);

    # Weights centered around x[kk]
    xDiff <- (x-xOut[kk]);
    keep <- whichVector(abs(xDiff) <= radius);
    # Nothing to do?
    if (length(keep) == 0) {
      next;
    }

    # Keep only data points and prior weight within the current bin
    xDiff <- xDiff[keep];
    YBin <- Y[keep,,drop=FALSE];
    if (is.null(w)) {
      wBin <- NULL;
    } else {
      wBin <- w[keep];
    }

    value <- FUN(YBin, w=wBin, na.rm=na.rm);

    # Fix: Smoothing over a window with all missing values give zeros, not NA.
    idxs <- whichVector(value == 0);
    if (length(idxs) > 0) {
      # Are these real zeros or missing values?
      YBin <- YBin[idxs,,drop=FALSE];
      YBin <- !is.na(YBin);
      idxsNA <- idxs[colSums(YBin) == 0];    
      value[idxsNA] <- as.double(NA);
    }

#    verbose && str(verbose, value);

    Ys[kk,] <- value;
  } # for (kk ...)

  verbose && exit(verbose);

  attr(Ys, "xOut") <- xOut;
  attr(Ys, "binWidth") <- h;

  verbose && exit(verbose);

  Ys;
}) # colBinnedSmoothing()



setMethodS3("binnedSmoothing", "numeric", function(y, ...) {
  y <- colBinnedSmoothing(as.matrix(y), ...);
  dim(y) <- NULL;
  y;
})



############################################################################
# HISTORY:
# 2009-05-16
# o Now colBinnedSmoothing() uses Arguments$getNumerics(), not getDoubles(),
#   where possible.  This will save memory in some cases.
# 2009-05-12
# o Now colBinnedSmoothing() assert that 'from' and 'to' are finite.
# 2009-04-07
# o BUG FIX: When passing a single data points to colBinnedSmoothing(),
#   it would throw the exception: "Range of argument 'by' is out of range
#   [0,0]: [<by>,<by>]".
# 2009-03-23
# o Replace argument 'robust' with more generic 'FUN'.
# 2009-02-11
# o Added more verbose output to colBinnedSmoothing().
# 2009-02-07
# o Created.
############################################################################
