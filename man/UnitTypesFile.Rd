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

\code{\link[aroma.core]{Interface}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{UnitAnnotationDataFile}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\emph{\code{UnitTypesFile}}\cr

\bold{Directly known subclasses:}\cr
\cr

public abstract static class \bold{UnitTypesFile}\cr
extends \emph{\link[aroma.core]{UnitAnnotationDataFile}}\cr



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
byChipType, getAromaUgpFile, getChipType, getPlatform, nbrOfUnits

 \bold{Methods inherited from Interface}:\cr
extend, getFields, print, uses


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
