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
#   \item{xOut}{Optional @numeric @vector of K bin center locations.}
#   \item{xOutRange}{Optional Kx2 @matrix specifying the boundary
#     locations for bins.
#     If not specified, the boundaries are set to be the midpoints
#     of the bin centers, such that the bins have maximum lengths
#     without overlapping.
#     Also, if \code{xOut} is not specified, then it is set to be the
#     mid points of these boundaries.
#   }
#   \item{from, to, by, length.out}{
#     If neither \code{xOut} nor \code{xOutRange} is specified,
#     the \code{xOut} is generated uniformly from these arguments, which 
#     specify the center location of the first and the last bin, and the
#     distance between the center locations, utilizing the
#     @see "base::seq" function.
#     Argument \code{length.out} can be used as an alternative to
#     \code{by}, in case it specifies the total number of bins instead.
#   }
#   \item{FUN}{A @function.}
#   \item{na.rm}{If @TRUE, missing values are excluded, otherwise not.}
#   \item{...}{Not used.}
#   \item{verbose}{See @see "R.utils::Verbose".}
# }
#
# \value{
#   Returns a @numeric KxI @matrix (or a @vector of length K) where
#   K is the total number of bins.
#   The following attributes are also returned:
#   \itemize{
#    \item{\code{xOut}}{The center locations of each bin.}
#    \item{\code{xOutRange}}{The bin boundaries.}
#    \item{\code{count}}{The number of data points within each bin
#         (based solely on argument \code{x}).}
#    \item{\code{binWidth}}{The \emph{average} bin width.}
#  }
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
setMethodS3("colBinnedSmoothing", "matrix", function(Y, x=seq(length=ncol(Y)), w=NULL, xOut=NULL, xOutRange=NULL, from=min(x, na.rm=TRUE), to=max(x, na.rm=TRUE), by=NULL, length.out=length(x), na.rm=TRUE, FUN="median", ..., verbose=FALSE) {
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
    o <- order(xOut);
    if (!all(diff(o) > 0L)) {
      throw("Argument 'xOut' must be strictly ordered: ", hpaste(na.omit(xOut)));
    }
  }

  # Argument 'xOut':
  if (!is.null(xOutRange)) {
    if (!is.matrix(xOutRange)) {
      throw("Argument 'xOutRange' must be a matrix: ", hpaste(class(xOutRange)));
    }
    if (ncol(xOutRange) != 2L) {
      throw("Argument 'xOutRange' must be a matrix with two columns: ", ncol(xOutRange));
    }
    stopifnot(all(xOutRange[,2L] >= xOutRange[,1L]));
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
    # Generate from bin boundaries, or by using seq()?
    if (!is.null(xOutRange)) {
      # Place in the center of the bins
      xOut <- (xOutRange[,1L] + xOutRange[,2L]) / 2;
    } else {
      if (!is.null(by)) {
        xOut <- seq(from=from, to=to, by=by);
      } else {
        xOut <- seq(from=from, to=to, length.out=length.out);
      }
    }
  }

  # Number of bins
  nOut <- length(xOut);

  verbose && cat(verbose, "xOut:");
  verbose && str(verbose, xOut);

  # Create 'xOutRange' (or validate existing)
  if (is.null(xOutRange)) {
    # Average bin width
    if (is.null(by)) {
      avgBinWidth <- mean(diff(xOut), na.rm=TRUE);
    } else {
      avgBinWidth <- by;
    }

    # Identify mid points between target locations
    xOutMid <- (xOut[-1L] + xOut[-nOut]) / 2;
    xOutMid <- c(xOutMid[1L]-avgBinWidth, xOutMid, xOutMid[nOut-1L]+avgBinWidth);

    naValue <- as.double(NA);
    xOutRange <- matrix(naValue, nrow=nOut, ncol=2);
    xOutRange[,1L] <- xOutMid[-length(xOutMid)];
    xOutRange[,2L] <- xOutMid[-1L];
  } else {
    # Validate
    if (nrow(xOutRange) != nOut) {
      throw("The number of rows in 'xOutRange' does not match the number of bin: ", ncol(xOutRange), " != ", nOut);
    }

    # Assert that the bin boundaries [x0,x1) contains the target bin.
    stopifnot(all(xOutRange[,1L] <= xOut));
    stopifnot(all(xOut <= xOutRange[,2L]));
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Smoothing in bins
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Allocate vector of smoothed signals
  Ys <- matrix(NA, nrow=nOut, ncol=k);

  verbose && enter(verbose, "Estimating signals in each bin");

  verbose && cat(verbose, "Output locations (bin centers):");
  verbose && str(verbose, xOut);

  # Speed up access access
  x0 <- xOutRange[,1L, drop=TRUE];
  x1 <- xOutRange[,2L, drop=TRUE];

  verbose && cat(verbose, "Summary of bin widths:");
  verbose && print(verbose, summary(x1-x0));

  # Allocate number of counts per bin
  counts <- integer(nOut);

  # For each bin...
  for (kk in seq_len(nOut)) {
    if (kk %% 100 == 0)
      verbose && cat(verbose, kk);

    # Identify data points within the bin
    keep <- whichVector(x0[kk] <= x & x < x1[kk]);
    nKK <- length(keep);
    counts[kk] <- nKK;

    # Nothing to do?
    if (nKK == 0) {
      next;
    }

    # Keep only data points and prior weight within the current bin
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

  # Average bin width
  avgBinWidth <- mean(xOutRange[,2L] - xOutRange[,1L], na.rm=TRUE);

  attr(Ys, "xOut") <- xOut;
  attr(Ys, "xOutRange") <- xOutRange;
  attr(Ys, "counts") <- counts;
  attr(Ys, "binWidth") <- avgBinWidth;

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
# 2011-12-11
# o ROBUSTNESS: colBinnedSmoothing() now asserts that 'xOut' is ordered.
# 2011-12-10
# o Returning also the bin counts.
# o Now it is possible to fully specify the location and the width
#   of each bin used by colBinnedSmoothing().
# o Moved argument 'xOut' and new 'xOutRange' up front.
# o DOCUMENTATION: Put 'from', 'to', 'by' and 'length.out' into one
#   argument item and reference help for seq() as well.
# o CORRECTNESS: Now bins are by default strictly disjoint, by redefining
#   them as [x0,x1) instead of [x0,x1].
# o CLEANUP: Dropped unused 'xDiff <- xDiff[keep]'.
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
