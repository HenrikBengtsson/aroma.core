%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  CopyNumberSegmentationModel.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{CopyNumberSegmentationModel}
\docType{class}
\alias{CopyNumberSegmentationModel}


 \title{The CopyNumberSegmentationModel class}

 \description{
  Package:  aroma.core \cr
\bold{Class CopyNumberSegmentationModel}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{ChromosomalModel}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{CopyNumberChromosomalModel}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\emph{\code{CopyNumberSegmentationModel}}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{CbsModel}, \link[aroma.core]{GladModel}, \link[aroma.core]{HaarSegModel}\cr

public abstract static class \bold{CopyNumberSegmentationModel}\cr
extends \emph{\link[aroma.core]{CopyNumberChromosomalModel}}\cr



  This \emph{abstract} class represents a copy-number segmentation model.
 }

 \usage{CopyNumberSegmentationModel(...)}

 \arguments{
   \item{...}{Arguments passed to constructor
      \code{\link{CopyNumberChromosomalModel}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[aroma.core:fit.CopyNumberSegmentationModel]{fit}} \tab Fits the model.\cr
 \tab \code{getRegions} \tab  -\cr
 \tab \code{getTags} \tab  -\cr
 \tab \code{writeRegions} \tab  -\cr
}


 \bold{Methods inherited from CopyNumberChromosomalModel}:\cr
as.character, calculateChromosomeStatistics, clearCache, estimateSds, extractRawCopyNumbers, fit, getDataFileMatrix, getRawCnData, getReferenceSetTuple, getRefSetTuple, isPaired

 \bold{Methods inherited from ChromosomalModel}:\cr
as.character, clearCache, fit, getAlias, getArrays, getAsteriskTags, getChipEffectFiles, getChipType, getChipTypes, getChromosomes, getFullName, getFullNames, getGenome, getGenomeData, getGenomeFile, getListOfAromaUgpFiles, getListOfChipEffectSets, getName, getNames, getParentPath, getPath, getReportPath, getRootPath, getSetTuple, getTableOfArrays, getTags, nbrOfArrays, nbrOfChipTypes, setAlias, setGenome

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}