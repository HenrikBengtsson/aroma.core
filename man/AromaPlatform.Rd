%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaPlatform.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{AromaPlatform}
\docType{class}
\alias{AromaPlatform}


\title{The AromaPlatform class}

\description{
 Package:  aroma.core \cr
\bold{Class AromaPlatform}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{AromaPlatform}}\cr

\bold{Directly known subclasses:}\cr
\cr

public abstract static class \bold{AromaPlatform}\cr
extends \link[R.oo]{Object}\cr



 An AromaPlatform provides methods for a given platform, e.g.
 Affymetrix, Agilent, Illumina.
}

\usage{
AromaPlatform(...)
}

\arguments{
  \item{...}{Not used.}
}

\examples{\dontrun{
 library("aroma.affymetrix")
platform <- AromaPlatform$byName("Affymetrix")
print(platform)
stopifnot(getName(platform) == "Affymetrix")

}}

\section{Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{byName} \tab  -\cr
 \tab \code{equals} \tab  -\cr
 \tab \code{getAromaUgpFile} \tab  -\cr
 \tab \code{getName} \tab  -\cr
 \tab \code{getUnitNamesFile} \tab  -\cr
 \tab \code{getUnitTypesFile} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis


}

\author{Henrik Bengtsson}
\keyword{classes}
