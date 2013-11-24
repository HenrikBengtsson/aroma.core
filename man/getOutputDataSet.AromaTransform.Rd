%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaTransform.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getOutputDataSet.AromaTransform}
\alias{getOutputDataSet.AromaTransform}
\alias{AromaTransform.getOutputDataSet}
\alias{getOutputDataSet,AromaTransform-method}

\title{Gets the transformed data set}

\description{
 Gets the transformed data set, if processed.
}

\usage{
\method{getOutputDataSet}{AromaTransform}(this, onMissing=c("dropall", "drop", "NA", "error"), ...,
  incomplete=FALSE, className=NULL, force=FALSE, verbose=FALSE)
}

\arguments{
 \item{...}{Arguments passed to static method \code{byPath()} of
  the class of the input \code{\link{AromaMicroarrayDataSet}}.}
 \item{onMissing}{A \code{\link[base]{character}} string specifying how non-processed files
  should be returned.
  If \code{"drop"}, they are ignored and not part of the returned
  data set.
  If \code{"dropall"}, \code{\link[base]{NULL}} is returned unless all files are processed.
  If \code{"NA"}, they are represented as a "missing" file.
  If \code{"error"}, they are not accepted and an exception is thrown.
 }
 \item{incomplete}{[DEPRECATED] If the output data set is incomplete,
  then \code{\link[base]{NULL}} is returned unless \code{incomplete} is \code{\link[base:logical]{TRUE}}.}
 \item{force}{If \code{\link[base:logical]{TRUE}}, any in-memory cached results are ignored.}
 \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns an \code{\link{AromaMicroarrayDataSet}} or \code{\link[base]{NULL}}.
}

\author{Henrik Bengtsson}

\seealso{
  For more information see \code{\link{AromaTransform}}.
}
\keyword{internal}
\keyword{methods}
