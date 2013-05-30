%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  doCBS.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{doCBS}
\alias{doCBS.default}
\alias{doCBS}
\alias{doCBS.CopyNumberDataSetTuple}
\alias{doCBS.CopyNumberDataSet}
\alias{doCBS.character}

\title{Performs Circular Binary Segmentation (CBS) on a data set}

\description{
 Performs Circular Binary Segmentation (CBS) on a data set for one or more chip types.
}

\usage{
  \method{doCBS}{default}(dataSet, tags=NULL, chipTypes, arrays=NULL, ..., verbose=FALSE)
  \method{doCBS}{CopyNumberDataSet}(ds, arrays=NULL, ...)
  \method{doCBS}{CopyNumberDataSetTuple}(dsTuple, arrays=NULL, ..., verbose=FALSE)
}

\arguments{
 \item{ds, dsTuple, dataSet}{A \code{\link{CopyNumberDataSet}}, a \code{\link{CopyNumberDataSetTuple}} or a \code{\link[base]{character}} string with the name of one of them.}
  \item{tags}{An optional \code{\link[base]{character}} \code{\link[base]{vector}} of data set tags (only when \code{dataSet} is specified).}
  \item{chipTypes}{A \code{\link[base]{character}} \code{\link[base]{vector}} specifying the chip types
    for the different data sets (only when \code{dataSet} is specified).}
  \item{arrays}{An optional \code{\link[base]{vector}} specifying the subset of arrays to process.}
  \item{...}{Additional arguments passed to \code{\link{CbsModel}} and
    its \code{fit()} method.}
  \item{verbose}{A \code{\link[base]{logical}} or \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns the output dataset of \code{\link{CbsModel}}.
}

\examples{\dontrun{
 
dataSet <- "GSE20939"
tags <- "ACC,-XY,BPN,-XY,RMA,FLN,-XY"
chipTypes <- c("Mapping250K_Nsp", "Mapping250K_Sty")
fit <- doCBS(dataSet, tags=tags, chipTypes=chipTypes, verbose=-10)
print(fit)

}}

\author{Henrik Bengtsson}

