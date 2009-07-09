%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaMicroarrayDataSetTuple.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaMicroarrayDataSetTuple}
\docType{class}
\alias{AromaMicroarrayDataSetTuple}


 \title{The AromaMicroarrayDataSetTuple class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaMicroarrayDataSetTuple}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{AromaMicroarrayDataSetTuple}}\cr

\bold{Directly known subclasses:}\cr
\cr

public abstract static class \bold{AromaMicroarrayDataSetTuple}\cr
extends \link[R.oo]{Object}\cr


 }

 \usage{AromaMicroarrayDataSetTuple(csList=NULL, tags="*", ..., .setClass="AromaMicroarrayDataSet")}

 \arguments{
   \item{csList}{A single or \code{\link[base]{list}} of \code{\link{AromaMicroarrayDataSet}}:s.}
   \item{tags}{A \code{\link[base]{character}} \code{\link[base]{vector}} of tags.}
   \item{...}{Not used.}
   \item{.setClass}{The name of the class of the input set.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{byPath} \tab  -\cr
 \tab \code{\link[aroma.core:extract.AromaMicroarrayDataSetTuple]{extract}} \tab Extracts a subset AromaMicroarrayDataSetTuple.\cr
 \tab \code{getAlias} \tab  -\cr
 \tab \code{\link[aroma.core:getArrays.AromaMicroarrayDataSetTuple]{getArrays}} \tab Gets the names of the arrays.\cr
 \tab \code{\link[aroma.core:getArrayTuple.AromaMicroarrayDataSetTuple]{getArrayTuple}} \tab Gets arrays across chip types for one sample.\cr
 \tab \code{getChipTypes} \tab  -\cr
 \tab \code{getFullName} \tab  -\cr
 \tab \code{getFullNames} \tab  -\cr
 \tab \code{getListOfSets} \tab  -\cr
 \tab \code{getName} \tab  -\cr
 \tab \code{getNames} \tab  -\cr
 \tab \code{getTags} \tab  -\cr
 \tab \code{\link[aroma.core:nbrOfArrays.AromaMicroarrayDataSetTuple]{nbrOfArrays}} \tab Gets the number of arrays.\cr
 \tab \code{\link[aroma.core:nbrOfChipTypes.AromaMicroarrayDataSetTuple]{nbrOfChipTypes}} \tab Gets the number of chip types.\cr
 \tab \code{setAlias} \tab  -\cr
 \tab \code{setTags} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
