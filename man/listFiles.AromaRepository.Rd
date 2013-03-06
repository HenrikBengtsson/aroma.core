%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaRepository.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{listFiles.AromaRepository}
\alias{listFiles.AromaRepository}
\alias{AromaRepository.listFiles}
\alias{listFiles,AromaRepository-method}

\title{Retrieves the files available on the repository under a particular path}

\description{
 Retrieves the files available on the repository under a particular path.
}

\usage{
\method{listFiles}{AromaRepository}(this, path=NULL, full=TRUE, orderBy=c("name", "time"), ..., force=FALSE, verbose=getVerbose(this))
}

\arguments{
  \item{path}{The relative path to be listed.}
  \item{orderBy}{A \code{\link[base]{character}} specifying how the returns files should be ordered.}
  \item{...}{Additional arguments passed to \code{\link[R.utils]{downloadFile}}.}
  \item{force}{If @FTRUE, cached results are redownloaded, otherwise not.}
}

\value{
 Returns the relative pathnames of the files available.
}

\details{
  Note that this method makes strong assumptions of the format of the
  downloaded HTML index file.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{AromaRepository}}.
}
\keyword{internal}
\keyword{methods}
