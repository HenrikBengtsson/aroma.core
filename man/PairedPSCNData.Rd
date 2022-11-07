%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  PairedPSCNData.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{PairedPSCNData}
\docType{class}
\alias{PairedPSCNData}


\title{The PairedPSCNData class}

\description{
 Package:  aroma.core \cr
\bold{Class PairedPSCNData}\cr

\code{data.frame}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{RichDataFrame}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{RawGenomicSignals}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[aroma.core]{AbstractCNData}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AbstractPSCNData}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\code{PairedPSCNData}\cr

\bold{Directly known subclasses:}\cr
\cr

public class \bold{PairedPSCNData}\cr
extends \link[aroma.core]{AbstractPSCNData}\cr



 A PairedPSCNData object holds paired tumor-normal parent-specific
 copy number data.
}

\usage{
PairedPSCNData(chromosome=NULL, x=NULL, isSNP=NULL, muN=NULL, CT=NULL, betaT=NULL,
  CN=NULL, betaN=NULL, ...)
}

\arguments{
  \item{CT}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of J tumor total copy number (TCN)
       ratios in [0,+\code{\link[base:is.finite]{Inf}}) (due to noise, small negative values are
       also allowed).  The TCN ratios are typically scaled such that
       copy-neutral diploid loci have a mean of two.}
  \item{CN}{An optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of J normal TCN ratios.}
  \item{betaT}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of J tumor allele B fractions (BAFs)
       in [0,1] (due to noise, values may be slightly outside as well)
       or \code{\link[base]{NA}} for non-polymorphic loci.}
  \item{betaN}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of J matched normal BAFs in [0,1]
       (due to noise, values may be slightly outside as well) or \code{\link[base]{NA}}
       for non-polymorphic loci.}
  \item{muN}{An optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of J genotype calls in
       \{0,1/2,1\} for AA, AB, and BB, respectively,
       and \code{\link[base]{NA}} for non-polymorphic loci.
       If not given, they are estimated from the normal BAFs using
       \code{\link[aroma.light]{callNaiveGenotypes}} as described in [2].}
  \item{isSNP}{An optional \code{\link[base]{logical}} \code{\link[base]{vector}} of length J specifying
       whether each locus is a SNP or not (non-polymorphic loci).}
  \item{chromosome}{(Optional) An \code{\link[base]{integer}} scalar (or a \code{\link[base]{vector}} of length J),
       which can be used to specify which chromosome each locus belongs to
       in case multiple chromosomes are segments.
       This argument is also used for annotation purposes.}
  \item{x}{Optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of J genomic locations.
           If \code{\link[base]{NULL}}, index locations \code{1:J} are used.}
  \item{...}{Optional named locus-specific signal \code{\link[base]{vector}}s of length J.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as} \tab  -\cr
 \tab \code{as.PairedPSCNData} \tab  -\cr
 \tab \code{callNaiveGenotypes} \tab  -\cr
 \tab \code{callSegmentationOutliers} \tab  -\cr
 \tab \code{dropSegmentationOutliers} \tab  -\cr
 \tab \code{getSignalColumnNames} \tab  -\cr
 \tab \code{getTCNs} \tab  -\cr
 \tab \code{getTotalCopyNumbers} \tab  -\cr
 \tab \code{normalizeTumorBoost} \tab  -\cr
 \tab \code{plotTracks} \tab  -\cr
 \tab \code{segmentByCBS} \tab  -\cr
 \tab \code{segmentByPairedPSCBS} \tab  -\cr
}


 \bold{Methods inherited from AbstractPSCNData}:\cr
callSNPs, getSNPFields

 \bold{Methods inherited from AbstractCNData}:\cr
findLargeGaps, getChipType, getLocusData, getPlatform, hasKnownPositions, orderAlongGenome, setChipType, setPlatform

 \bold{Methods inherited from RawGenomicSignals}:\cr
*, +, -, addBy, append, applyBinaryOperator, as.character, as.data.frame, assertOneChromosome, binnedSmoothing, binnedSmoothingByField, clearCache, clone, divideBy, drawDensity, estimateStandardDeviation, extractChromosome, extractChromosomes, extractDataForSegmentation, extractRegion, extractRegions, extractSubset, gaussianSmoothing, getBasicField, getCXY, getChromosome, getChromosomes, getDefaultLocusFields, getLocusFields, getPositions, getSigma, getSignalColumnName, getSignalColumnNames, getSignals, getWeights, getXScale, getXY, getYScale, hasWeights, kernelSmoothing, lines, multiplyBy, nbrOfChromosomes, nbrOfLoci, plot, points, print, segmentByCBS, segmentByGLAD, segmentByHaarSeg, segmentByMPCBS, setBasicField, setSigma, setSignals, setWeights, setXScale, setYScale, signalRange, sort, subtractBy, xMax, xMin, xRange, xSeq, yMax, yMin, yRange

 \bold{Methods inherited from RichDataFrame}:\cr
$, $<-, [, [[, [[<-, as.data.frame, as.list, dim, dropVirtualColumn, getColumnNames, getColumnNamesTranslator, getFullName, getName, getTags, getVirtualColumn, getVirtualColumnFunction, getVirtualColumnNames, hasColumn, hasColumns, hasVirtualColumn, hasVirtualColumns, length, names, newInstance, print, rbind, setAttributes, setColumnNamesMap, setColumnNamesTranslator, setName, setTags, setVirtualColumn, subset, translateColumnNames

 \bold{Methods inherited from data.frame}:\cr
$<-,data.frame-method, $<-, Math, Ops,nonStructure,vector-method, Ops,structure,vector-method, Ops,vector,nonStructure-method, Ops,vector,structure-method, Ops, Summary, [, [<-,data.frame-method, [<-, [[, [[<-,data.frame-method, [[<-, aggregate, anyDuplicated, anyNA, as.NonPairedPSCNData, as.PairedPSCNData, as.data.frame, as.list, as.matrix, as.profileCGH, as.vector, attachLocally, by, callSegmentationOutliers, cbind, coerce,ANY,list-method, coerce,oldClass,S3-method, dim, dimnames, dimnames<-, dropSegmentationOutliers, droplevels, duplicated, edit, findLargeGaps, format, formula, head, initialize,oldClass-method, is.na, merge, na.exclude, na.omit, plot, plotDensity, print, prompt, rbind, row.names, row.names<-, rowsum, segmentByCBS, segmentByPairedPSCBS, show,oldClass-method, slotsFromS3,data.frame-method, split, split<-, stack, str, subset, summary, t, tail, transform, type.convert, unique, unstack, unwrap, within, wrap, writeDataFrame, xtfrm


}

\author{Henrik Bengtsson}
\keyword{classes}
