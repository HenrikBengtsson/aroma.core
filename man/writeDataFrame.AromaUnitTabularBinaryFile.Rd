%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitTabularBinaryFile.writeDataFrame.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{writeDataFrame.AromaUnitTabularBinaryFile}
\alias{writeDataFrame.AromaUnitTabularBinaryFile}
\alias{AromaUnitTabularBinaryFile.writeDataFrame}
\alias{writeDataFrame.AromaUnitTabularBinaryFile}
\alias{writeDataFrame,AromaUnitTabularBinaryFile-method}


\title{Writes the data file as a tab-delimited text file}

\description{
  Writes the data file as a tab-delimited text file with or without file header comments.
}

\usage{\method{writeDataFrame}{AromaUnitTabularBinaryFile}(this, filename=sprintf("\%s.txt", getFilename(this)), path=file.path(getRootName(this, tags = "*,txt"), getFullName(this), getChipType(this, fullname = FALSE)), ..., columns=c("unitName", "*"), sep="	", addHeader=TRUE, createdBy=NULL, nbrOfDecimals=4, columnNamesPrefix=c("fullnames", "names", "none"), overwrite=FALSE, verbose=FALSE)}

\arguments{
 \item{filename}{The filename of generated file.}
 \item{path}{The path where the generated file should be written.}
 \item{...}{Not used.}
 \item{columns}{A \code{\link[base]{character}} \code{\link[base]{vector}} specifying which column names,
   including optional annotation data column names, that should be
   exported.  A string \code{"*"} corresponds to inserting
   the column names of the source data file.}
 \item{sep}{A \code{\link[base]{character}} string specifying the column separator}.
 \item{addHeader}{If \code{\link[base:logical]{TRUE}}, file header comments will be added that
   contain additional information about the source file and more.}
 \item{createdBy}{A \code{\link[base]{character}} string specifying the \code{createdBy}
   file header comment. If \code{\link[base]{NULL}}, the package version will be written.}
 \item{nbrOfDecimals}{An \code{\link[base]{integer}} specifying the number of decimals
   for floating point columns.}
 \item{sep}{A \code{\link[base]{character}} string specifying the column separator}.
 \item{columnNamesPrefix}{A \code{\link[base]{character}} string specifying what type
   of prefix should be used for column names.}
 \item{overwrite}{If \code{\link[base:logical]{TRUE}}, an existing destination file will be
   overwritten, otherwise an exception will be thrown.}
  \item{verbose}{A \code{\link[base]{logical}} or a \code{\link[R.utils]{Verbose}} object.}
}

\value{
 Returns the write data file as a \code{\link{TabularTextFile}} object.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
 For more information see \code{\link{AromaUnitTabularBinaryFile}}.
}
\keyword{internal}
\keyword{methods}
