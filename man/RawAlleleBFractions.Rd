%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RawAlleleBFractions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{RawAlleleBFractions}
\docType{class}
\alias{RawAlleleBFractions}


 \title{The RawAlleleBFractions class}

 \description{
  Package:  aroma.core \cr
\bold{Class RawAlleleBFractions}\cr

\code{logical}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.oo]{BasicObject}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{RawAlleleBFractions}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{RawMirroredAlleleBFractions}, \link[aroma.core]{SegmentedAlleleBFractions}\cr

public class \bold{RawAlleleBFractions}\cr
extends \link[aroma.core]{RawGenomicSignals}\cr


 }

 \usage{RawAlleleBFractions(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{RawGenomicSignals}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{extractRawMirroredAlleleBFractions} \tab  -\cr
 \tab \code{plot} \tab  -\cr
}


 \bold{Methods inherited from RawGenomicSignals}:\cr
-, *, +, addBy, addLocusFields, append, applyBinaryOperator, as.data.frame, assertOneChromosome, binnedSmoothing, clearCache, clone, divideBy, drawDensity, estimateStandardDeviation, extractChromosome, extractChromosomes, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getChromosome, getChromosomes, getCXY, getLocusFields, getName, getPositions, getSigma, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, plot, points, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setLocusFields, setName, setSigma, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, summary, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from BasicObject}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, detach, equals, extend, getFields, getInstantiationTime, hasField, hashCode, isReferable, objectSize, print

 \bold{Methods inherited from logical}:\cr
as.data.frame, as.raster, whichVector


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
