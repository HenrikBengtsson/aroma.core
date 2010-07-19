%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitGenotypeCallSet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaUnitGenotypeCallSet}
\docType{class}
\alias{AromaUnitGenotypeCallSet}


 \title{The AromaUnitGenotypeCallSet class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaUnitGenotypeCallSet}\cr

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
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaUnitSignalBinarySet}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaUnitCallSet}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{AromaUnitGenotypeCallSet}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{AromaUnitGenotypeCallSet}\cr
extends \link[aroma.core]{AromaUnitCallSet}\cr



  An AromaUnitGenotypeCallSet object represents a set of
  \code{\link{AromaUnitGenotypeCallFile}}s with \emph{identical} chip types.
 }

 \usage{AromaUnitGenotypeCallSet(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{AromaUnitCallSet}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{byName} \tab  -\cr
 \tab \code{byPath} \tab  -\cr
 \tab \code{extractGenotypes} \tab  -\cr
}


 \bold{Methods inherited from AromaUnitCallSet}:\cr
byPath, extractCallArray, extractCalls, extractGenotypeMatrix, findByName, findUnitsTodo

 \bold{Methods inherited from AromaUnitSignalBinarySet}:\cr
byName, findByName, getAromaFullNameTranslatorSet, getAromaUgpFile, getChipType, getPlatform, validate, writeDataFrame

 \bold{Methods inherited from AromaTabularBinarySet}:\cr
getDefaultFullName, getRootName, setAttributesBy, setAttributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, setAttributesByTags

 \bold{Methods inherited from GenericTabularFileSet}:\cr
calculateAverageColumnAcrossFiles, extractMatrix

 \bold{Methods inherited from GenericDataFileSet}:\cr
getFullNameTranslatorSet, getParentName, append, appendFiles, appendFullNamesTranslator, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorByfunction, appendFullNamesTranslatorBylist, appendFullNamesTranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslatorByTabularTextFileSet, as.list, byName, byPath, clearCache, clearFullNamesTranslator, copyTo, equals, extract, findByName, getAlias, getDefaultFullName, getFile, getFileClass, getFileSize, getFullNames, getNames, getPath, getPathnames, hasFile, indexOf, lapply, nbrOfFiles, sapply, seq, setAlias, setFullNamesTranslator, update2, updateFullName, updateFullNames, validate

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorBycharacter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTabularTextFile, appendFullNameTranslatorByTabularTextFileSet, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
