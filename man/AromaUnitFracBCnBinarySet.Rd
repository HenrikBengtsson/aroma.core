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

 \usage{AromaUnitFracBCnBinarySet(...)}

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
 \tab \code{exportFracBDiffSet} \tab  -\cr
}


 \bold{Methods inherited from AromaUnitSignalBinarySet}:\cr
byName, findByName, getAromaUgpFile, getChipType, getPlatform, validate

 \bold{Methods inherited from GenericTabularFileSet}:\cr
calculateAverageColumnAcrossFiles, extractMatrix

 \bold{Methods inherited from GenericDataFileSet}:\cr
append, appendFiles, as.list, byName, byPath, clearCache, copyTo, equals, extract, findByName, fromFiles, getAlias, getDefaultFullName, getFile, getFileClass, getFileSize, getFullNames, getNames, getPath, getPathnames, hasFile, indexOf, lapply, nbrOfFiles, sapply, seq, setAlias, setFullNamesTranslator, setFullNamesTranslatorByfunction, setFullNamesTranslatorByNULL, update2, updateFullName, updateFullNames, validate

 \bold{Methods inherited from FullNameInterface}:\cr
getDefaultFullName, getFullName, getFullNameTranslator, getName, getTags, hasTag, hasTags, setFullName, setFullNameTranslator, setFullNameTranslatorByfunction, setFullNameTranslatorByNULL, setName, setTags, updateFullName

 \bold{Methods inherited from Object}:\cr
asThis, $, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, registerFinalizer, save


 }

 \references{
   [1] Peiffer et al., \emph{High-resolution genomic profiling of
       chromosomal aberrations using Infinium whole-genome genotyping},
       Genome Res, 2006.\cr
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
