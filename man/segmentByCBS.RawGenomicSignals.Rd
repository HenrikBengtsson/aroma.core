%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RawGenomicSignals.segmentByCBS.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 \name{segmentByCBS.RawGenomicSignals}
\alias{segmentByCBS.RawGenomicSignals}
\alias{RawGenomicSignals.segmentByCBS}
\alias{segmentByCBS.RawGenomicSignals}
\alias{segmentByCBS,RawGenomicSignals-method}


 \title{Segment copy numbers using the CBS method}

 \description{
  Segment copy numbers using the CBS method of the \pkg{DNAcopy} package.
 }

 \usage{\method{segmentByCBS}{RawGenomicSignals}(this, ..., cache=FALSE, force=FALSE, verbose=FALSE)}

 \arguments{
   \item{...}{Additional arguments passed to the segmentation function.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 }

 \value{
  Returns the fit object.
 }

 \details{
   Internally \code{\link[DNAcopy]{segment}} is used to segment the signals.
   This segmentation method support weighted segmentation.
 }

 \examples{
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Simulating copy-number data
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Number of loci
J <- 1000

mu <- double(J)
mu[200:300] <- mu[200:300] + 1
mu[650:800] <- mu[650:800] - 1
eps <- rnorm(J, sd=1/2)
y <- mu + eps
x <- sort(runif(length(y), max=length(y)))
w <- runif(J)
w[650:800] <- 0.001


cn <- RawCopyNumbers(y, x)
print(cn)

plot(cn, col="#aaaaaa")

cnS <- binnedSmoothing(cn, by=10)
print(cnS)
lines(cnS, col="black", lwd=3)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Segment
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
legend <- c()

fit <- segmentByCBS(cn)
cnr <- extractCopyNumberRegions(fit)
print(cnr)
drawLevels(cnr, col="red", lwd=3)
legend <- c(legend, red="CBS")

fit <- segmentByGLAD(cn)
cnr <- extractCopyNumberRegions(fit)
print(cnr)
drawLevels(cnr, col="blue", lwd=3)
legend <- c(legend, blue="GLAD")

if (require("HaarSeg")) {
  fit <- segmentByHaarSeg(cn)
  cnr <- extractCopyNumberRegions(fit)
  print(cnr)
  drawLevels(cnr, col="orange", lwd=3)
  legend <- c(legend, orange="HaarSeg")
}

legend("topleft", pch=19, col=names(legend), legend, bty="n", horiz=TRUE)
}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   For more information see \code{\link{RawGenomicSignals}}.
 }


\keyword{internal}
\keyword{methods}
\keyword{IO}
