%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  colBinnedSmoothing.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 \name{colBinnedSmoothing.matrix}
\alias{colBinnedSmoothing.matrix}
\alias{colBinnedSmoothing.matrix}

 \alias{colBinnedSmoothing}
 \alias{binnedSmoothing}
 \alias{binnedSmoothing.numeric}

 \title{Binned smoothing of a matrix column by column}

 \description{
  Binned smoothing of a matrix column by column.
 }

 \usage{\method{colBinnedSmoothing}{matrix}(Y, x=seq(length = ncol(Y)), w=NULL, xOut=NULL, xOutRange=NULL, from=min(x, na.rm = TRUE), to=max(x, na.rm = TRUE), by=NULL, length.out=length(x), na.rm=TRUE, FUN="median", ..., verbose=FALSE)}

 \arguments{
   \item{Y}{A \code{\link[base]{numeric}} JxI \code{\link[base]{matrix}} (or a \code{\link[base]{vector}} of length J.)}
   \item{x}{A (optional) \code{\link[base]{numeric}} \code{\link[base]{vector}} specifying the positions of
     the J entries. The default is to assume uniformly distributed
     positions.}
   \item{w}{A optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of prior weights for each of
     the J entries.}
   \item{xOut}{Optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of K bin center locations.}
   \item{xOutRange}{Optional Kx2 \code{\link[base]{matrix}} specifying the boundary
     locations for bins.
     If not specified, the boundaries are set to be the midpoints
     of the bin centers, such that the bins have maximum lengths
     without overlapping.
     Also, if \code{xOut} is not specified, then it is set to be the
     mid points of these boundaries.
   }
   \item{from, to, by, length.out}{
     If neither \code{xOut} nor \code{xOutRange} is specified,
     the \code{xOut} is generated uniformly from these arguments, which
     specify the center location of the first and the last bin, and the
     distance between the center locations, utilizing the
     \code{\link[base]{seq}}() function.
     Argument \code{length.out} can be used as an alternative to
     \code{by}, in case it specifies the total number of bins instead.
   }
   \item{FUN}{A \code{\link[base]{function}}.}
   \item{na.rm}{If \code{\link[base:logical]{TRUE}}, missing values are excluded, otherwise not.}
   \item{...}{Not used.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 }

 \value{
   Returns a \code{\link[base]{numeric}} KxI \code{\link[base]{matrix}} (or a \code{\link[base]{vector}} of length K) where
   K is the total number of bins.
   The following attributes are also returned:
   \itemize{
    \item{\code{xOut}}{The center locations of each bin.}
    \item{\code{xOutRange}}{The bin boundaries.}
    \item{\code{count}}{The number of data points within each bin
         (based solely on argument \code{x}).}
    \item{\code{binWidth}}{The \emph{average} bin width.}
  }
 }

 \examples{
# Number of tracks
I <- 4

# Number of data points per track
J <- 100

# Simulate data with a gain in track 2 and 3
x <- 1:J
Y <- matrix(rnorm(I*J, sd=1/2), ncol=I)
Y[30:50,2:3] <- Y[30:50,2:3] + 3

# Uniformly distributed equal-sized bins
Ys3 <- colBinnedSmoothing(Y, x=x, from=2, by=3)
Ys5 <- colBinnedSmoothing(Y, x=x, from=3, by=5)

# Custom bins
xOutRange <- t(matrix(c(
  1, 11,
 11, 31,
 31, 41,
 41, 51,
 51, 81,
 81, 91,
 91,101
), nrow=2))
YsC <- colBinnedSmoothing(Y, x=x, xOutRange=xOutRange)

# Custom bins specified by center locations with
# maximized width relative to the neighboring bins.
xOut <- c(6, 21, 36, 46, 66, 86, 96)
YsD <- colBinnedSmoothing(Y, x=x, xOut=xOut)

xlim <- range(x)
ylim <- c(-3,5)
layout(matrix(1:I, ncol=1))
par(mar=c(3,3,1,1)+0.1, pch=19)
for (ii in 1:I) {
  plot(NA, xlim=xlim, ylim=ylim)
  points(x, Y[,ii], col="#999999")

  xOut <- attr(Ys3, "xOut");
  lines(xOut, Ys3[,ii], col=2)
  points(xOut, Ys3[,ii], col=2)

  xOut <- attr(Ys5, "xOut");
  lines(xOut, Ys5[,ii], col=3)
  points(xOut, Ys5[,ii], col=3)

  xOut <- attr(YsC, "xOut");
  lines(xOut, YsC[,ii], col=4)
  points(xOut, YsC[,ii], col=4, pch=15)

  xOut <- attr(YsD, "xOut");
  lines(xOut, YsD[,ii], col=5)
  points(xOut, YsD[,ii], col=5, pch=15)

  if (ii == 1) {
    legend("topright", pch=c(19,19,15,15), col=c(2,3,4,5),
           c("by=3", "by=5", "Custom #1", "Custom #2"), horiz=TRUE, bty="n");
  }
}


# Sanity checks
xOut <- x
YsT <- colBinnedSmoothing(Y, x=x, xOut=xOut)
stopifnot(all(YsT == Y))
stopifnot(all(attr(YsT, "counts") == 1))

xOut <- x[seq(from=2, to=J, by=3)]
YsT <- colBinnedSmoothing(Y, x=x, xOut=xOut)
stopifnot(all(YsT == Ys3))
stopifnot(all(attr(YsT, "counts") == 3))

xOut <- x[seq(from=3, to=J, by=5)]
YsT <- colBinnedSmoothing(Y, x=x, xOut=xOut)
stopifnot(all(YsT == Ys5))
stopifnot(all(attr(YsT, "counts") == 5))
}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   \code{\link[aroma.core:colKernelSmoothing.matrix]{*colKernelSmoothing}()}.
 }





\keyword{methods}
\keyword{array}
\keyword{iteration}
\keyword{robust}
\keyword{univar}
