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
 \tab \code{getFullName} \tab  -\cr
 \tab \code{getInputDataSet} \tab  -\cr
 \tab \code{getName} \tab  -\cr
 \tab \code{getOutputDataSet} \tab  -\cr
 \tab \code{getPath} \tab  -\cr
 \tab \code{getRootPath} \tab  -\cr
 \tab \code{getTags} \tab  -\cr
 \tab \code{isDone} \tab  -\cr
 \tab \code{process} \tab  -\cr
 \tab \code{setTags} \tab  -\cr
}


 \bold{Methods inherited from ParametersInterface}:\cr
getParameterSets, getParameters, getParametersAsString

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis


}

\details{
  Subclasses must implement the \code{process()} method.
}

\author{Henrik Bengtsson}
\keyword{classes}
