%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  UnitNamesFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{indexOf.UnitNamesFile}
\alias{indexOf.UnitNamesFile}
\alias{UnitNamesFile.indexOf}
\alias{indexOf.UnitNamesFile}
\alias{indexOf,UnitNamesFile-method}


\title{Gets the indices of units by their names}

\description{
 Gets the indices of units by their names.
}

\usage{\method{indexOf}{UnitNamesFile}(this, pattern=NULL, names=NULL, ...)}

\arguments{
  \item{pattern}{A pattern to be used for identifying unit names of
     interest.  If \code{\link[base]{NULL}}, no regular expression matching is done.}
  \item{names}{Names to be match exactly to the unit names.}
  \item{...}{Not used.}
}

\value{
 Returns a \code{\link[base]{vector}} of \code{\link[base]{integer}}s in [1,N] where N is the number of units
 in the underlying annotation chip type file.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[aroma.core:getUnitNames.UnitNamesFile]{*getUnitNames}()}.
  For more information see \code{\link{UnitNamesFile}}.
}


\keyword{internal}
\keyword{methods}
\keyword{IO}
