%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AbstractPSCNData.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AbstractPSCNData}
\docType{class}
\alias{AbstractPSCNData}


 \title{The AbstractPSCNData class}

 \description{
  Package:  aroma.core \cr
\bold{Class AbstractPSCNData}\cr

\code{data.frame}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RichDataFrame}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[aroma.core]{AbstractCNData}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{AbstractPSCNData}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{NonPairedPSCNData}, \link[aroma.core]{PairedPSCNData}\cr

public class \bold{AbstractPSCNData}\cr
extends \link[aroma.core]{AbstractCNData}\cr



  A AbstractPSCNData object holds parent-specific copy number data.
 }

 \usage{
AbstractPSCNData(chromosome=NULL, x=NULL, isSNP=NULL, mu=NULL, ...)
}

 \arguments{
   \item{chromosome}{(Optional) An \code{\link[base]{integer}} scalar (or a \code{\link[base]{vector}} of length J),
        which can be used to specify which chromosome each locus belongs to
        in case multiple chromosomes are segments.
        This argument is also used for annotation purposes.}
   \item{x}{Optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of J genomic locations.
            If \code{\link[base]{NULL}}, index locations \code{1:J} are used.}
   \item{isSNP}{An optional \code{\link[base]{logical}} \code{\link[base]{vector}} of length J specifying
        whether each locus is a SNP or not (non-polymorphic loci).}
   \item{mu}{An optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of J genotype calls in
        \{0,1/2,1\} for AA, AB, and BB, respectively,
        and \code{\link[base]{NA}} for non-polymorphic loci.}
   \item{...}{Optional named locus-specific signal \code{\link[base]{vector}}s of length J.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\emph{No methods defined}.


 \bold{Methods inherited from AbstractCNData}:\cr
findLargeGaps, getChipType, getLocusData, getPlatform, hasKnownPositions, orderAlongGenome, setChipType, setPlatform

 \bold{Methods inherited from RawGenomicSignals}:\cr
*, +, -, addBy, append, applyBinaryOperator, as.character, as.data.frame, assertOneChromosome, binnedSmoothing, binnedSmoothingByField, clearCache, clone, divideBy, drawDensity, estimateStandardDeviation, extractChromosome, extractChromosomes, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getBasicField, getCXY, getChromosome, getChromosomes, getDefaultLocusFields, getLocusFields, getPositions, getSigma, getSignalColumnName, getSignalColumnNames, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, plot, points, print, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setBasicField, setSigma, setSignals, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from RichDataFrame}:\cr
$, $<-, [, [[, [[<-, as.data.frame, as.list, dim, dropVirtualColumn, getColumnNames, getColumnNamesTranslator, getFullName, getName, getTags, getVirtualColumn, getVirtualColumnFunction, getVirtualColumnNames, hasColumn, hasColumns, hasVirtualColumn, hasVirtualColumns, length, names, newInstance, print, rbind, setAttributes, setColumnNamesMap, setColumnNamesTranslator, setName, setTags, setVirtualColumn, subset, translateColumnNames

 \bold{Methods inherited from data.frame}:\cr
$<-,data.frame-method, $<-, Math, Ops,nonStructure,vector-method, Ops,structure,vector-method, Ops,vector,nonStructure-method, Ops,vector,structure-method, Ops, Summary, [, [<-,data.frame-method, [<-, [[, [[<-,data.frame-method, [[<-, aggregate, anyDuplicated, as.NonPairedPSCNData, as.PairedPSCNData, as.data.frame, as.list, as.matrix, attachLocally, by, callSegmentationOutliers, cbind, coerce,ANY,list-method, coerce,oldClass,S3-method, dim, dimnames, dimnames<-, dropSegmentationOutliers, droplevels, duplicated, edit, findLargeGaps, format, formula, head, initialize,oldClass-method, is.na, merge, na.exclude, na.omit, plot, print, prompt, rbind, row.names, row.names<-, rowsum, segmentByCBS, segmentByPairedPSCBS, show,oldClass-method, slotsFromS3,data.frame-method, split, split<-, stack, str, subset, summary, t, tail, transform, type.convert, unique, unstack, unwrap, within, wrap, writeDataFrame


 }

 \author{Henrik Bengtsson}
\keyword{classes}
