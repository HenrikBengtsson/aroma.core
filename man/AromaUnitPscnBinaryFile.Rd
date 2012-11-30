%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitPscnBinaryFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaUnitPscnBinaryFile}
\docType{class}
\alias{AromaUnitPscnBinaryFile}


 \title{The AromaUnitPscnBinaryFile class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaUnitPscnBinaryFile}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{FullNameInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericDataFile}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[R.filesets]{ColumnNamesInterface}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{\link[R.filesets]{GenericTabularFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{CacheKeyInterface}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{FileCacheKeyInterface}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaTabularBinaryFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaPlatformInterface}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaUnitSignalBinaryFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{CopyNumberDataFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\emph{\code{AromaUnitPscnBinaryFile}}\cr

\bold{Directly known subclasses:}\cr
\cr

public abstract static class \bold{AromaUnitPscnBinaryFile}\cr
extends \emph{\link[aroma.core]{CopyNumberDataFile}}\cr



  An AromaUnitPscnBinaryFile is a \code{\link{AromaUnitSignalBinaryFile}}
  that holds total copy number signals (TCNs) and allele B fractions (BAFs).
  The TCNs can either be on an unknown scale or ratios relative
  to a reference.  The signals are always stored on the original scale,
  i.e. they are never stored on the logaritmic scale.
  The BAFs are always on a [0-eps,1+eps] scale, where eps >= 0.
 }

 \usage{AromaUnitPscnBinaryFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{AromaUnitSignalBinaryFile}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{extractRawCopyNumbers} \tab  -\cr
 \tab \code{hasAlleleBFractions} \tab  -\cr
 \tab \code{hasStrandiness} \tab  -\cr
 \tab \code{hasTotalCopyNumberRatios} \tab  -\cr
}


 \bold{Methods inherited from CopyNumberDataFile}:\cr
as, as.CopyNumberDataFile, getNumberOfFilesAveraged, hasAlleleBFractions, hasStrandiness

 \bold{Methods inherited from AromaUnitSignalBinaryFile}:\cr
allocate, allocateFromUnitAnnotationDataFile, allocateFromUnitNamesFile, as.character, extractMatrix, extractRawGenomicSignals, fromFile, getAromaUgpFile, getChipType, getExtensionPattern, getFilenameExtension, getNumberOfFilesAveraged, getPlatform, isAverageFile, nbrOfUnits, readDataFrame, writeDataFrame

 \bold{Methods inherited from AromaPlatformInterface}:\cr
getAromaPlatform, getAromaUgpFile, getPlatform, getUnitAnnotationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

 \bold{Methods inherited from AromaTabularBinaryFile}:\cr
[, [[, [<-, allocate, as.character, colApply, colMeans, colMedians, colStats, colSums, dimnames<-, getBytesPerColumn, getColClasses, getDefaultColumnNames, getRootName, importFrom, nbrOfColumns, nbrOfRows, readColumns, readDataFrame, readFooter, readHeader, readRawFooter, setAttributesByTags, subset, summary, updateData, updateDataColumn, writeFooter, writeRawFooter

 \bold{Methods inherited from FileCacheKeyInterface}:\cr
getCacheKey

 \bold{Methods inherited from CacheKeyInterface}:\cr
getCacheKey

 \bold{Methods inherited from GenericTabularFile}:\cr
dim, extractMatrix, nbrOfRows, readColumns, readDataFrame

 \bold{Methods inherited from ColumnNamesInterface}:\cr
appendColumnNamesTranslator, appendColumnNamesTranslatorBycharacter, appendColumnNamesTranslatorByfunction, appendColumnNamesTranslatorBylist, appendColumnNamesTranslatorByNULL, clearColumnNamesTranslator, clearListOfColumnNamesTranslators, getColumnNames, getColumnNamesTranslator, getDefaultColumnNames, getListOfColumnNamesTranslators, nbrOfColumns, setColumnNames, setColumnNamesTranslator, setListOfColumnNamesTranslators, updateColumnNames

 \bold{Methods inherited from GenericDataFile}:\cr
getParentName, as.character, clone, compareChecksum, copyTo, equals, fromFile, getAttribute, getAttributes, getChecksum, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern, getFilename, getFilenameExtension, getFileSize, getFileType, getLastAccessedOn, getLastModifiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, isFile, readChecksum, renameTo, renameToUpperCaseExt, setAttribute, setAttributes, setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validate, validateChecksum, writeChecksum

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorBycharacter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTabularTextFile, appendFullNameTranslatorByTabularTextFileSet, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
