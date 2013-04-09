%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaRepository.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{downloadFile.AromaRepository}
\alias{downloadFile.AromaRepository}
\alias{AromaRepository.downloadFile}
\alias{downloadFile,AromaRepository-method}

\title{Download a particular file from the reposity}

\description{
 Download a particular file from the reposity by its relative pathname.
}

\usage{
\method{downloadFile}{AromaRepository}(this, filename, path=NULL, caseSensitive=FALSE, gzipped=TRUE, skip=TRUE, overwrite=FALSE, ..., verbose=getVerbose(this))
}

\arguments{
  \item{filename, path}{The filename and the relative path of the file
        to be download.}
  \item{gzipped}{If \code{\link[base:logical]{TRUE}}, a gzipped file is downloaded and decompressed.}
  \item{skip}{If \code{\link[base:logical]{TRUE}}, an already downloaded file is skipped.}
  \item{overwrite}{If \code{\link[base:logical]{TRUE}}, an not skipping, an already downloaded file
     is overwritten, otherwise an error is thrown.}
  \item{...}{Additional arguments passed to \code{\link[R.utils]{downloadFile}}.}
  \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns the pathname of the uncompressed downloaded file.
}

\author{Henrik Bengtsson}

\seealso{
  For more information see \code{\link{AromaRepository}}.
}
\keyword{internal}
\keyword{methods}
