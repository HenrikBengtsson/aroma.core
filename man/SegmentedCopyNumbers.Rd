%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  SegmentedCopyNumbers.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{SegmentedCopyNumbers}
\docType{class}
\alias{SegmentedCopyNumbers}


 \title{The SegmentedCopyNumbers class}

 \description{
  Package:  aroma.core \cr
\bold{Class SegmentedCopyNumbers}\cr

\code{data.frame}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RichDataFrame}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[aroma.core]{RawCopyNumbers}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{SegmentedGenomicSignalsInterface}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\code{SegmentedCopyNumbers}\cr

\bold{Directly known subclasses:}\cr
\cr

public class \bold{SegmentedCopyNumbers}\cr
extends \link[aroma.core]{SegmentedGenomicSignalsInterface}\cr


 }

 \usage{
SegmentedCopyNumbers(..., states=NULL)
}

 \arguments{
   \item{...}{Arguments passed to \code{\link{RawCopyNumbers}}.}
   \item{states}{A \code{\link[base]{function}} returning the copy-number states given a
     \code{\link[base]{vector}} of locus positions.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\emph{No methods defined}.


 \bold{Methods inherited from SegmentedGenomicSignalsInterface}:\cr
as.data.frame, binnedSmoothingByState, extractSubsetByState, findChangePointsByState, getStateColorMap, getStateColors, getStates, getUniqueStates, getVirtualField, getVirtualLocusFields, kernelSmoothingByState, plot, points, setStateColorMap, setStates

 \bold{Methods inherited from RawCopyNumbers}:\cr
cnRange, extractRawCopyNumbers, getCNs, getCn, getSignals, plot

 \bold{Methods inherited from RawGenomicSignals}:\cr
*, +, -, addBy, append, applyBinaryOperator, as.character, as.data.frame, assertOneChromosome, binnedSmoothing, binnedSmoothingByField, clearCache, clone, divideBy, drawDensity, estimateStandardDeviation, extractChromosome, extractChromosomes, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getBasicField, getCXY, getChromosome, getChromosomes, getDefaultLocusFields, getLocusFields, getPositions, getSigma, getSignalColumnName, getSignalColumnNames, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, plot, points, print, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setBasicField, setSigma, setSignals, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from RichDataFrame}:\cr
$, $<-, [, [[, [[<-, as.data.frame, as.list, dim, dropVirtualColumn, getColumnNames, getColumnNamesTranslator, getFullName, getName, getTags, getVirtualColumn, getVirtualColumnFunction, getVirtualColumnNames, hasColumn, hasColumns, hasVirtualColumn, hasVirtualColumns, length, names, newInstance, print, rbind, setAttributes, setColumnNamesMap, setColumnNamesTranslator, setName, setTags, setVirtualColumn, subset, translateColumnNames

 \bold{Methods inherited from data.frame}:\cr
$<-,data.frame-method, $<-, Math, Ops,nonStructure,vector-method, Ops,structure,vector-method, Ops,vector,nonStructure-method, Ops,vector,structure-method, Ops, Summary, [, [<-,data.frame-method, [<-, [[, [[<-,data.frame-method, [[<-, aggregate, anyDuplicated, anyNA, as.NonPairedPSCNData, as.PairedPSCNData, as.data.frame, as.list, as.matrix, as.vector, attachLocally, by, callSegmentationOutliers, cbind, coerce,ANY,list-method, coerce,oldClass,S3-method, dim, dimnames, dimnames<-, dropSegmentationOutliers, droplevels, duplicated, edit, findLargeGaps, format, formula, head, initialize,oldClass-method, is.na, merge, na.exclude, na.omit, plot, plotDensity, print, prompt, rbind, row.names, row.names<-, rowsum, segmentByCBS, segmentByPairedPSCBS, show,oldClass-method, slotsFromS3,data.frame-method, split, split<-, stack, str, subset, summary, t, tail, transform, type.convert, unique, unstack, unwrap, within, wrap, writeDataFrame, xtfrm


 }

 \examples{
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Simulating copy-number data
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# True CN states
stateFcn <- function(x, ...) {
  states <- integer(length(x))
  states[200 <=x & x <= 300] <- -1L
  states[650 <=x & x <= 800] <- +1L
  states
}

# Number of loci
J <- 1000

y <- rnorm(J, sd=1/2)
x <- 1:length(y)
for (state in c(-1,+1)) {
  idxs <- (stateFcn(x) == state)
  y[idxs] <- y[idxs] + state
}


cn <- SegmentedCopyNumbers(y, x, states=stateFcn)
print(cn)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Subsetting
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
plot(cn, ylim=c(-4,4))
title("Copy numbers annotated by state (and subset by state)")

cnS <- extractSubsetByState(cn, states=c(0,+1L))
print(cnS)
points(cnS, pch=21, cex=1.2, lwd=2, col="purple")

legend("topright", pch=c(19, 21), col=c("#999999", "purple"),
       sprintf(c("raw [n=\%d]", "CN in {0,1} [n=\%d]"),
       c(nbrOfLoci(cn), nbrOfLoci(cnS))), bty="n")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Kernel smoothing stratified by state
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
plot(cn, col="#999999", ylim=c(-3,3))
title(main="Kernel smoothing stratified by state w/ Gaussian kernel")

cnSa <- kernelSmoothingByState(cn, h=2)
points(cnSa, col="blue")

cnSb <- kernelSmoothingByState(cn, h=5)
points(cnSb, col="red")

legend("topright", pch=19, col=c("#999999", "blue", "red"),
       sprintf(c("raw [n=\%d]", "N(.,sd=2) [n=\%d]", "N(.,sd=5) [n=\%d]"),
       c(nbrOfLoci(cn), nbrOfLoci(cnSa), nbrOfLoci(cnSb))), bty="n")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Binned smoothing stratified by state
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
plot(cn, col="#999999", ylim=c(-3,3))
title(main="Binned smoothing stratified by state")

cnSa <- binnedSmoothingByState(cn, by=3, verbose=-1)
lines(cnSa, col="blue")
points(cnSa, col="blue")

cnSb <- binnedSmoothingByState(cn, by=9, verbose=-1)
lines(cnSb, col="red")
points(cnSb, col="red")

legend("topright", pch=19, col=c("#999999", "blue", "red"),
       sprintf(c("raw [n=\%d]", "Bin(w=3) [n=\%d]", "Bin(w=9) [n=\%d]"),
       c(nbrOfLoci(cn), nbrOfLoci(cnSa), nbrOfLoci(cnSb))), bty="n")
}

 \author{Henrik Bengtsson}
\keyword{classes}
