%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  CopyNumberChromosomalModel.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{CopyNumberChromosomalModel}
\docType{class}
\alias{CopyNumberChromosomalModel}


\title{The CopyNumberChromosomalModel class}

\description{
 Package:  aroma.core \cr
\bold{Class CopyNumberChromosomalModel}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{ChromosomalModel}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\emph{\code{CopyNumberChromosomalModel}}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{CbsModel}, \emph{\link[aroma.core]{CopyNumberSegmentationModel}}, \link[aroma.core]{GladModel}, \link[aroma.core]{HaarSegModel}, \emph{\link[aroma.core]{RawCopyNumberModel}}\cr

public abstract static class \bold{CopyNumberChromosomalModel}\cr
extends \emph{\link[aroma.core]{ChromosomalModel}}\cr



 This \emph{abstract} class represents a copy-number model.
}

\usage{
CopyNumberChromosomalModel(cesTuple=NULL, refTuple=NULL, calculateRatios=TRUE, tags="*",
  genome="Human", chromosomes=NULL, maxNAFraction=1/5, ...)
}

\arguments{
  \item{cesTuple}{A \code{\link{CopyNumberDataSetTuple}}.}
  \item{refTuple}{An optional \code{\link{CopyNumberDataFile}},
     or \code{\link{CopyNumberDataSet}} or \code{\link{CopyNumberDataSetTuple}}
     for pairwise comparisons.}
  \item{calculateRatios}{A \code{\link[base]{logical}} specifying whether ratios should
     be calculated relative to the reference.
     If \code{\link[base:logical]{FALSE}}, argument \code{refTuple} is ignored.
  }
  \item{tags}{A \code{\link[base]{character}} \code{\link[base]{vector}} of tags.}
  \item{genome}{A \code{\link[base]{character}} string specifying what genome is process.}
  \item{chromosomes}{(optional) A \code{\link[base]{vector}} specifying which chromosomes
   to process.}
  \item{maxNAFraction}{A \code{\link[base]{double}} in [0,1] indicating how many non-finite
    signals are allowed in the sanity checks of the data.}
  \item{...}{Optional arguments that may be used by some of the
     subclass models.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{extractRawCopyNumbers} \tab  -\cr
 \tab \code{fit} \tab  -\cr
 \tab \code{getChromosomeLength} \tab  -\cr
 \tab \code{getNames} \tab  -\cr
 \tab \code{getReference} \tab  -\cr
 \tab \code{isPaired} \tab  -\cr
}


 \bold{Methods inherited from ChromosomalModel}:\cr
as.character, fit, getAlias, getAromaGenomeTextFile, getAsteriskTags, getChipType, getChipTypes, getChromosomes, getFullName, getFullNames, getGenome, getGenomeData, getGenomeFile, getListOfAromaUgpFiles, getName, getNames, getParentPath, getPath, getReportPath, getRootPath, getSetTuple, getSets, getTags, indexOf, nbrOfArrays, nbrOfChipTypes, setChromosomes, setGenome

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis


}

\section{Requirements}{
  This class requires genome information annotation files for
  every chip type.
}

\author{Henrik Bengtsson}
\keyword{classes}
