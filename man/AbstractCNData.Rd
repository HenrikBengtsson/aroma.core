%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AbstractCNData.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AbstractCNData}
\docType{class}
\alias{AbstractCNData}


 \title{The AbstractCNData class}

 \description{
  Package:  aroma.core \cr
\bold{Class AbstractCNData}\cr

\code{data.frame}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RichDataFrame}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{AbstractCNData}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AbstractPSCNData}, \link[aroma.core]{NonPairedPSCNData}, \link[aroma.core]{PairedPSCNData}\cr

public class \bold{AbstractCNData}\cr
extends \link[aroma.core]{RawGenomicSignals}\cr



  An AbstractCNData object holds copy number data.
 }

 \usage{
AbstractCNData(chromosome=NULL, x=NULL, y=NULL, ..., name=NULL, .virtuals=NULL)
}

 \arguments{
   \item{chromosome}{(Optional) An \code{\link[base]{integer}} scalar (or a \code{\link[base]{vector}} of length J),
        which can be used to specify which chromosome each locus belongs to
        in case multiple chromosomes are segments.
        This argument is also used for annotation purposes.}
   \item{x}{Optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of J genomic locations.
            If \code{\link[base]{NULL}}, index locations \code{1:J} are used.}
   \item{y}{Optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of J genomic locations.}
   \item{...}{Optional named locus-specific signal \code{\link[base]{vector}}s of length J.}
   \item{name}{Optional \code{\link[base]{character}} string.}
   \item{.virtuals}{(Internal) a \code{\link[base]{list}} with virtual column name \code{\link[base]{function}}s.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{findLargeGaps} \tab  -\cr
 \tab \code{getChipType} \tab  -\cr
 \tab \code{getLocusData} \tab  -\cr
 \tab \code{getPlatform} \tab  -\cr
 \tab \code{setChipType} \tab  -\cr
 \tab \code{setPlatform} \tab  -\cr
}


 \bold{Methods inherited from RawGenomicSignals}:\cr
*, +, -, addBy, append, applyBinaryOperator, as.character, as.data.frame, assertOneChromosome, binnedSmoothing, binnedSmoothingByField, clearCache, clone, divideBy, drawDensity, estimateStandardDeviation, extractChromosome, extractChromosomes, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getBasicField, getCXY, getChromosome, getChromosomes, getDefaultLocusFields, getLocusFields, getPositions, getSigma, getSignalColumnName, getSignalColumnNames, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, plot, points, print, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setBasicField, setSigma, setSignals, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from RichDataFrame}:\cr
$, $<-, [, [[, [[<-, as.data.frame, as.list, dim, dropVirtualColumn, getColumnNames, getColumnNamesTranslator, getFullName, getName, getTags, getVirtualColumn, getVirtualColumnFunction, getVirtualColumnNames, hasColumn, hasColumns, hasVirtualColumn, hasVirtualColumns, length, names, newInstance, print, rbind, setAttributes, setColumnNamesMap, setColumnNamesTranslator, setName, setTags, setVirtualColumn, subset, translateColumnNames

 \bold{Methods inherited from data.frame}:\cr
$<-, Math, Ops, Summary, [, [<-, [[, [[<-, aggregate, anyDuplicated, as.NonPairedPSCNData, as.PairedPSCNData, as.data.frame, as.list, as.matrix, attachLocally, by, cbind, dim, dimnames, dimnames<-, droplevels, duplicated, edit, format, formula, head, is.na, merge, na.exclude, na.omit, plot, print, prompt, rbind, row.names, row.names<-, rowsum, split, split<-, stack, str, subset, summary, t, tail, transform, unique, unstack, unwrap, within, wrap, writeDataFrame


 }

 \author{Henrik Bengtsson}
\keyword{classes}
