%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  CbsModel.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{CbsModel}
\docType{class}
\alias{CbsModel}


 \title{The CbsModel class}

 \description{
  Package:  aroma.core \cr
\bold{Class CbsModel}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{ChromosomalModel}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{CopyNumberChromosomalModel}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[aroma.core]{CopyNumberSegmentationModel}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{CbsModel}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{CbsModel}\cr
extends \emph{\link[aroma.core]{CopyNumberSegmentationModel}}\cr



  This class represents the Circular Binary Segmentation (CBS) model [1].
 }

 \usage{CbsModel(cesTuple=NULL, ...)}

 \arguments{
   \item{cesTuple}{A \code{\link{CopyNumberDataSetTuple}}.}
   \item{...}{Arguments passed to the constructor of
              \code{\link{CopyNumberSegmentationModel}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getFitFunction} \tab  -\cr
}


 \bold{Methods inherited from CopyNumberSegmentationModel}:\cr
fit, getAsteriskTags, getFitFunction, getFullNames, getRegions, getTags, plot, plotCopyNumberRegionLayers, writeRegions

 \bold{Methods inherited from CopyNumberChromosomalModel}:\cr
as.character, calculateChromosomeStatistics, calculateRatios, clearCache, estimateSds, extractRawCopyNumbers, fit, getDataFileMatrix, getNames, getPairedNames, getReferenceSetTuple, getRefSetTuple, isPaired, newPlot, plotAxesLayers, plotChromosomesLayers, plotCytobandLayers, plotFitLayers, plotGridHorizontalLayers, plotRawCopyNumbers, plotSampleLayers

 \bold{Methods inherited from ChromosomalModel}:\cr
as.character, clearCache, fit, getAlias, getAsteriskTags, getChipType, getChipTypes, getChromosomes, getFullName, getFullNames, getGenome, getGenomeData, getGenomeFile, getListOfAromaUgpFiles, getName, getNames, getParentPath, getPath, getReportPath, getRootPath, getSets, getSetTuple, getTags, indexOf, nbrOfArrays, nbrOfChipTypes, setAlias, setGenome

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
  \code{\link{CopyNumberSegmentationModel}}.
 }

 \references{
  [1] Olshen, A. B., Venkatraman, E. S., Lucito, R., Wigler, M.
      \emph{Circular binary segmentation for the analysis of array-based
      DNA copy number data. Biostatistics 5: 557-572, 2004.}\cr
  [2] Venkatraman, E. S. & Olshen, A. B.
      \emph{A faster circular binary segmentation algorithm for the
      analysis of array CGH data}. Bioinformatics, 2007.\cr
 }
\keyword{classes}
