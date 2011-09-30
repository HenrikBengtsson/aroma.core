%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaGenomeTextFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaGenomeTextFile}
\docType{class}
\alias{AromaGenomeTextFile}


 \title{The AromaGenomeTextFile class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaGenomeTextFile}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{FullNameInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericDataFile}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[R.filesets]{GenericTabularFile}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{\link[R.filesets]{TabularTextFile}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\emph{\code{AromaGenomeTextFile}}\cr

\bold{Directly known subclasses:}\cr
\cr

public abstract static class \bold{AromaGenomeTextFile}\cr
extends \emph{\link[R.filesets]{TabularTextFile}}\cr



  An AromaGenomeTextFile represents a annotation tabular text file that
  specifies the number of bases (nucleotides) per chromosome for a
  particular genome/organism.
 }

 \usage{AromaGenomeTextFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link[R.filesets]{TabularTextFile}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{byGenome} \tab  -\cr
 \tab \code{findByGenome} \tab  -\cr
 \tab \code{readDataFrame} \tab  -\cr
}


 \bold{Methods inherited from TabularTextFile}:\cr
[, as.character, getColumnNames, getCommentChar, getHeader, getReadArguments, hasColumnHeader, nbrOfLines, nbrOfRows, readColumnNames, readColumns, readDataFrame, readLines, readRawHeader, setCommentChar, writeColumnsToFiles

 \bold{Methods inherited from GenericTabularFile}:\cr
as.character, dim, extractMatrix, getColumnNames, getColumnNameTranslator, nbrOfColumns, nbrOfRows, readColumns, readDataFrame, setColumnNameTranslator, translateColumnNames

 \bold{Methods inherited from GenericDataFile}:\cr
getParentName, compareChecksum, copyTo, equals, fromFile, getAlias, getAttribute, getAttributes, getChecksum, getCreatedOn, getDefaultFullName, getExtension, getExtensionPattern, getFilename, getFilenameExtension, getFileSize, getFileType, getLastAccessedOn, getLastModifiedOn, getOutputExtension, getPath, getPathname, gunzip, gzip, hasBeenModified, isFile, readChecksum, renameTo, renameToUpperCaseExt, setAlias, setAttribute, setAttributes, setAttributesBy, setAttributesByTags, setExtensionPattern, testAttributes, validateChecksum, writeChecksum

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorBycharacter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTabularTextFile, appendFullNameTranslatorByTabularTextFileSet, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
asThis, getChecksum, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \details{
   An AromaGenomeTextFile is a tab-delimited text file with a header
   containing (at least) column names 'chromosome' and 'nbrOfBases'.
   The 'chromosome' column specifies the chromosomes (character strings)
   and the 'nbrOfBases' column specifies the lengths (integer) of the
   chromosomes in number of bases (nucleotides).

   The filename of an AromaGenomeTextFile should have format
   "<genome>,chromosomes(,<tag>)*.txt",
   and be located in annotationData/genomes/<genome>/, e.g.
   annotationData/genomes/Human/Human,chromosomes,max,20090503.txt.
 }

 \examples{
# Locate a Human,chromosomes(,.*)*.txt file
db <- AromaGenomeTextFile$byGenome("Human");
print(db);

# Read the data
df <- readDataFrame(db);
print(df);
str(df);

# Details on the file format
oopts <- options(width=40);
print(readLines(db));
options(oopts);
}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
