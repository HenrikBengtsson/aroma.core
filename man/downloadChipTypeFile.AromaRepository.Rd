%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaRepository.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{downloadChipTypeFile.AromaRepository}
\alias{downloadChipTypeFile.AromaRepository}
\alias{AromaRepository.downloadChipTypeFile}
\alias{downloadChipTypeFile.AromaRepository}
\alias{downloadChipTypeFile,AromaRepository-method}


\title{Download a particular chip type annotation file}

\description{
 Download a particular chip type annotation file by its chip type, tags and suffix.
}

\usage{\method{downloadChipTypeFile}{AromaRepository}(this, chipType, tags=NULL, suffix=sprintf(".\%s", ext), ext=NULL, ..., gunzip=TRUE, skip=TRUE, overwrite=FALSE, mustExist=TRUE, verbose=getVerbose(this))}

\arguments{
  \item{chipType}{The chip type of the file to be downloaded.}
  \item{tags}{Optional tags of the file to be downloaded.}
  \item{suffix}{The filename suffix (including any preceeding period) of
     the file to be downloaded.}
  \item{ext}{The filename extension.}
  \item{...}{Additional arguments passed to \code{\link[aroma.core:downloadFile.AromaRepository]{*downloadFile}()}.}
  \item{skip}{If \code{\link[base:logical]{TRUE}}, an already downloaded file is skipped.}
  \item{overwrite}{If \code{\link[base:logical]{TRUE}}, an not skipping, an already downloaded file
     is overwritten, otherwise an error is thrown.}
  \item{mustExist}{If \code{\link[base:logical]{TRUE}}, an exception is thrown if no file matching
     is available either locally or on the repository.}
  \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns the relative pathname of the uncompressed downloaded file.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{AromaRepository}}.
}
\keyword{internal}
\keyword{methods}
