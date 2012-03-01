%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  SegmentedAlleleBFracions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{SegmentedAlleleBFractions}
\docType{class}
\alias{SegmentedAlleleBFractions}


 \title{The SegmentedAlleleBFractions class}

 \description{
  Package:  aroma.core \cr
\bold{Class SegmentedAlleleBFractions}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawAlleleBFractions}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[aroma.core]{SegmentedGenomicSignalsInterface}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{SegmentedAlleleBFractions}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{SegmentedAlleleBFractions}\cr
extends \link[aroma.core]{SegmentedGenomicSignalsInterface}\cr


 }

 \usage{SegmentedAlleleBFractions(..., states=NULL)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{RawAlleleBFractions}}.}
   \item{states}{A \code{\link[base]{function}} returning the copy-number states given a
     \code{\link[base]{vector}} of locus positions.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\emph{No methods defined}.


 \bold{Methods inherited from SegmentedGenomicSignalsInterface}:\cr
as.data.frame, binnedSmoothingByState, extractSubsetByState, getStateColorMap, getStateColors, getStates, getUniqueStates, kernelSmoothingByState, plot, points, setStateColorMap, setStates

 \bold{Methods inherited from RawAlleleBFractions}:\cr
extractRawMirroredAlleleBFractions, plot

 \bold{Methods inherited from RawGenomicSignals}:\cr
-, *, +, addBy, addLocusFields, append, applyBinaryOperator, as.data.frame, assertOneChromosome, binnedSmoothing, divideBy, drawDensity, estimateStandardDeviation, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getChromosome, getChromosomes, getCXY, getLocusFields, getName, getPositions, getSigma, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, plot, points, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setLocusFields, setName, setSigma, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, summary, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from Object}:\cr
asThis, getChecksum, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
