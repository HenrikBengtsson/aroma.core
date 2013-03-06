%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HaarSegModel.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{HaarSegModel}
\docType{class}
\alias{HaarSegModel}


 \title{The HaarSegModel class}

 \description{
  Package:  aroma.core \cr
\bold{Class HaarSegModel}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{ChromosomalModel}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{CopyNumberChromosomalModel}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[aroma.core]{CopyNumberSegmentationModel}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{HaarSegModel}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{HaarSegModel}\cr
extends \emph{\link[aroma.core]{CopyNumberSegmentationModel}}\cr



  This class represents the Haar wavelet-based segmentation (HaarSeg)
  model [1].
 }

 \usage{
HaarSegModel(cesTuple=NULL, ..., breaksFdrQ=1e-04)
}

 \arguments{
   \item{cesTuple}{A \code{\link{CopyNumberDataSetTuple}}.}
   \item{breaksFdrQ}{Default tuning parameters specific to the HaarSeg
         algorithm.}
   \item{...}{Arguments passed to the constructor of
              \code{\link{CopyNumberSegmentationModel}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\emph{No methods defined}.


 \bold{Methods inherited from CopyNumberSegmentationModel}:\cr
fit, getAsteriskTags, getFitFunction, getFullNames, getRegions, getTags, plot, plotCopyNumberRegionLayers, writeRegions

 \bold{Methods inherited from CopyNumberChromosomalModel}:\cr
as.character, calculateChromosomeStatistics, calculateRatios, estimateSds, extractRawCopyNumbers, fit, getChromosomeLength, getDataFileMatrix, getMaxNAFraction, getNames, getOptionalArguments, getPairedNames, getReference, getReferenceSetTuple, getRefSetTuple, isPaired, newPlot, plotAxesLayers, plotChromosomesLayers, plotCytobandLayers, plotFitLayers, plotGridHorizontalLayers, plotRawCopyNumbers, plotSampleLayers, setReference

 \bold{Methods inherited from ChromosomalModel}:\cr
as.character, fit, getAlias, getAromaGenomeTextFile, getAsteriskTags, getChipType, getChipTypes, getChromosomes, getFullName, getFullNames, getGenome, getGenomeData, getGenomeFile, getListOfAromaUgpFiles, getName, getNames, getParentPath, getPath, getReportPath, getRootPath, getSets, getSetTuple, getTags, indexOf, nbrOfArrays, nbrOfChipTypes, setGenome

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save, asThis


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
  \code{\link{CopyNumberSegmentationModel}}.
 }

 \references{
   [1] Ben-Yaacov E. and Eldar YC. \emph{A fast and flexible method for the segmentation of aCGH data}, Bioinformatics, 2008.
   \url{http://www.ee.technion.ac.il/Sites/People/YoninaEldar/Info/software/HaarSeg.htm}
 }
\keyword{classes}
