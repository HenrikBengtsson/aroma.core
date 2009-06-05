%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaTransform.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getPath.AromaTransform}
\alias{getPath.AromaTransform}
\alias{AromaTransform.getPath}
\alias{getPath.AromaTransform}
\alias{getPath,AromaTransform-method}


\title{Gets the path of the output data set}

\description{
 Gets the path of the output data set.
 If non-existing, then the directory is created.
 Windows Shortcut links are recognized.
}

\usage{\method{getPath}{AromaTransform}(this, create=TRUE, ...)}

\arguments{
  \item{create}{If \code{\link[base:logical]{TRUE}}, the path is created, otherwise not.}
  \item{...}{Not used.}
}

\value{
 Returns a \code{\link[base]{character}} string.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{AromaTransform}}.
}
\keyword{internal}
\keyword{methods}
