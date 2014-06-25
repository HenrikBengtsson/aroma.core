%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaPlatformInterface.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getUnitAnnotationDataFile.AromaPlatformInterface}
\alias{getUnitAnnotationDataFile.AromaPlatformInterface}
\alias{AromaPlatformInterface.getUnitAnnotationDataFile}
\alias{getUnitAnnotationDataFile,AromaPlatformInterface-method}
\alias{AromaPlatformInterface.getUnitNamesFile}
\alias{getUnitNamesFile.AromaPlatformInterface}
\alias{getUnitNamesFile,AromaPlatformInterface-method}

\alias{AromaPlatformInterface.getUnitTypesFile}
\alias{getUnitTypesFile.AromaPlatformInterface}
\alias{getUnitTypesFile,AromaPlatformInterface-method}

\alias{AromaPlatformInterface.getAromaUgpFile}
\alias{getAromaUgpFile.AromaPlatformInterface}
\alias{getAromaUgpFile,AromaPlatformInterface-method}


\title{Gets a unit annotation data file of a particular class}

\description{
 Gets a unit annotation data file of a particular class for this AromaPlatformInterface.
}

\usage{
\method{getUnitAnnotationDataFile}{AromaPlatformInterface}(this, ..., className, force=FALSE, verbose=FALSE)
}

\arguments{
  \item{...}{Additional arguments passed to \code{byChipType()} for the
   class of interest.}
  \item{className}{A \code{\link[base]{character}} string specifying the class of interest.}
  \item{force}{If \code{\link[base:logical]{TRUE}}, any cached results are ignored, otherwise not.}
  \item{verbose}{The \code{\link[R.utils]{Verbose}} to be used during processing.}
}

\value{
 Returns \code{\link[base:logical]{TRUE}} if compatible and \code{\link[base:logical]{FALSE}} otherwise.
}

\author{Henrik Bengtsson}

\seealso{
  \code{\link[aroma.core:getPlatform.AromaPlatformInterface]{*getPlatform}()}.
  For more information see \code{\link{AromaPlatformInterface}}.
}
\keyword{internal}
\keyword{methods}
