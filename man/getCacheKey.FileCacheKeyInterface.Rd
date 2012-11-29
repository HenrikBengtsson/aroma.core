%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileCacheKeyInterface.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getCacheKey.FileCacheKeyInterface}
\alias{getCacheKey.FileCacheKeyInterface}
\alias{FileCacheKeyInterface.getCacheKey}
\alias{getCacheKey.FileCacheKeyInterface}
\alias{getCacheKey,FileCacheKeyInterface-method}


\title{Gets a list of cache key items}

\description{
 Gets a list of cache key items that will be added to other cache key items used to
 generate the cache key.
}

\usage{\method{getCacheKey}{FileCacheKeyInterface}(this, ...)}

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
  \item the file name (aka the basename) as a \code{\link[base]{character}} string.
  \item the file size as a \code{\link[base]{numeric}} scalar.
 }

 Classes extending/implementing this \code{\link[R.oo]{Interface}} may override
 these items.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{FileCacheKeyInterface}}.
}
\keyword{internal}
\keyword{methods}
