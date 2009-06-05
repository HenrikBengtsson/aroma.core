%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaMicroarrayDataSetTuple.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{extract.AromaMicroarrayDataSetTuple}
\alias{extract.AromaMicroarrayDataSetTuple}
\alias{AromaMicroarrayDataSetTuple.extract}
\alias{extract.AromaMicroarrayDataSetTuple}
\alias{extract,AromaMicroarrayDataSetTuple-method}


\title{Extracts a subset AromaMicroarrayDataSetTuple}

\description{
 Extracts a subset AromaMicroarrayDataSetTuple.
}

\usage{\method{extract}{AromaMicroarrayDataSetTuple}(this, arrays, ..., verbose=FALSE)}

\arguments{
  \item{arrays}{A \code{\link[base]{vector}} of arrays to be extracted.}
  \item{...}{Not used.}
}

\value{
 Returns a \code{\link{AromaMicroarrayDataSetTuple}}.
}

\details{
  If no matching arrays are available for a given chip type, that chip type
  is excluded in the returned set tuple.  This guarantees that a set tuple
  always contains existing arrays.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{AromaMicroarrayDataSetTuple}}.
}
\keyword{internal}
\keyword{methods}
