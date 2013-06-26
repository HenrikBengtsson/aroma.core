%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaTransform.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{findFilesTodo.AromaTransform}
\alias{findFilesTodo.AromaTransform}
\alias{AromaTransform.findFilesTodo}
\alias{findFilesTodo,AromaTransform-method}

\title{Finds files in the data set still not processed}

\description{
 Finds files in the data set still not processed.
}

\usage{
\method{findFilesTodo}{AromaTransform}(this, ..., verbose=FALSE)
}

\arguments{
  \item{...}{Not used.}
  \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns a named \code{\link[base]{integer}} \code{\link[base]{vector}} specifying the indices of the files
 still not processed.
}

\author{Henrik Bengtsson}

\seealso{
  For more information see \code{\link{AromaTransform}}.
}
\keyword{internal}
\keyword{methods}
