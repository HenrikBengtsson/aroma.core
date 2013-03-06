%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitSignalBinarySet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaUnitSignalBinarySet}
\docType{class}
\alias{AromaUnitSignalBinarySet}


 \title{The AromaUnitSignalBinarySet class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaUnitSignalBinarySet}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{FullNameInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericDataFileSet}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[R.filesets]{GenericTabularFileSet}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaTabularBinarySet}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\code{AromaUnitSignalBinarySet}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaUnitCallSet}, \link[aroma.core]{AromaUnitFracBCnBinarySet}, \link[aroma.core]{AromaUnitGenotypeCallSet}, \link[aroma.core]{AromaUnitPscnBinarySet}, \link[aroma.core]{AromaUnitTotalCnBinarySet}\cr

public static class \bold{AromaUnitSignalBinarySet}\cr
extends \link[aroma.core]{AromaTabularBinarySet}\cr



  An AromaUnitSignalBinarySet object represents a set of
  \code{\link{AromaUnitSignalBinaryFile}}s with \emph{identical} chip types.
 }

 \usage{
AromaUnitSignalBinarySet(...)
}

 \arguments{
   \item{...}{Arguments passed to \code{\link{AromaTabularBinarySet}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{byName} \tab  -\cr
 \tab \code{getAromaUgpFile} \tab  -\cr
 \tab \code{getChipType} \tab  -\cr
 \tab \code{getPlatform} \tab  -\cr
 \tab \code{\link[aroma.core:writeDataFrame.AromaUnitSignalBinarySet]{writeDataFrame}} \tab Writes the data set as a tab-delimited text file.\cr
}


 \bold{Methods inherited from AromaTabularBinarySet}:\cr
getDefaultFullName, getRootName, setAttributesBy, setAttributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, setAttributesByTags

 \bold{Methods inherited from GenericTabularFileSet}:\cr
extractMatrix, calculateAverageColumnAcrossFiles

 \bold{Methods inherited from GenericDataFileSet}:\cr
append, appendFiles, appendFullNamesTranslator, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorByfunction, appendFullNamesTranslatorBylist, appendFullNamesTranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslatorByTabularTextFileSet, as.character, as.list, byName, byPath, clearCache, clearFullNamesTranslator, clone, copyTo, equals, extract, findByName, getChecksum, getChecksumObjects, getDefaultFullName, getFile, getFileClass, getFiles, getFileSize, getFullNames, getNames, getOneFile, getPath, getPathnames, getSubdirs, hasFile, indexOf, nbrOfFiles, resetFullNames, seq, setFullNamesTranslator, sortBy, update2, updateFullName, updateFullNames, validate, getFullNameTranslatorSet, getParentName

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorBycharacter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTabularTextFile, appendFullNameTranslatorByTabularTextFileSet, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save, asThis


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
