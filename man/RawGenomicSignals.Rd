%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RawGenomicSignals.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{RawGenomicSignals}
\docType{class}
\alias{RawGenomicSignals}


 \title{The RawGenomicSignals class}

 \description{
  Package:  aroma.core \cr
\bold{Class RawGenomicSignals}\cr

\code{data.frame}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RichDataFrame}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{RawGenomicSignals}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AbstractCNData}, \link[aroma.core]{AbstractPSCNData}, \link[aroma.core]{NonPairedPSCNData}, \link[aroma.core]{PairedPSCNData}, \link[aroma.core]{RawAlleleBFractions}, \link[aroma.core]{RawCopyNumbers}, \link[aroma.core]{RawMirroredAlleleBFractions}, \link[aroma.core]{RawSequenceReads}, \link[aroma.core]{SegmentedAlleleBFractions}, \link[aroma.core]{SegmentedCopyNumbers}\cr

public class \bold{RawGenomicSignals}\cr
extends \link[aroma.core]{RichDataFrame}\cr


 }

 \usage{RawGenomicSignals(y=NULL, x=NULL, w=NULL, chromosome=0, name=NULL, ...)}

 \arguments{
   \item{y}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of length J specifying the signal
     at each locus.}
   \item{x}{A (optional) \code{\link[base]{numeric}} \code{\link[base]{vector}} of length J specifying the
     position of each locus.}
   \item{w}{A (optional) non-negative \code{\link[base]{numeric}} \code{\link[base]{vector}} of length J
     specifying a weight of each locus.}
   \item{chromosome}{An (optional) \code{\link[base]{integer}} specifying the chromosome for
     these genomic signals.}
   \item{name}{An (optional) \code{\link[base]{character}} string specifying the sample name.}
   \item{...}{Not used.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{-} \tab  -\cr
 \tab \code{*} \tab  -\cr
 \tab \code{+} \tab  -\cr
 \tab \code{addBy} \tab  -\cr
 \tab \code{append} \tab  -\cr
 \tab \code{as.data.frame} \tab  -\cr
 \tab \code{binnedSmoothing} \tab  -\cr
 \tab \code{divideBy} \tab  -\cr
 \tab \code{drawDensity} \tab  -\cr
 \tab \code{\link[aroma.core:estimateStandardDeviation.RawGenomicSignals]{estimateStandardDeviation}} \tab Estimates the standard deviation of the raw Ys.\cr
 \tab \code{gaussianSmoothing} \tab  -\cr
 \tab \code{getChromosome} \tab  -\cr
 \tab \code{getChromosomes} \tab  -\cr
 \tab \code{getPositions} \tab  -\cr
 \tab \code{getSigma} \tab  -\cr
 \tab \code{getSignals} \tab  -\cr
 \tab \code{getWeights} \tab  -\cr
 \tab \code{getXScale} \tab  -\cr
 \tab \code{getYScale} \tab  -\cr
 \tab \code{hasWeights} \tab  -\cr
 \tab \code{kernelSmoothing} \tab  -\cr
 \tab \code{lines} \tab  -\cr
 \tab \code{multiplyBy} \tab  -\cr
 \tab \code{nbrOfChromosomes} \tab  -\cr
 \tab \code{nbrOfLoci} \tab  -\cr
 \tab \code{plot} \tab  -\cr
 \tab \code{points} \tab  -\cr
 \tab \code{\link[aroma.core:segmentByCBS.RawGenomicSignals]{segmentByCBS}} \tab Segment copy numbers using the CBS method.\cr
 \tab \code{\link[aroma.core:segmentByGLAD.RawGenomicSignals]{segmentByGLAD}} \tab Segment copy numbers using the GLAD method.\cr
 \tab \code{\link[aroma.core:segmentByHaarSeg.RawGenomicSignals]{segmentByHaarSeg}} \tab Segment copy numbers using the HaarSeg method.\cr
 \tab \code{\link[aroma.core:segmentByMPCBS.RawGenomicSignals]{segmentByMPCBS}} \tab Segment copy numbers using the multi-platform CBS (mpCBS) method.\cr
 \tab \code{setSigma} \tab  -\cr
 \tab \code{setSignals} \tab  -\cr
 \tab \code{setWeights} \tab  -\cr
 \tab \code{setXScale} \tab  -\cr
 \tab \code{setYScale} \tab  -\cr
 \tab \code{signalRange} \tab  -\cr
 \tab \code{sort} \tab  -\cr
 \tab \code{subtractBy} \tab  -\cr
 \tab \code{xMax} \tab  -\cr
 \tab \code{xMin} \tab  -\cr
 \tab \code{xRange} \tab  -\cr
 \tab \code{xSeq} \tab  -\cr
 \tab \code{yMax} \tab  -\cr
 \tab \code{yMin} \tab  -\cr
 \tab \code{yRange} \tab  -\cr
}


 \bold{Methods inherited from RichDataFrame}:\cr
$, $<-, [, [[, [[<-, as.data.frame, as.list, dim, dropVirtualColumn, getColumnNames, getColumnNamesTranslator, getFullName, getName, getTags, getVirtualColumn, getVirtualColumnFunction, getVirtualColumnNames, hasColumn, hasColumns, hasVirtualColumn, hasVirtualColumns, length, names, newInstance, print, rbind, setAttributes, setColumnNamesMap, setColumnNamesTranslator, setName, setTags, setVirtualColumn, subset, translateColumnNames

 \bold{Methods inherited from data.frame}:\cr
$<-, [, [[, [[<-, [<-, aggregate, anyDuplicated, as.data.frame, as.list, as.matrix, as.NonPairedPSCNData, as.PairedPSCNData, attachLocally, by, cbind, dim, dimnames, dimnames<-, droplevels, duplicated, edit, format, formula, head, is.na, Math, mean, merge, na.exclude, na.omit, Ops, plot, plotDensity, print, prompt, rbind, row.names, row.names<-, rowsum, split, split<-, stack, str, subset, summary, Summary, t, tail, transform, unique, unstack, unwrap, within, wrap, writeDataFrame


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
