%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RawCopyNumbers.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{RawCopyNumbers}
\docType{class}
\alias{RawCopyNumbers}


 \title{The RawCopyNumbers class}

 \description{
  Package:  aroma.core \cr
\bold{Class RawCopyNumbers}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{RawCopyNumbers}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{SegmentedCopyNumbers}\cr

public static class \bold{RawCopyNumbers}\cr
extends \link[aroma.core]{RawGenomicSignals}\cr


 }

 \usage{RawCopyNumbers(cn=NULL, ...)}

 \arguments{
   \item{cn}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of length J specifying the copy number
     at each loci.}
   \item{...}{Arguments passed to \code{\link{RawGenomicSignals}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as.data.frame} \tab  -\cr
 \tab \code{cnRange} \tab  -\cr
 \tab \code{extractRawCopyNumbers} \tab  -\cr
 \tab \code{plot} \tab  -\cr
}


 \bold{Methods inherited from RawGenomicSignals}:\cr
addBy, addLocusFields, append, applyBinaryOperator, as.data.frame, binnedSmoothing, divideBy, estimateStandardDeviation, extractDataForSegmentation, extractRegion, extractSubset, gaussianSmoothing, getChromosome, getLocusFields, getName, getPositions, getSigma, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfLoci, plot, points, setLocusFields, setName, setSigma, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, summary, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


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


cn <- RawCopyNumbers(y, x)
print(cn)

cn2 <- extractSubset(cn, subset=xSeq(cn, by=5))
print(cn2)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Plot along genome
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
plot(cn, ylim=c(-3,3))
title(main="Complete and subsetted loci")
points(cn2, col="red", pch=176, cex=2)

legend("topright", pch=c(19,176), col=c("#999999", "red"), sprintf(c("raw [n=\%d]", "every 5th [n=\%d]"), c(nbrOfLoci(cn), nbrOfLoci(cn2))), bty="n")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Binned smoothing
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
plot(cn, col="#999999", ylim=c(-3,3))
title(main="Binned smoothing")

cnSa <- binnedSmoothing(cn, by=3)
lines(cnSa, col="blue")
points(cnSa, col="blue")

cnSb <- binnedSmoothing(cn, by=9)
lines(cnSb, col="red")
points(cnSb, col="red")

legend("topright", pch=19, col=c("#999999", "blue", "red"), sprintf(c("raw [n=\%d]", "Bin(w=3) [n=\%d]", "Bin(w=9) [n=\%d]"), c(nbrOfLoci(cn), nbrOfLoci(cnSa), nbrOfLoci(cnSb))), bty="n")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Binned smoothing (by count)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
plot(cn, col="#999999", ylim=c(-3,3))
title(main="Binned smoothing (by count)")

cnSa <- binnedSmoothing(cn, by=3, byCount=TRUE)
lines(cnSa, col="blue")
points(cnSa, col="blue")

cnSb <- binnedSmoothing(cn, by=9, byCount=TRUE)
lines(cnSb, col="red")
points(cnSb, col="red")

legend("topright", pch=19, col=c("#999999", "blue", "red"), sprintf(c("raw [n=\%d]", "BinO(w=3) [n=\%d]", "BinO(w=9) [n=\%d]"), c(nbrOfLoci(cn), nbrOfLoci(cnSa), nbrOfLoci(cnSb))), bty="n")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Kernel smoothing (default is Gaussian)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
plot(cn, col="#999999", ylim=c(-3,3))
title(main="Kernel smoothing w/ Gaussian kernel")

cnSa <- kernelSmoothing(cn, h=2)
points(cnSa, col="blue")

cnSb <- kernelSmoothing(cn, h=5)
points(cnSb, col="red")

legend("topright", pch=19, col=c("#999999", "blue", "red"), sprintf(c("raw [n=\%d]", "N(.,sd=2) [n=\%d]", "N(.,sd=5) [n=\%d]"), c(nbrOfLoci(cn), nbrOfLoci(cnSa), nbrOfLoci(cnSb))), bty="n")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Kernel smoothing
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
plot(cn, col="#999999", ylim=c(-3,3))
title(main="Kernel smoothing w/ uniform kernel")

xOut <- xSeq(cn, by=10)
cnSa <- kernelSmoothing(cn, xOut=xOut, kernel="uniform", h=2)
lines(cnSa, col="blue")
points(cnSa, col="blue")

cnSb <- kernelSmoothing(cn, xOut=xOut, kernel="uniform", h=5)
lines(cnSb, col="red")
points(cnSb, col="red")

legend("topright", pch=19, col=c("#999999", "blue", "red"), sprintf(c("raw [n=\%d]", "U(w=2) [n=\%d]", "U(w=5) [n=\%d]"), c(nbrOfLoci(cn), nbrOfLoci(cnSa), nbrOfLoci(cnSb))), bty="n")
}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
