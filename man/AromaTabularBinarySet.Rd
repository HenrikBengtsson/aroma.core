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
\code{~~+--}\code{\link[R.filesets]{FullNameInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericDataFileSet}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[R.filesets]{GenericTabularFileSet}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{AromaTabularBinarySet}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaUnitCallSet}, \link[aroma.core]{AromaUnitFracBCnBinarySet}, \link[aroma.core]{AromaUnitGenotypeCallSet}, \link[aroma.core]{AromaUnitPscnBinarySet}, \link[aroma.core]{AromaUnitSignalBinarySet}, \link[aroma.core]{AromaUnitTotalCnBinarySet}\cr

public static class \bold{AromaTabularBinarySet}\cr
extends \link[R.filesets]{GenericTabularFileSet}\cr



  An AromaTabularBinarySet object represents a set of
  \code{\link{AromaTabularBinaryFile}}s with \emph{identical} chip types.
 }

 \usage{
AromaTabularBinarySet(files=NULL, ...)
}

 \arguments{
   \item{files}{A \code{\link[base]{list}} of \code{\link{AromaTabularBinaryFile}}:s.}
   \item{...}{Arguments passed to \code{\link[R.filesets]{GenericDataFileSet}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\emph{No methods defined}.


 \bold{Methods inherited from GenericTabularFileSet}:\cr
extractMatrix, calculateAverageColumnAcrossFiles

 \bold{Methods inherited from GenericDataFileSet}:\cr
[, [[, anyDuplicated, anyNA, append, appendFiles, appendFullNamesTranslator, appendFullNamesTranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslatorByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorByfunction, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache, clearFullNamesTranslator, clone, copyTo, duplicated, equals, extract, findByName, findDuplicated, getChecksum, getChecksumFileSet, getChecksumObjects, getDefaultFullName, getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, getPathnames, getSubdirs, gunzip, gzip, hasFile, indexOf, is.na, na.omit, nbrOfFiles, resetFullNames, seq, setFullNamesTranslator, sortBy, unique, update2, updateFullName, updateFullNames, validate, getFullNameTranslatorSet, getParentName

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTabularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBycharacter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save, asThis


 }

 \author{Henrik Bengtsson}
\keyword{classes}
