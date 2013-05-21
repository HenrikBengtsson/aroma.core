%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Image.EXTS.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{as.GrayscaleImage.matrix}
\alias{as.GrayscaleImage.matrix}

\title{Creates a Grayscale (TrueColor) Image from a matrix file}

\description{
 Creates a Grayscale (TrueColor) Image from a matrix file.
}

\usage{
\method{as.GrayscaleImage}{matrix}(z, transforms=NULL, interleaved=c("none", "h", "v", "auto"), scale=1,
  ..., verbose=FALSE)
}

\arguments{
  \item{z}{A KxN \code{\link[base]{matrix}}.}
  \item{transforms}{A \code{\link[base]{list}} of transform \code{\link[base]{function}}s.}
  \item{interleaved}{A \code{\link[base]{character}} string specifying how the image data
    should be interleaved, if at all.}
  \item{scale}{A \code{\link[base]{numeric}} scale factor in (0,+Inf) for resizing the
    imaging. If \code{1}, no resizing is done.}
  \item{...}{Passed to \code{colorize()} for the object created.}
  \item{verbose}{A \code{\link[base]{logical}} or a \code{\link[R.utils]{Verbose}} object.}
}

\value{
  Returns a bitmap image object.
}

\author{Henrik Bengtsson, Ken Simpson}

\seealso{
  For more information see \code{\link{matrix}}.
}



\keyword{methods}
\keyword{IO}
\keyword{internal}
