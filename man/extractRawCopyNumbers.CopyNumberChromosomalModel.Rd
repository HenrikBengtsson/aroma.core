%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  CopyNumberChromosomalModel.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{extractRawCopyNumbers.CopyNumberChromosomalModel}
\alias{extractRawCopyNumbers.CopyNumberChromosomalModel}
\alias{CopyNumberChromosomalModel.extractRawCopyNumbers}
\alias{extractRawCopyNumbers,CopyNumberChromosomalModel-method}

\title{Extracts relative copy numbers}

\description{
 Extracts relative copy numbers for a particular array and chromosome.
}

\usage{
\method{extractRawCopyNumbers}{CopyNumberChromosomalModel}(this, array, chromosome, ..., logBase=2, cache=FALSE, force=FALSE, verbose=FALSE)
}

\arguments{
  \item{array}{The index of the array to be extracted.}
  \item{chromosome}{The index of the chromosome to be extracted.}
  \item{...}{See subclasses.}
  \item{logBase}{(optional) The base of the logarithm used for the ratios.
   If \code{\link[base]{NULL}}, the ratios are not logged.}
  \item{cache}{If \code{\link[base:logical]{TRUE}}, results are cached, otherwise not.}
  \item{force}{If \code{\link[base:logical]{TRUE}}, cached results are ignored.}
  \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
}

\value{
 See subclasses.
}

\author{Henrik Bengtsson}

\seealso{
  For more information see \code{\link{CopyNumberChromosomalModel}}.
}
\keyword{internal}
\keyword{methods}
