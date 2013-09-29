%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitFracBCnBinarySet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaUnitFracBCnBinarySet}
\docType{class}
\alias{AromaUnitFracBCnBinarySet}


 \title{The AromaUnitFracBCnBinarySet class}

 \description{
  Package:  aroma.core \cr
\bold{Class AromaUnitFracBCnBinarySet}\cr

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
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{AromaUnitFracBCnBinarySet}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{AromaUnitFracBCnBinarySet}\cr
extends \link[aroma.core]{AromaUnitSignalBinarySet}\cr



  An AromaUnitFracBCnBinarySet object represents a set of
  \code{\link{AromaUnitFracBCnBinaryFile}}s with \emph{identical} chip types.
 }

 \usage{
AromaUnitFracBCnBinarySet(...)
}

 \arguments{
   \item{...}{Arguments passed to \code{\link{AromaUnitSignalBinarySet}}.}
 }

 \details{
   The term "allele B fraction" is also know as "allele B frequency", which
   was coined by Peiffer et al. (2006).  Note that the term "frequency" is
   a bit misleading since it is not a frequency in neither the statistical
   nor the population sense, but rather only proportion relative to the
   total amount of allele A and allele B signals, which is calculated for
   each sample independently.
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{byName} \tab  -\cr
 \tab \code{writeDataFrame} \tab  -\cr
}


 \bold{Methods inherited from AromaUnitSignalBinarySet}:\cr
byName, findByName, getAromaFullNameTranslatorSet, getAromaUgpFile, getChipType, getPlatform, validate, writeDataFrame

 \bold{Methods inherited from AromaTabularBinarySet}:\cr
getDefaultFullName, getRootName, setAttributesBy, setAttributesBySampleAnnotationFile, setAttributesBySampleAnnotationSet, setAttributesByTags

 \bold{Methods inherited from GenericTabularFileSet}:\cr
extractMatrix, calculateAverageColumnAcrossFiles

 \bold{Methods inherited from GenericDataFileSet}:\cr
[, append, appendFiles, appendFullNamesTranslator, appendFullNamesTranslatorByNULL, appendFullNamesTranslatorByTabularTextFile, appendFullNamesTranslatorByTabularTextFileSet, appendFullNamesTranslatorBydata.frame, appendFullNamesTranslatorByfunction, appendFullNamesTranslatorBylist, as.character, as.list, byName, byPath, c, clearCache, clearFullNamesTranslator, clone, copyTo, equals, extract, findByName, getChecksum, getChecksumObjects, getDefaultFullName, getFile, getFileClass, getFileSize, getFiles, getFullNames, getNames, getOneFile, getPath, getPathnames, getSubdirs, hasFile, indexOf, nbrOfFiles, resetFullNames, seq, setFullNamesTranslator, sortBy, update2, updateFullName, updateFullNames, validate, getFullNameTranslatorSet, getParentName

 \bold{Methods inherited from FullNameInterface}:\cr
appendFullNameTranslator, appendFullNameTranslatorByNULL, appendFullNameTranslatorByTabularTextFile, appendFullNameTranslatorByTabularTextFileSet, appendFullNameTranslatorBycharacter, appendFullNameTranslatorBydata.frame, appendFullNameTranslatorByfunction, appendFullNameTranslatorBylist, clearFullNameTranslator, clearListOfFullNameTranslators, getDefaultFullName, getFullName, getFullNameTranslator, getListOfFullNameTranslators, getName, getTags, hasTag, hasTags, resetFullName, setFullName, setFullNameTranslator, setListOfFullNameTranslators, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save, asThis


 }

 \references{
   [1] Peiffer et al., \emph{High-resolution genomic profiling of
       chromosomal aberrations using Infinium whole-genome genotyping},
       Genome Res, 2006.\cr
 }

 \author{Henrik Bengtsson}
\keyword{classes}
