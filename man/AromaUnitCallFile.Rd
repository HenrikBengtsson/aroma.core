%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitCallFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaUnitCallFile}
\docType{class}
\alias{AromaUnitCallFile}


 \title{The AromaUnitCallFile class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaUnitCallFile}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{FullNameInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericDataFile}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[R.filesets]{GenericTabularFile}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaTabularBinaryFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaPlatformInterface}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaUnitSignalBinaryFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{AromaUnitCallFile}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaUnitGenotypeCallFile}\cr

public static class \bold{AromaUnitCallFile}\cr
extends \link[aroma.core]{AromaUnitSignalBinaryFile}\cr



  An AromaUnitCallFile is a \code{\link{AromaUnitSignalBinaryFile}}.
 }

 \usage{AromaUnitCallFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{AromaUnitSignalBinaryFile}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{allocate} \tab  -\cr
 \tab \code{extractCallArray} \tab  -\cr
 \tab \code{extractCalls} \tab  -\cr
 \tab \code{extractMatrix} \tab  -\cr
 \tab \code{findUnitsTodo} \tab  -\cr
}


 \bold{Methods inherited from AromaUnitSignalBinaryFile}:\cr
allocate, allocateFromUnitAnnotationDataFile, allocateFromUnitNamesFile, as.character, extractMatrix, extractRawGenomicSignals, fromFile, getAromaUgpFile, getChipType, getExtensionPattern, getFilenameExtension, getPlatform, isAverageFile, nbrOfUnits, readDataFrame, writeDataFrame

 \bold{Methods inherited from AromaPlatformInterface}:\cr
getAromaPlatform, getAromaUgpFile, getPlatform, getUnitAnnotationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

 \bold{Methods inherited from AromaTabularBinaryFile}:\cr
[, [[, [<-, allocate, as.character, colMeans, colMedians, colStats, colSums, dimnames<-, getBytesPerColumn, getColClasses, getColumnNames, importFrom, lapply, nbrOfColumns, nbrOfRows, readColumns, readDataFrame, readFooter, readHeader, readRawFooter, setAttributesByTags, subset, summary, updateData, updateDataColumn, writeFooter, writeRawFooter

 \bold{Methods inherited from GenericTabularFile}:\cr
as.character, dim, extractMatrix, getColumnNames, getColumnNameTranslator, nbrOfColumns, nbrOfRows, readColumns, readDataFrame, setColumnNameTranslator, translateColumnNames

 \bold{Methods inherited from GenericDataFile}:\cr
compareChecksum, copyTo, equals, fromFile, getAlias, getAttribute, getAttributes, getChecksum, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern, getFilename, getFilenameExtension, getFileSize, getFileType, getLastAccessedOn, getLastModifiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, isFile, readChecksum, renameTo, renameToUpperCaseExt, setAlias, setAttribute, setAttributes, setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validateChecksum, writeChecksum

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorBycharacter, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, appendFullNameTranslatorByNULL, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
