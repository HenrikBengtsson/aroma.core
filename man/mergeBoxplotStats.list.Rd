%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  mergeBoxplotStats.list.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 \name{mergeBoxplotStats.list}
\alias{mergeBoxplotStats.list}
\alias{mergeBoxplotStats.list}


 \title{Merges a list of boxplot.stats() elements}

 \description{
  Merges a list of boxplot.stats() elements.
 }

 \usage{\method{mergeBoxplotStats}{list}(stats, ...)}

 \arguments{
   \item{stats}{A \code{\link[base]{list}} of elements each in a format returned by
      \code{\link[grDevices]{boxplot.stats}}.}
   \item{...}{Not used.}
 }

 \value{
   Returns a \code{\link[base]{list}} structure in a format that is returned by
   \code{\link[graphics]{boxplot}}.
 }

 \examples{
require("stats")

x <- matrix(rnorm(1000), ncol=5)
x <- as.data.frame(x)

stats0 <- boxplot(x, plot=FALSE)
stats1 <- lapply(x, FUN=boxplot.stats)
stats1b <- mergeBoxplotStats(stats1)
stopifnot(all.equal(stats0, stats1b))

bxp(stats1b)

}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}


\keyword{methods}
\keyword{internal}
