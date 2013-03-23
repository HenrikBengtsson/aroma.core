%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitSignalBinarySet.writeDataFrame.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{writeDataFrame.AromaUnitSignalBinarySet}
\alias{writeDataFrame.AromaUnitSignalBinarySet}
\alias{AromaUnitSignalBinarySet.writeDataFrame}
\alias{writeDataFrame,AromaUnitSignalBinarySet-method}

\title{Writes the data set as a tab-delimited text file}

\description{
  Writes the data set as a tab-delimited text file with or without file header comments.

 \emph{We do neither recommend nor encourage the usage of this method;
  it is only available due to popular demand}.
  For more details, see below.
}

\usage{
\method{writeDataFrame}{AromaUnitSignalBinarySet}(this, filename=sprintf("\%s.txt", getFullName(this)), path=file.path(getRootName(this, tags = "*,txt"), getFullName(this), getChipType(this, fullname = FALSE)), ..., units=NULL, columns=c("unitName", "*"), sep="	", addHeader=TRUE, createdBy=NULL, nbrOfDecimals=4, ram=1, columnNamesPrefix=c("fullnames", "names", "none"), overwrite=FALSE, verbose=FALSE)
}

\arguments{
 \item{filename}{The filename of the generated file.}
 \item{path}{The path where the generated file should be written.}
 \item{...}{Not used.}
 \item{units}{The units to be written.  If \code{\link[base]{NULL}}, all units are considered.}
 \item{columns}{A \code{\link[base]{character}} \code{\link[base]{vector}} specifying which column names,
   including optional annotation data column names, that should be
   exported.  A string \code{"*"} corresponds to inserting
   the column names of the source data files.}
 \item{columnNamesPrefix}{A \code{\link[base]{character}} string specifying what type
   of prefix should be used for column names.}
  \item{verbose}{A \code{\link[base]{logical}} or a \code{\link[R.utils]{Verbose}} object.}
}

\value{
 Returns the written data set as a \code{\link{TabularTextFileSet}} object.
}

\section{Warning}{
 There is no limitation in how big the generated file can be.
 The bigger the data set is, the greater the file size will be.
 Because of this, \emph{we do neither recommend nor encourage the usage
 of this method}.  It is available only due to popular demand.
 Instead we recommend to write each file to a separate file.
 See \code{writeDataFrame()} of \code{\link{AromaUnitSignalBinaryFile}} for
 more information.
}

\author{Henrik Bengtsson}

\seealso{
 To write the data of one file, see \code{writeDataFrame()} for
 \code{\link{AromaUnitSignalBinaryFile}}.
 For more information see \code{\link{AromaUnitSignalBinarySet}}.
}
\keyword{internal}
\keyword{methods}
