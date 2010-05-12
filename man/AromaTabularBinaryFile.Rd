%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaTabularBinaryFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaTabularBinaryFile}
\docType{class}
\alias{AromaTabularBinaryFile}


 \title{The AromaTabularBinaryFile class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaTabularBinaryFile}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{FullNameInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericDataFile}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[R.filesets]{GenericTabularFile}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\emph{\code{AromaTabularBinaryFile}}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaCellCpgFile}, \link[aroma.core]{AromaCellPositionFile}, \link[aroma.core]{AromaCellSequenceFile}, \emph{\link[aroma.core]{AromaCellTabularBinaryFile}}, \emph{\link[aroma.core]{AromaMicroarrayTabularBinaryFile}}, \link[aroma.core]{AromaUflFile}, \link[aroma.core]{AromaUgpFile}, \link[aroma.core]{AromaUnitCallFile}, \emph{\link[aroma.core]{AromaUnitChromosomeTabularBinaryFile}}, \link[aroma.core]{AromaUnitFracBCnBinaryFile}, \link[aroma.core]{AromaUnitGenotypeCallFile}, \link[aroma.core]{AromaUnitSignalBinaryFile}, \emph{\link[aroma.core]{AromaUnitTabularBinaryFile}}, \link[aroma.core]{AromaUnitTotalCnBinaryFile}, \link[aroma.core]{AromaUnitTypesFile}\cr

public abstract static class \bold{AromaTabularBinaryFile}\cr
extends \emph{\link[R.filesets]{GenericTabularFile}}\cr



  A AromaTabularBinaryFile represents a file with a binary format.
  It has a well defined header, a data section, and a footer.
 }

 \usage{AromaTabularBinaryFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link[R.filesets]{GenericTabularFile}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{[} \tab  -\cr
 \tab \code{[[} \tab  -\cr
 \tab \code{[<-} \tab  -\cr
 \tab \code{\link[aroma.core:allocate.AromaTabularBinaryFile]{allocate}} \tab Creates an AromaTabularBinaryFile.\cr
 \tab \code{as.character} \tab  -\cr
 \tab \code{colMeans} \tab  -\cr
 \tab \code{colMedians} \tab  -\cr
 \tab \code{colStats} \tab  -\cr
 \tab \code{colSums} \tab  -\cr
 \tab \code{dimnames<-} \tab  -\cr
 \tab \code{getBytesPerColumn} \tab  -\cr
 \tab \code{getColClasses} \tab  -\cr
 \tab \code{getColumnNames} \tab  -\cr
 \tab \code{importFrom} \tab  -\cr
 \tab \code{lapply} \tab  -\cr
 \tab \code{nbrOfColumns} \tab  -\cr
 \tab \code{nbrOfRows} \tab  -\cr
 \tab \code{readColumns} \tab  -\cr
 \tab \code{\link[aroma.core:readFooter.AromaTabularBinaryFile]{readFooter}} \tab Reads the file footer in XML format into a named nested list.\cr
 \tab \code{subset} \tab  -\cr
 \tab \code{summary} \tab  -\cr
 \tab \code{\link[aroma.core:writeFooter.AromaTabularBinaryFile]{writeFooter}} \tab Writes a named nested list to the file footer in XML format.\cr
}


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

 \seealso{
   \code{\link[R.filesets]{GenericDataFile}}.
 }
\keyword{classes}
