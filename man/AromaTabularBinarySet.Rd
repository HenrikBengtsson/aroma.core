%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaTabularBinarySet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaTabularBinarySet}
\docType{class}
\alias{AromaTabularBinarySet}


 \title{The AromaTabularBinarySet class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaTabularBinarySet}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{GenericDataFileSet}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericTabularFileSet}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{AromaTabularBinarySet}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaUnitCallSet}, \link[aroma.core]{AromaUnitFracBCnBinarySet}, \link[aroma.core]{AromaUnitGenotypeCallSet}, \link[aroma.core]{AromaUnitSignalBinarySet}, \link[aroma.core]{AromaUnitTotalCnBinarySet}\cr

public static class \bold{AromaTabularBinarySet}\cr
extends \link[R.filesets]{GenericTabularFileSet}\cr



  An AromaTabularBinarySet object represents a set of
  \code{\link{AromaTabularBinaryFile}}s with \emph{identical} chip types.
 }

 \usage{AromaTabularBinarySet(files=NULL, ...)}

 \arguments{
   \item{files}{A \code{\link[base]{list}} of \code{\link{AromaTabularBinaryFile}}:s.}
   \item{...}{Arguments passed to \code{\link[R.filesets]{GenericDataFileSet}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\emph{No methods defined}.


 \bold{Methods inherited from GenericTabularFileSet}:\cr
calculateAverageColumnAcrossFiles, extractMatrix

 \bold{Methods inherited from GenericDataFileSet}:\cr
append, appendFiles, as.list, byName, clearCache, copyTo, equals, extract, findByName, fromFiles, getAlias, getFile, getFileClass, getFileSize, getFullName, getFullNames, getFullNameTranslator, getName, getNames, getPath, getPathnames, getTags, hasFile, hasTag, hasTags, indexOf, lapply, nbrOfFiles, sapply, seq, setAlias, setFullName, setFullNamesTranslator, setFullNameTranslator, setName, setTags, update2, validate

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
