%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RawMirroredAlleleBFractions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{RawMirroredAlleleBFractions}
\docType{class}
\alias{RawMirroredAlleleBFractions}


 \title{The RawMirroredAlleleBFractions class}

 \description{
  Package:  aroma.core \cr
\bold{Class RawMirroredAlleleBFractions}\cr

\code{logical}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.oo]{BasicObject}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[aroma.core]{RawAlleleBFractions}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{RawMirroredAlleleBFractions}\cr

\bold{Directly known subclasses:}\cr
\cr

public class \bold{RawMirroredAlleleBFractions}\cr
extends \link[aroma.core]{RawAlleleBFractions}\cr


 }

 \usage{RawMirroredAlleleBFractions(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{RawAlleleBFractions}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{plot} \tab  -\cr
}


 \bold{Methods inherited from RawAlleleBFractions}:\cr
extractRawMirroredAlleleBFractions, plot

 \bold{Methods inherited from RawGenomicSignals}:\cr
-, *, +, addBy, addLocusFields, append, applyBinaryOperator, as.data.frame, assertOneChromosome, binnedSmoothing, clearCache, clone, divideBy, drawDensity, estimateStandardDeviation, extractChromosome, extractChromosomes, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getChromosome, getChromosomes, getCXY, getLocusFields, getName, getPositions, getSigma, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, plot, points, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setLocusFields, setName, setSigma, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, summary, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from BasicObject}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, detach, equals, extend, getFields, getInstantiationTime, hasField, hashCode, isReferable, objectSize, print

 \bold{Methods inherited from logical}:\cr
as.data.frame, as.raster, whichVector


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
