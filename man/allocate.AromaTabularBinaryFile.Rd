%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaTabularBinaryFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{AromaTabularBinaryFile$allocate}
\alias{AromaTabularBinaryFile$allocate}
\alias{allocate.AromaTabularBinaryFile}
\alias{AromaTabularBinaryFile.allocate}
\alias{allocate,AromaTabularBinaryFile-method}

\title{Creates an AromaTabularBinaryFile}

\description{
 Creates an AromaTabularBinaryFile of a certain dimension and data column types.
}

\usage{
## Static method (use this):
## AromaTabularBinaryFile$allocate(filename, path=NULL, nbrOfRows, types, sizes, signeds=TRUE, defaults=NA, comment=NULL, overwrite=FALSE, skip=FALSE, footer=list(), ..., verbose=FALSE)

## Don't use the below:
\method{allocate}{AromaTabularBinaryFile}(static, filename, path=NULL, nbrOfRows, types, sizes, signeds=TRUE, defaults=NA, comment=NULL, overwrite=FALSE, skip=FALSE, footer=list(), ..., verbose=FALSE)
}

\arguments{
  \item{filename}{The filename of the new file.}
  \item{path}{The path where to store the new file.}
  \item{nbrOfRows}{An \code{\link[base]{integer}} specifying the number of rows to allocate.}
  \item{types}{A \code{\link[base]{character}} \code{\link[base]{vector}} specifying the data type of each
     column.  The length specifies the number of columns to allocate.}
  \item{sizes}{An \code{\link[base]{integer}} \code{\link[base]{vector}} of values in \{1,2,4,8\} specifying
     the size of each column (data type).}
  \item{signeds}{An \code{\link[base]{logical}} \code{\link[base]{vector}} specifying if the data types in each
     column is signed or not.}
  \item{defaults}{An optional \code{\link[base]{list}} (or \code{\link[base]{vector}}) containing default
     values for each column.}
  \item{comment}{An optional \code{\link[base]{character}} string written to the file header.}
  \item{overwrite}{If \code{\link[base:logical]{TRUE}}, an existing file is overwritten, otherwise not.}
  \item{skip}{If \code{\link[base:logical]{TRUE}} and \code{overwrite=TRUE}, any existing file is
     returned as is.}
  \item{footer}{An optional \code{\link[base]{list}} of attributes written (as character
     strings) to the file footer.}
  \item{...}{Not used.}
  \item{verbose}{\code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns a \code{\link{AromaTabularBinaryFile}} object.
}

\section{Data types}{
  Valid data types are currently "\code{\link[base]{integer}}" and "\code{\link[base]{double}}".
}

\author{Henrik Bengtsson}

\seealso{
  For more information see \code{\link{AromaTabularBinaryFile}}.
}


\keyword{internal}
\keyword{methods}
\keyword{IO}
