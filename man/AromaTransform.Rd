%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaTransform.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaTransform}
\docType{class}
\alias{AromaTransform}


 \title{The AromaTransform class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaTransform}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{ParametersInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\emph{\code{AromaTransform}}\cr

\bold{Directly known subclasses:}\cr
\cr

public abstract static class \bold{AromaTransform}\cr
extends \link[aroma.core]{ParametersInterface}\cr



  This abstract class represents a transform (algorithm/operator) that
  transforms data.  A transform has an input data set, which is
  transformed into an output data set.
 }

 \usage{
AromaTransform(dataSet=NULL, tags="*", ..., .reqSetClass="AromaMicroarrayDataSet")
}

 \arguments{
   \item{dataSet}{The input data set as an \code{\link{AromaMicroarrayDataSet}}.}
   \item{tags}{A \code{\link[base]{character}} \code{\link[base]{vector}} of tags to be appended to the tags of
      the input data set.}
   \item{...}{Not used.}
   \item{.reqSetClass}{Internal argument.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[aroma.core:getFullName.AromaTransform]{getFullName}} \tab Gets the full name of the output data set.\cr
 \tab \code{\link[aroma.core:getInputDataSet.AromaTransform]{getInputDataSet}} \tab Gets the input data set.\cr
 \tab \code{\link[aroma.core:getName.AromaTransform]{getName}} \tab Gets the name of the output data set.\cr
 \tab \code{\link[aroma.core:getOutputDataSet.AromaTransform]{getOutputDataSet}} \tab Gets the transformed data set.\cr
 \tab \code{\link[aroma.core:getPath.AromaTransform]{getPath}} \tab Gets the path of the output directory.\cr
 \tab \code{\link[aroma.core:getRootPath.AromaTransform]{getRootPath}} \tab Gets the root path of the output directory.\cr
 \tab \code{\link[aroma.core:getTags.AromaTransform]{getTags}} \tab Gets the tags of the output data set.\cr
 \tab \code{\link[aroma.core:isDone.AromaTransform]{isDone}} \tab Checks if the data set is processed or not.\cr
 \tab \code{\link[aroma.core:process.AromaTransform]{process}} \tab Processes the data set.\cr
 \tab \code{setTags} \tab  -\cr
}


 \bold{Methods inherited from ParametersInterface}:\cr
getParameterSets, getParameters, getParametersAsString

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save, asThis


 }

 \details{
   Subclasses must implement the \code{process()} method.
 }

 \author{Henrik Bengtsson}
\keyword{classes}
