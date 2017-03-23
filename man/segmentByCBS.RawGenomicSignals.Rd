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
\alias{segmentByCBS,RawGenomicSignals-method}

\title{Segment copy numbers using the CBS method}

\description{
 Segment copy numbers using the CBS method of the \pkg{DNAcopy} package.
 For more details on the Circular Binary Segmentation (CBS) method
 see [1,2].
}

\usage{
\method{segmentByCBS}{RawGenomicSignals}(this, ..., seed=NULL, cache=FALSE, force=FALSE, verbose=FALSE)
}

\arguments{
  \item{...}{Additional arguments passed to the segmentation function.}
  \item{seed}{An (optional) \code{\link[base]{integer}} specifying the random seed to be
    set before calling the segmentation method.  The random seed is
    set to its original state when exiting.  If \code{\link[base]{NULL}}, it is not set.}
  \item{cache}{If \code{\link[base:logical]{TRUE}}, results are cached to file, otherwise not.}
  \item{force}{If \code{\link[base:logical]{TRUE}}, cached results are ignored.}
  \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns the fit object.
}

\details{
  Internally \code{\link[DNAcopy]{segment}} is used to segment the signals.
  This segmentation method support weighted segmentation.

  The "DNAcopy::segment" implementation of CBS uses approximation
  through random sampling for some estimates.  Because of this,
  repeated calls using the same signals may result in slightly
  different results.
}

\examples{
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Simulating copy-number data
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Number of loci
J <- 500

mu <- double(J)
mu[100:150] <- mu[100:150] + 1
mu[320:400] <- mu[320:400] - 1
eps <- rnorm(J, sd=1/2)
y <- mu + eps
x <- sort(runif(length(y), max=length(y))) * 1e5
w <- runif(J)
w[320:400] <- 0.001


cn <- RawCopyNumbers(y, x)
print(cn)

plot(cn, ylim=c(-3,3), col="#aaaaaa", xlab="Position (Mb)")

cnS <- binnedSmoothing(cn, by=500e3)
print(cnS)
lines(cnS, col="black", lwd=3)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Segment
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
legend <- c()

if (require("DNAcopy")) {
  fit <- segmentByCBS(cn)
  cnr <- extractCopyNumberRegions(fit)
  print(cnr)
  drawLevels(cnr, col="red", lwd=3)
  legend <- c(legend, red="CBS")
}

if (require("GLAD") && packageVersion("GLAD") != "9.9.9") {
  fit <- segmentByGLAD(cn)
  cnr <- extractCopyNumberRegions(fit)
  print(cnr)
  drawLevels(cnr, col="blue", lwd=3)
  legend <- c(legend, blue="GLAD")
}

if (require("HaarSeg")) {
  fit <- segmentByHaarSeg(cn)
  cnr <- extractCopyNumberRegions(fit)
  print(cnr)
  drawLevels(cnr, col="orange", lwd=3)
  legend <- c(legend, orange="HaarSeg")
}

if (require("mpcbs")) {
  fit <- segmentByMPCBS(cn)
  cnr <- extractCopyNumberRegions(fit)
  print(cnr)
  drawLevels(cnr, col="white", lwd=6)
  drawLevels(cnr, col="purple", lwd=3)
  legend <- c(legend, purple="MPCBS")
}


if (length(legend) > 0) {
  legend("topleft", pch=19, col=names(legend), legend, bty="n", horiz=TRUE)
}
}

\author{Henrik Bengtsson}

\seealso{
  For more information see \code{\link{RawGenomicSignals}}.
}

\references{
 [1] A.B. Olshen, E.S. Venkatraman (aka Venkatraman E. Seshan),
     R. Lucito and M. Wigler, \emph{Circular binary segmentation for
     the analysis of array-based DNA copy number data},
     Biostatistics, 2004.\cr
 [2] E.S. Venkatraman and A.B. Olshen, \emph{A faster circular binary
     segmentation algorithm for the analysis of array CGH data}.
     Bioinformatics, 2007.\cr
}


\keyword{internal}
\keyword{methods}
\keyword{IO}
