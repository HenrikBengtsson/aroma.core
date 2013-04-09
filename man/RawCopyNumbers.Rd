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

\code{data.frame}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RichDataFrame}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{RawCopyNumbers}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{SegmentedCopyNumbers}\cr

public class \bold{RawCopyNumbers}\cr
extends \link[aroma.core]{RawGenomicSignals}\cr


 }

 \usage{
RawCopyNumbers(cn=NULL, ...)
}

 \arguments{
   \item{cn}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of length J specifying the copy number
     at each loci.}
   \item{...}{Arguments passed to \code{\link{RawGenomicSignals}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{cnRange} \tab  -\cr
 \tab \code{extractRawCopyNumbers} \tab  -\cr
 \tab \code{getSignals} \tab  -\cr
 \tab \code{plot} \tab  -\cr
}


 \bold{Methods inherited from RawGenomicSignals}:\cr
*, +, -, addBy, append, applyBinaryOperator, as.character, as.data.frame, assertOneChromosome, binnedSmoothing, binnedSmoothingByField, clearCache, clone, divideBy, drawDensity, estimateStandardDeviation, extractChromosome, extractChromosomes, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getBasicField, getCXY, getChromosome, getChromosomes, getDefaultLocusFields, getLocusFields, getPositions, getSigma, getSignalColumnName, getSignalColumnNames, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, plot, points, print, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setBasicField, setSigma, setSignals, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from RichDataFrame}:\cr
$, $<-, [, [[, [[<-, as.data.frame, as.list, dim, dropVirtualColumn, getColumnNames, getColumnNamesTranslator, getFullName, getName, getTags, getVirtualColumn, getVirtualColumnFunction, getVirtualColumnNames, hasColumn, hasColumns, hasVirtualColumn, hasVirtualColumns, length, names, newInstance, print, rbind, setAttributes, setColumnNamesMap, setColumnNamesTranslator, setName, setTags, setVirtualColumn, subset, translateColumnNames

 \bold{Methods inherited from data.frame}:\cr
$<-, Math, Ops, Summary, [, [<-, [[, [[<-, aggregate, anyDuplicated, as.NonPairedPSCNData, as.PairedPSCNData, as.data.frame, as.list, as.matrix, attachLocally, by, cbind, dim, dimnames, dimnames<-, droplevels, duplicated, edit, format, formula, head, is.na, merge, na.exclude, na.omit, plot, plotDensity, print, prompt, rbind, row.names, row.names<-, rowsum, split, split<-, stack, str, subset, summary, t, tail, transform, unique, unstack, unwrap, within, wrap, writeDataFrame


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

 \author{Henrik Bengtsson}
\keyword{classes}
