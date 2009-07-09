%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaMicroarrayDataFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaMicroarrayDataFile}
\docType{class}
\alias{AromaMicroarrayDataFile}


 \title{The abstract AromaMicroarrayDataFile class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaMicroarrayDataFile}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{GenericDataFile}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\emph{\code{AromaMicroarrayDataFile}}\cr

\bold{Directly known subclasses:}\cr
\cr

public abstract static class \bold{AromaMicroarrayDataFile}\cr
extends \link[R.filesets]{GenericDataFile}\cr



  An AromaMicroarrayDataFile object represents a single microarray data
  file. Each such file originates from a specific chip type on a given
  platform.
 }

 \usage{AromaMicroarrayDataFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link[R.filesets]{GenericDataFile}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getChipType} \tab  -\cr
 \tab \code{getPlatform} \tab  -\cr
}


 \bold{Methods inherited from GenericDataFile}:\cr
compareChecksum, copyTo, equals, fromFile, getAlias, getAttribute, getAttributes, getChecksum, getCreatedOn, getFilename, getFileSize, getFileType, getFullName, getFullNameTranslator, getLastAccessedOn, getLastModifiedOn, getName, getPath, getPathname, getTags, gunzip, gzip, hasBeenModified, hasTag, hasTags, isFile, readChecksum, renameTo, renameToUpperCaseExt, setAlias, setAttribute, setAttributes, setAttributesBy, setAttributesByTags, setFullName, setFullNameTranslator, setName, testAttributes, validateChecksum, writeChecksum

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   An object of this class is typically part of an
   \code{\link{AromaMicroarrayDataSet}}.
 }
\keyword{classes}
