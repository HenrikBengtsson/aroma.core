%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitSignalBinaryFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaUnitSignalBinaryFile}
\docType{class}
\alias{AromaUnitSignalBinaryFile}


 \title{The AromaUnitSignalBinaryFile class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaUnitSignalBinaryFile}\cr

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
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{AromaUnitSignalBinaryFile}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaUnitCallFile}, \link[aroma.core]{AromaUnitFracBCnBinaryFile}, \link[aroma.core]{AromaUnitGenotypeCallFile}, \link[aroma.core]{AromaUnitTotalCnBinaryFile}, \link[aroma.core]{AromaUnitTypesFile}\cr

public static class \bold{AromaUnitSignalBinaryFile}\cr
extends \emph{\link[aroma.core]{AromaPlatformInterface}}\cr



  An AromaUnitSignalBinaryFile is a \code{\link{AromaTabularBinaryFile}}.
 }

 \usage{AromaUnitSignalBinaryFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{AromaTabularBinaryFile}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{allocate} \tab  -\cr
 \tab \code{allocateFromUnitAnnotationDataFile} \tab  -\cr
 \tab \code{allocateFromUnitNamesFile} \tab  -\cr
 \tab \code{as.character} \tab  -\cr
 \tab \code{extractMatrix} \tab  -\cr
 \tab \code{fromFile} \tab  -\cr
 \tab \code{getAromaUgpFile} \tab  -\cr
 \tab \code{getChipType} \tab  -\cr
 \tab \code{getPlatform} \tab  -\cr
 \tab \code{isAverageFile} \tab  -\cr
 \tab \code{nbrOfUnits} \tab  -\cr
 \tab \code{readDataFrame} \tab  -\cr
 \tab \code{\link[aroma.core:writeDataFrame.AromaUnitSignalBinaryFile]{writeDataFrame}} \tab Writes the data file as a tab-delimited text file.\cr
}


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

 \seealso{
   \code{\link[aroma.core]{AromaTabularBinaryFile}}.
 }
\keyword{classes}
