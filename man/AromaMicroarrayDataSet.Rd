%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaMicroarrayDataSet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaMicroarrayDataSet}
\docType{class}
\alias{AromaMicroarrayDataSet}


 \title{The AromaMicroarrayDataSet class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaMicroarrayDataSet}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{FullNameInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericDataFileSet}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{AromaMicroarrayDataSet}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{AromaMicroarrayDataSet}\cr
extends \link[R.filesets]{GenericDataFileSet}\cr



  An AromaMicroarrayDataSet object represents a set of
  \code{\link{AromaMicroarrayDataFile}}s with \emph{identical} chip types.
 }

 \usage{AromaMicroarrayDataSet(files=NULL, ...)}

 \arguments{
   \item{files}{A \code{\link[base]{list}} of \code{\link{AromaMicroarrayDataFile}}:s.}
   \item{...}{Arguments passed to \code{\link[R.filesets]{GenericDataFileSet}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getChipType} \tab  -\cr
 \tab \code{getPlatform} \tab  -\cr
 \tab \code{nbrOfArrays} \tab  -\cr
}


 \bold{Methods inherited from GenericDataFileSet}:\cr
append, appendFiles, as.list, byName, byPath, clearCache, copyTo, equals, extract, findByName, fromFiles, getAlias, getDefaultFullName, getFile, getFileClass, getFileSize, getFullNames, getNames, getPath, getPathnames, hasFile, indexOf, lapply, nbrOfFiles, sapply, seq, setAlias, setFullNamesTranslator, setFullNamesTranslatorByfunction, setFullNamesTranslatorByNULL, update2, updateFullName, updateFullNames, validate

 \bold{Methods inherited from FullNameInterface}:\cr
getDefaultFullName, getFullName, getFullNameTranslator, getName, getTags, hasTag, hasTags, setFullName, setFullNameTranslator, setFullNameTranslatorByfunction, setFullNameTranslatorByNULL, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
