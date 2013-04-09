%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  CacheKeyInterface.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getCacheKey.CacheKeyInterface}
\alias{getCacheKey.CacheKeyInterface}
\alias{CacheKeyInterface.getCacheKey}
\alias{getCacheKey,CacheKeyInterface-method}

\title{Gets a list of cache key items}

\description{
 Gets a list of cache key items that will be added to other cache key items used to
 generate the cache key.
}

\usage{
\method{getCacheKey}{CacheKeyInterface}(this, ...)
}

\arguments{
 \item{...}{Additional named arguments to be appended to the list
   of key items.}
}

\value{
 Returns a \code{\link[base]{list}} of cache items.
}

\details{
 The default list of cache key items are:
 \itemize{
  \item the class name of the object as a \code{\link[base]{character}} string.
 }

 Classes extending/implementing this \code{\link[R.oo]{Interface}} may
 override these items.
}

\author{Henrik Bengtsson}

\seealso{
  For more information see \code{\link{CacheKeyInterface}}.
}
\keyword{internal}
\keyword{methods}
