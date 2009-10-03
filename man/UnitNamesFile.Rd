%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  UnitNamesFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{UnitNamesFile}
\docType{class}
\alias{UnitNamesFile}


 \title{The UnitNamesFile interface class}

 \description{
  Package:  aroma.core \cr
\bold{Class UnitNamesFile}\cr

\code{\link[R.oo]{Interface}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{UnitAnnotationDataFile}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\emph{\code{UnitNamesFile}}\cr

\bold{Directly known subclasses:}\cr
\link[aroma.core]{TextUnitNamesFile}\cr

public abstract static class \bold{UnitNamesFile}\cr
extends \emph{\link[aroma.core]{UnitAnnotationDataFile}}\cr



  A UnitNamesFile provides methods for querying the unit names of
  a given chip type.
 }

 \usage{UnitNamesFile(...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link{UnitAnnotationDataFile}}.}
 }

 \section{Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getUnitNames} \tab  -\cr
 \tab \code{\link[aroma.core:indexOf.UnitNamesFile]{indexOf}} \tab Gets the indices of units by their names.\cr
 \tab \code{nbrOfUnits} \tab  -\cr
}


 \bold{Methods inherited from UnitAnnotationDataFile}:\cr
byChipType, getAromaUgpFile, getChipType, getPlatform, nbrOfUnits

 \bold{Methods inherited from Interface}:\cr
extend, print, uses


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
