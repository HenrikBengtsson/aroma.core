%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaPlatformInterface.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{AromaPlatformInterface}
\docType{class}
\alias{AromaPlatformInterface}


\title{The AromaPlatformInterface class}

\description{
 Package:  aroma.core \cr
\bold{Class AromaPlatformInterface}\cr

\code{\link[R.oo]{Interface}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{AromaPlatformInterface}}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaCellCpgFile}, \link[aroma.core]{AromaCellPositionFile}, \link[aroma.core]{AromaCellSequenceFile}, \emph{\link[aroma.core]{AromaCellTabularBinaryFile}}, \emph{\link[aroma.core]{AromaMicroarrayTabularBinaryFile}}, \link[aroma.core]{AromaUflFile}, \link[aroma.core]{AromaUgcFile}, \link[aroma.core]{AromaUgpFile}, \link[aroma.core]{AromaUnitCallFile}, \emph{\link[aroma.core]{AromaUnitChromosomeTabularBinaryFile}}, \link[aroma.core]{AromaUnitFracBCnBinaryFile}, \link[aroma.core]{AromaUnitGcContentFile}, \link[aroma.core]{AromaUnitGenotypeCallFile}, \emph{\link[aroma.core]{AromaUnitPscnBinaryFile}}, \link[aroma.core]{AromaUnitSignalBinaryFile}, \emph{\link[aroma.core]{AromaUnitTabularBinaryFile}}, \emph{\link[aroma.core]{AromaUnitTotalCnBinaryFile}}, \link[aroma.core]{AromaUnitTypesFile}\cr

public abstract class \bold{AromaPlatformInterface}\cr
extends \link[R.oo]{Interface}\cr



 An AromaPlatformInterface provides methods for a given platform, e.g.
 Affymetrix, Agilent, Illumina.
}

\usage{
AromaPlatformInterface(...)
}

\arguments{
  \item{...}{Not used.}
}

\section{Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getAromaPlatform} \tab  -\cr
 \tab \code{getAromaUflFile} \tab  -\cr
 \tab \code{getAromaUgpFile} \tab  -\cr
 \tab \code{getChipType} \tab  -\cr
 \tab \code{getPlatform} \tab  -\cr
 \tab \code{getUnitNamesFile} \tab  -\cr
 \tab \code{getUnitTypesFile} \tab  -\cr
}


 \bold{Methods inherited from Interface}:\cr
extend, print, uses


}

\author{Henrik Bengtsson}
\keyword{classes}
