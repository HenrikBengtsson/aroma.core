%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RawGenomicSignals.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{estimateStandardDeviation.RawGenomicSignals}
\alias{estimateStandardDeviation.RawGenomicSignals}
\alias{RawGenomicSignals.estimateStandardDeviation}
\alias{estimateStandardDeviation.RawGenomicSignals}
\alias{estimateStandardDeviation,RawGenomicSignals-method}


\title{Estimates the standard deviation of the raw Ys}

\description{
 Estimates the standard deviation of the raw Ys robustly or non-robustly using either a "direct" estimator
 or a first-order difference estimator.
}

\usage{\method{estimateStandardDeviation}{RawGenomicSignals}(this, field=NULL, method=c("diff", "direct"), estimator=c("mad", "sd"), na.rm=TRUE, weights=getWeights(this), ...)}

\arguments{
  \item{field}{A \code{\link[base]{character}} specifying the field to estimate.}
  \item{method}{If \code{"diff"}, the estimate is based on the first-order
    contigous differences of raw Ys. If \code{"direct"}, it is based
    directly on the raw Ys.}
  \item{estimator}{If \code{"mad"}, the robust \code{\link[stats]{mad}} estimator
    is used.  If \code{"sd"}, the \code{\link[stats]{sd}} estimator is used.}
  \item{na.rm}{If \code{\link[base:logical]{TRUE}}, missing values are excluded first.}
  \item{weights}{Locus specific weights.}
  \item{...}{Not used.}
}

\value{
 Returns a non-negative \code{\link[base]{numeric}} value.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[base]{diff}}(), \code{\link[stats]{sd}}, and \code{\link[stats]{mad}}.
  For more information see \code{\link{RawGenomicSignals}}.
}



\keyword{internal}
\keyword{methods}
\keyword{IO}
\keyword{programming}
