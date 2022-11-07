%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  ChromosomeExplorer.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{ChromosomeExplorer}
\docType{class}
\alias{ChromosomeExplorer}


\title{The ChromosomeExplorer class}

\description{
 Package:  aroma.core \cr
\bold{Class ChromosomeExplorer}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{Explorer}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{ChromosomeExplorer}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{ChromosomeExplorer}\cr
extends \emph{\link[aroma.core]{Explorer}}\cr


}

\usage{
ChromosomeExplorer(model=NULL, zooms=2^(0:6), ...)
}

\arguments{
  \item{model}{A \code{\link{CopyNumberChromosomalModel}} object.}
  \item{zooms}{An positive \code{\link[base]{integer}} \code{\link[base]{vector}} specifying for which zoom
   levels the graphics should be generated.}
  \item{...}{Not used.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{display} \tab  -\cr
 \tab \code{getChromosomes} \tab  -\cr
 \tab \code{getFullNames} \tab  -\cr
 \tab \code{getModel} \tab  -\cr
 \tab \code{getNames} \tab  -\cr
 \tab \code{getPath} \tab  -\cr
 \tab \code{getZooms} \tab  -\cr
 \tab \code{indexOf} \tab  -\cr
 \tab \code{process} \tab  -\cr
 \tab \code{setArrays} \tab  -\cr
 \tab \code{setCytoband} \tab  -\cr
 \tab \code{setZooms} \tab  -\cr
}


 \bold{Methods inherited from Explorer}:\cr
addIncludes, addIndexFile, as.character, display, getAlias, getArraysOfInput, getAsteriskTags, getFullName, getIncludePath, getMainPath, getName, getNameOfInput, getNames, getPath, getReportPathPattern, getRootPath, getSampleLayerPrefix, getSubname, getTags, getTagsOfInput, getTemplatePath, getVersion, nbrOfArrays, process, setAlias, setArrays, setReportPathPattern, setSubname, setup, splitByReportPathPattern, updateSetupExplorerFile

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis


}

\section{Generating PNG images}{
  In order to get better looking graphs, but also to be able to generate
  bitmap images on systems without direct bitmap support, which is the case
  when running R in batch mode or on Unix without X11 support, images are
  created using the \code{\link[R.devices]{png2}} device (a wrapper for
  \code{bitmap()} imitating \code{png()}).  The \code{png()} is only
  used if \code{png2()}, which requires Ghostscript, does not.
  Note, when images are created using \code{png2()}, the images does
  not appear immediately, although the function call is completed,
  so be patient.
}

\author{Henrik Bengtsson}

\seealso{
 \code{\link{CopyNumberChromosomalModel}}.
}
\keyword{classes}
