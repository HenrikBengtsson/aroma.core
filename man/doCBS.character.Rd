%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  doCBS.character.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{doCBS.character}
\alias{doCBS.character}

\title{Performs CBS segmentation on a data set}

\description{
 Performs CBS segmentation on a data set for one or more chip types.
}

\usage{
\method{doCBS}{character}(dataSets, tags=NULL, chipTypes, ..., verbose=FALSE)
}

\arguments{
  \item{dataSets}{A \code{\link[base]{character}} string specifying the data set(s).}
  \item{tags}{And optional \code{\link[base]{character}} \code{\link[base]{vector}} of data set tags.}
  \item{chipTypes}{A \code{\link[base]{character}} \code{\link[base]{vector}} specifying the chip types
    to be used and merged.}
  \item{...}{Additional arguments passed to ...}
  \item{verbose}{A \code{\link[base]{logical}} or \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns a ...
}

\examples{\dontrun{
  library("aroma.cn");
verbose <- Arguments$getVerbose(-8, timestamp=TRUE);

dataSet <- "GSE20939";
tags <- "ACC,-XY,BPN,-XY,RMA,FLN,-XY";
chipTypes <- c("Mapping250K_Nsp", "Mapping250K_Sty");
fit <- doCBS(dataSet, tags=tags, chipTypes=chipTypes, verbose=verbose);
print(fit);

}}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{character}}.
}
\keyword{methods}
