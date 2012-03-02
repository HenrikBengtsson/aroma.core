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

\code{data.frame}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawAlleleBFractions}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{RawMirroredAlleleBFractions}\cr

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
-, *, +, addBy, addLocusFields, append, applyBinaryOperator, as.data.frame, assertOneChromosome, binnedSmoothing, clearCache, clone, divideBy, drawDensity, estimateStandardDeviation, extractChromosome, extractChromosomes, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getBasicField, getChromosome, getChromosomes, getCXY, getDefaultLocusFields, getLocusFields, getName, getPositions, getSigma, getSignals, getVirtualLocusFields, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, newInstance, plot, points, print, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setBasicField, setLocusFields, setName, setSigma, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, summary, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from data.frame}:\cr
$<-, [, [[, [[<-, [<-, aggregate, anyDuplicated, as.data.frame, as.list, as.matrix, as.profileCGH, attachLocally, by, cbind, dim, dimnames, dimnames<-, droplevels, duplicated, edit, format, formula, head, is.na, Math, mean, merge, na.exclude, na.omit, Ops, plot, plotDensity, print, prompt, rbind, row.names, row.names<-, rowsum, split, split<-, stack, str, subset, summary, Summary, t, tail, transform, unique, unstack, unwrap, within, wrap, writeDataFrame


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
