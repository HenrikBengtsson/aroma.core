%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileCacheKeyInterface.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{FileCacheKeyInterface}
\docType{class}
\alias{FileCacheKeyInterface}


 \title{The FileCacheKeyInterface class interface}

 \description{
  Package:  aroma.core \cr
\bold{Class FileCacheKeyInterface}\cr

\code{\link[R.oo]{Interface}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{CacheKeyInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{FileCacheKeyInterface}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaCellCpgFile}, \link[aroma.core]{AromaCellPositionFile}, \link[aroma.core]{AromaCellSequenceFile}, \emph{\link[aroma.core]{AromaCellTabularBinaryFile}}, \emph{\link[aroma.core]{AromaGenomeTextFile}}, \emph{\link[aroma.core]{AromaMicroarrayDataFile}}, \emph{\link[aroma.core]{AromaMicroarrayTabularBinaryFile}}, \emph{\link[aroma.core]{AromaTabularBinaryFile}}, \emph{\link[aroma.core]{AromaUcscGenomeTextFile}}, \link[aroma.core]{AromaUflFile}, \link[aroma.core]{AromaUgcFile}, \link[aroma.core]{AromaUgpFile}, \link[aroma.core]{AromaUnitCallFile}, \emph{\link[aroma.core]{AromaUnitChromosomeTabularBinaryFile}}, \link[aroma.core]{AromaUnitFracBCnBinaryFile}, \link[aroma.core]{AromaUnitGcContentFile}, \link[aroma.core]{AromaUnitGenotypeCallFile}, \emph{\link[aroma.core]{AromaUnitPscnBinaryFile}}, \link[aroma.core]{AromaUnitSignalBinaryFile}, \emph{\link[aroma.core]{AromaUnitTabularBinaryFile}}, \emph{\link[aroma.core]{AromaUnitTotalCnBinaryFile}}, \link[aroma.core]{AromaUnitTypesFile}, \emph{\link[aroma.core]{CbsSegmentationDataFile}}, \emph{\link[aroma.core]{SampleAnnotationFile}}, \emph{\link[aroma.core]{SegmentationDataFile}}, \link[aroma.core]{TextUnitNamesFile}\cr

public class \bold{FileCacheKeyInterface}\cr
extends \link[aroma.core]{CacheKeyInterface}\cr


 }

 \usage{
FileCacheKeyInterface(...)
}

 \arguments{
   \item{...}{Not used.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[aroma.core:getCacheKey.FileCacheKeyInterface]{getCacheKey}} \tab Gets a list of cache key items.\cr
}


 \bold{Methods inherited from CacheKeyInterface}:\cr
getCacheKey

 \bold{Methods inherited from Interface}:\cr
extend, print, uses


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}


\keyword{classes}
\keyword{internal}
