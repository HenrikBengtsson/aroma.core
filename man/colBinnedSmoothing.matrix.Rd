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

 \usage{\method{colBinnedSmoothing}{matrix}(Y, x=seq(length = ncol(Y)), w=NULL, from=min(x, na.rm = TRUE), to=max(x, na.rm = TRUE), by=NULL, length.out=length(x), xOut=NULL, na.rm=TRUE, FUN="median", ..., verbose=FALSE)}

 \arguments{
   \item{Y}{A \code{\link[base]{numeric}} JxI \code{\link[base]{matrix}} (or a \code{\link[base]{vector}} of length J.)}
   \item{x}{A (optional) \code{\link[base]{numeric}} \code{\link[base]{vector}} specifying the positions of
     the J entries. The default is to assume uniformly distributed
     positions.}
   \item{w}{A optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of prior weights for each of
     the J entries.}
   \item{from,to}{The center location of the first and the last bin.}
   \item{by}{The distance between the center locations of each bin.}
   \item{length.out}{The number of bins.}
   \item{xOut}{Prespecified center locations.}
   \item{na.rm}{If \code{\link[base:logical]{TRUE}}, missing values are excluded, otherwise not.}
   \item{FUN}{A \code{\link[base]{function}}.}
   \item{...}{Not used.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 }

 \value{
   Returns a \code{\link[base]{numeric}} KxI \code{\link[base]{matrix}} (or a \code{\link[base]{vector}} of length K) where
   K is the total number of bins.
   Attribute 'xOut' specifies the center locations of each bin.
   The center locations are always uniformly distributed.
   Attribute 'binWidth' specifies the width of the bins.
   The width of the bins are always the same and identical to the
   distance between two adjacent bin centers.
 }

 \examples{
J <- 100
I <- 4
Y <- matrix(rnorm(I*J, sd=1/2), ncol=I)
# Introduce a gain in column 2 and 3
Y[30:50,2:3] <- Y[30:50,2:3] + 3
x <- 1:J

Ys3 <- colBinnedSmoothing(Y, x=x, from=2, by=3)
Ys5 <- colBinnedSmoothing(Y, x=x, from=3, by=5)

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
}
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
