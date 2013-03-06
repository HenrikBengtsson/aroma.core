%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaMicroarrayDataSet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaMicroarrayDataSet}
\docType{class}
\alias{AromaMicroarrayDataSet}


 \title{The AromaMicroarrayDataSet class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaMicroarrayDataSet}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.filesets]{FullNameInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.filesets]{GenericDataFileSet}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\emph{\code{AromaMicroarrayDataSet}}\cr

\bold{Directly known subclasses:}\cr
\cr

public abstract static class \bold{AromaMicroarrayDataSet}\cr
extends \link[R.filesets]{GenericDataFileSet}\cr



  An AromaMicroarrayDataSet object represents a set of
  \code{\link{AromaMicroarrayDataFile}}s with \emph{identical} chip types.
 }

 \usage{
AromaMicroarrayDataSet(files=NULL, ...)
}

 \arguments{
   \item{files}{A \code{\link[base]{list}} of \code{\link{AromaMicroarrayDataFile}}:s.}
   \item{...}{Arguments passed to \code{\link[R.filesets]{GenericDataFileSet}}.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as.AromaMicroarrayDataSetList} \tab  -\cr
 \tab \code{as.AromaMicroarrayDataSetTuple} \tab  -\cr
 \tab \code{getAverageFile} \tab  -\cr
 \tab \code{getChipType} \tab  -\cr
 \tab \code{getPlatform} \tab  -\cr
 \tab \code{nbrOfArrays} \tab  -\cr
}


 \bold{Methods inherited from GenericDataFileSet}:\cr
append, appendFiles, appendFullNamesTranslator, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorByfunction, appendFullNamesTranslatorBylist, appendFullNamesTranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslatorByTabularTextFileSet, as.character, as.list, byName, byPath, clearCache, clearFullNamesTranslator, clone, copyTo, equals, extract, findByName, getChecksum, getChecksumObjects, getDefaultFullName, getFile, getFileClass, getFiles, getFileSize, getFullNames, getNames, getOneFile, getPath, getPathnames, getSubdirs, hasFile, indexOf, nbrOfFiles, resetFullNames, seq, setFullNamesTranslator, sortBy, update2, updateFullName, updateFullNames, validate, getFullNameTranslatorSet, getParentName

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorBycharacter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTabularTextFile, appendFullNameTranslatorByTabularTextFileSet, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save, asThis


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
