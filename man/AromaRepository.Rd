%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaRepository.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaRepository}
\docType{class}
\alias{AromaRepository}


 \title{The AromaRepository class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaRepository}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{AromaRepository}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{AromaRepository}\cr
extends \link[R.oo]{Object}\cr



  An AromaRepository object provides methods for downloading annotation data
  from the Aroma repository.
 }

 \usage{AromaRepository(urlPath="http://www.aroma-project.org/data", verbose=FALSE, ...)}

 \arguments{
   \item{urlPath}{The URL to the Aroma reposity.}
   \item{verbose}{The \code{\link[R.utils]{Verbose}} to be used during processing.}
   \item{...}{Not used.}
 }

 \section{Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{downloadACC} \tab  -\cr
 \tab \code{downloadACM} \tab  -\cr
 \tab \code{downloadACP} \tab  -\cr
 \tab \code{downloadACS} \tab  -\cr
 \tab \code{downloadAll} \tab  -\cr
 \tab \code{downloadCDF} \tab  -\cr
 \tab \code{\link[aroma.core:downloadChipTypeFile.AromaRepository]{downloadChipTypeFile}} \tab Download a particular chip type annotation file.\cr
 \tab \code{downloadProbeSeqsTXT} \tab  -\cr
 \tab \code{downloadTXT} \tab  -\cr
 \tab \code{downloadUFL} \tab  -\cr
 \tab \code{downloadUGC} \tab  -\cr
 \tab \code{downloadUGP} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
asThis, getChecksum, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
