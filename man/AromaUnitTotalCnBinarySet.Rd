%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitTotalCnBinarySet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaUnitTotalCnBinarySet}
\docType{class}
\alias{AromaUnitTotalCnBinarySet}


 \title{The AromaUnitTotalCnBinarySet class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaUnitTotalCnBinarySet}\cr

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
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{CopyNumberDataSet}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{AromaUnitTotalCnBinarySet}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{AromaUnitTotalCnBinarySet}\cr
extends \link[aroma.core]{CopyNumberDataSet}\cr



  An AromaUnitTotalCnBinarySet object represents a set of
  \code{\link{AromaUnitTotalCnBinaryFile}}s with \emph{identical} chip types.
 }

 \usage{AromaUnitTotalCnBinarySet(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{AromaUnitSignalBinarySet}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as.AromaUnitTotalCnBinarySetTuple} \tab  -\cr
 \tab \code{as.CopyNumberDataSetTuple} \tab  -\cr
 \tab \code{byName} \tab  -\cr
 \tab \code{exportTotalCnRatioSet} \tab  -\cr
 \tab \code{getAverageFile} \tab  -\cr
 \tab \code{getUnitNamesFile} \tab  -\cr
 \tab \code{nbrOfArrays} \tab  -\cr
}


 \bold{Methods inherited from CopyNumberDataSet}:\cr
as, as.CopyNumberDataSet, hasAlleleBFractions, hasStrandiness

 \bold{Methods inherited from AromaUnitSignalBinarySet}:\cr
byName, findByName, getAromaUgpFile, getChipType, getPlatform, validate

 \bold{Methods inherited from AromaTabularBinarySet}:\cr
getDefaultFullName

 \bold{Methods inherited from GenericTabularFileSet}:\cr
calculateAverageColumnAcrossFiles, extractMatrix

 \bold{Methods inherited from GenericDataFileSet}:\cr
append, appendFiles, appendFullNamesTranslator, appendFullNamesTranslatorByfunction, appendFullNamesTranslatorBylist, appendFullNamesTranslatorByNULL, as.list, byName, byPath, clearCache, clearFullNamesTranslator, copyTo, equals, extract, findByName, fromFiles, getAlias, getDefaultFullName, getFile, getFileClass, getFileSize, getFullNames, getNames, getPath, getPathnames, hasFile, indexOf, lapply, nbrOfFiles, sapply, seq, setAlias, setFullNamesTranslator, update2, updateFullName, updateFullNames, validate

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorBycharacter, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, appendFullNameTranslatorByNULL, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
