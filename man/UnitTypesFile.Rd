%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  UnitTypesFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{UnitTypesFile}
\docType{class}
\alias{UnitTypesFile}


 \title{The UnitTypesFile interface class}

 \description{
  Package:  aroma.core \cr
\bold{Class UnitTypesFile}\cr

\code{\link[R.oo]{Interface}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{UnitAnnotationDataFile}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\emph{\code{UnitTypesFile}}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{AromaUnitTypesFile}\cr

public abstract static class \bold{UnitTypesFile}\cr
extends \link[aroma.core]{UnitAnnotationDataFile}\cr



  A UnitTypesFile provides methods for querying the unit types of
  a given chip type, e.g. genotyping or copy-number unit, exon unit etc.
 }

 \usage{UnitTypesFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{UnitAnnotationDataFile}}.}
 }

 \section{Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getUnitTypes} \tab  -\cr
 \tab \code{nbrOfUnits} \tab  -\cr
}


 \bold{Methods inherited from UnitAnnotationDataFile}:\cr
byChipType, getAromaUflFile, getAromaUgpFile, getChipType, getDefaultExtension, getPlatform, nbrOfUnits

 \bold{Methods inherited from Interface}:\cr
extend, print, uses


 }

 \section{The aroma unit-type map}{
   unknown=0,
   expression=1,
   genotyping=2,
   resequencing=3,
   tag=4,
   copynumber=5,
   genotypingcontrol=6,
   expressioncontrol=7
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
