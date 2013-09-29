%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  ChromosomalModel.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{ChromosomalModel}
\docType{class}
\alias{ChromosomalModel}


 \title{The ChromosomalModel class}

 \description{
  Package:  aroma.core \cr
\bold{Class ChromosomalModel}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{ChromosomalModel}}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{CbsModel}, \emph{\link[aroma.core]{CopyNumberChromosomalModel}}, \emph{\link[aroma.core]{CopyNumberSegmentationModel}}, \link[aroma.core]{GladModel}, \link[aroma.core]{HaarSegModel}, \emph{\link[aroma.core]{RawCopyNumberModel}}\cr

public abstract static class \bold{ChromosomalModel}\cr
extends \link[R.oo]{Object}\cr



  This \emph{abstract} class represents a chromosomal model.
 }

 \usage{
ChromosomalModel(cesTuple=NULL, tags="*", genome="Human", ...)
}

 \arguments{
   \item{cesTuple}{A \code{\link{AromaMicroarrayDataSetTuple}}.}
   \item{tags}{A \code{\link[base]{character}} \code{\link[base]{vector}} of tags.}
   \item{genome}{A \code{\link[base]{character}} string specifying what genome is process.}
   \item{...}{Not used.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{fit} \tab  -\cr
 \tab \code{\link[aroma.core:getChipType.ChromosomalModel]{getChipType}} \tab Gets a label for all chip types merged.\cr
 \tab \code{getChipTypes} \tab  -\cr
 \tab \code{\link[aroma.core:getChromosomes.ChromosomalModel]{getChromosomes}} \tab Gets the chromosomes available.\cr
 \tab \code{getFullName} \tab  -\cr
 \tab \code{getFullNames} \tab  -\cr
 \tab \code{getGenome} \tab  -\cr
 \tab \code{getName} \tab  -\cr
 \tab \code{\link[aroma.core:getNames.ChromosomalModel]{getNames}} \tab Gets the names of the arrays.\cr
 \tab \code{getPath} \tab  -\cr
 \tab \code{getSets} \tab  -\cr
 \tab \code{getTags} \tab  -\cr
 \tab \code{indexOf} \tab  -\cr
 \tab \code{\link[aroma.core:nbrOfArrays.ChromosomalModel]{nbrOfArrays}} \tab Gets the number of arrays.\cr
 \tab \code{\link[aroma.core:nbrOfChipTypes.ChromosomalModel]{nbrOfChipTypes}} \tab Gets the number of chip types.\cr
 \tab \code{setGenome} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save, asThis


 }

 \section{Requirements}{
   This class requires genome information annotation files for
   every chip type.
 }

 \author{Henrik Bengtsson}
\keyword{classes}
