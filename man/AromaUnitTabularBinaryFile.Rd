%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitTabularBinaryFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaUnitTabularBinaryFile}
\docType{class}
\alias{AromaUnitTabularBinaryFile}


 \title{The AromaUnitTabularBinaryFile class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaUnitTabularBinaryFile}\cr

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
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{AromaMicroarrayTabularBinaryFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.core]{UnitAnnotationDataFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\emph{\code{AromaUnitTabularBinaryFile}}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaUflFile}, \link[aroma.core]{AromaUgpFile}, \emph{\link[aroma.core]{AromaUnitChromosomeTabularBinaryFile}}\cr

public abstract static class \bold{AromaUnitTabularBinaryFile}\cr
extends \link[aroma.core]{UnitAnnotationDataFile}\cr



  A AromaUnitTabularBinaryFile is an \code{\link{AromaTabularBinaryFile}} with
  the constraint that the rows map one-to-one to, and in the same order as,
  the units in a annotation chip type file (e.g. CDF file).
  The (full) chip type of the annotation chip type file is given by the
  mandatory file footer \code{chipType}.
 }

 \usage{AromaUnitTabularBinaryFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{AromaTabularBinaryFile}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{allocateFromUnitAnnotationDataFile} \tab  -\cr
 \tab \code{allocateFromUnitNamesFile} \tab  -\cr
 \tab \code{byChipType} \tab  -\cr
 \tab \code{nbrOfUnits} \tab  -\cr
 \tab \code{\link[aroma.core:writeDataFrame.AromaUnitTabularBinaryFile]{writeDataFrame}} \tab Writes the data file as a tab-delimited text file.\cr
}


 \bold{Methods inherited from UnitAnnotationDataFile}:\cr
byChipType, getAromaUflFile, getAromaUgpFile, getChipType, getPlatform, nbrOfUnits

 \bold{Methods inherited from AromaMicroarrayTabularBinaryFile}:\cr
allocate, as.character, byChipType, findByChipType, getChipType, getFilenameExtension, getPlatform

 \bold{Methods inherited from AromaPlatformInterface}:\cr
getAromaPlatform, getAromaUgpFile, getPlatform, getUnitAnnotationDataFile, getUnitNamesFile, getUnitTypesFile, isCompatibleWith

 \bold{Methods inherited from AromaTabularBinaryFile}:\cr
[, [[, [<-, allocate, as.character, colMeans, colMedians, colStats, colSums, dimnames<-, getBytesPerColumn, getColClasses, getColumnNames, getRootName, importFrom, lapply, nbrOfColumns, nbrOfRows, readColumns, readDataFrame, readFooter, readHeader, readRawFooter, setAttributesByTags, subset, summary, updateData, updateDataColumn, writeFooter, writeRawFooter

 \bold{Methods inherited from GenericTabularFile}:\cr
as.character, dim, extractMatrix, getColumnNames, getColumnNameTranslator, nbrOfColumns, nbrOfRows, readColumns, readDataFrame, setColumnNameTranslator, translateColumnNames

 \bold{Methods inherited from GenericDataFile}:\cr
getParentName, compareChecksum, copyTo, equals, fromFile, getAlias, getAttribute, getAttributes, getChecksum, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern, getFilename, getFilenameExtension, getFileSize, getFileType, getLastAccessedOn, getLastModifiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, isFile, readChecksum, renameTo, renameToUpperCaseExt, setAlias, setAttribute, setAttributes, setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validateChecksum, writeChecksum

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorBycharacter, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, appendFullNameTranslatorByNULL, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 %\seealso{
 % \code{\link{AromaCellTabularBinaryFile}}.
 %}
\keyword{classes}
