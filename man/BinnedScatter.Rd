%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  BinnedScatter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{BinnedScatter}
\docType{class}
\alias{BinnedScatter}


\title{The BinnedScatter class}

\description{
 Package:  aroma.core \cr
\bold{Class BinnedScatter}\cr

\code{list}\cr
\code{~~|}\cr
\code{~~+--}\code{BinnedScatter}\cr

\bold{Directly known subclasses:}\cr
\cr

public class \bold{BinnedScatter}\cr
extends list\cr


}

\usage{
BinnedScatter(data=NULL, density=NULL, map=NULL, params=NULL)
}

\arguments{
  \item{data}{A Nx2 \code{\link[base]{numeric}} \code{\link[base]{matrix}}.}
  \item{density}{...}
  \item{map}{...}
  \item{params}{A \code{\link[base]{list}} of parameters.}
  \item{...}{Not used.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{plot} \tab  -\cr
 \tab \code{points} \tab  -\cr
 \tab \code{reorder} \tab  -\cr
 \tab \code{subsample} \tab  -\cr
 \tab \code{subset} \tab  -\cr
}


 \bold{Methods inherited from list}:\cr
Ops,nonStructure,vector-method, Ops,structure,vector-method, Ops,vector,nonStructure-method, Ops,vector,structure-method, all.equal, as.CopyNumberDataSetTuple, as.data.frame, attachLocally, callHooks, coerce,ANY,list-method, exportAromaUnitPscnBinarySet, listToXml, mergeBoxplotStats, relist, type.convert, within


}

\examples{
# Sample scatter data
n <- 10e3
x <- rnorm(n=n)
y <- rnorm(n=n)
xy <- cbind(x=x, y=sin(x)+y/5)

# Bin data and estimate densities
xyd <- binScatter(xy)

layout(matrix(1:4, nrow=2))
par(mar=c(5,4,2,1))

# Plot data
plot(xyd, pch=1)

# Thin scatter data by subsampling
rhos <- c(1/3, 1/4, 1/6)
for (kk in seq_along(rhos)) {
  xyd2 <- subsample(xyd, size=rhos[kk])
  points(xyd2, pch=1, col=kk+1)
}

for (kk in seq_along(rhos)) {
  xyd2 <- subsample(xyd, size=rhos[kk])
  plot(xyd2, pch=1, col=kk+1)
  mtext(side=3, line=0, sprintf("Density: \%.1f\%\%", 100*rhos[kk]))
}
}

\author{Henrik Bengtsson}

\seealso{
  The spatial density is estimated by internal functions of the
  \pkg{smoothScatter} package.
}
\keyword{classes}
