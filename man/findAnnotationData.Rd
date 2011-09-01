%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  findAnnotationData.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{findAnnotationData}
\alias{findAnnotationData.default}
\alias{findAnnotationData}

 \title{Locates an annotation data file}

 \description{
  Locates an annotation data file.
 }

 \usage{\method{findAnnotationData}{default}(name=NULL, tags=NULL, set, pattern=NULL, private=FALSE, ..., firstOnly=TRUE, paths=NULL, verbose=FALSE)}

 \arguments{
   \item{name}{Optional \code{\link[base]{character}} string.}
   \item{tags}{Optional \code{\link[base]{character}} string.
     Only used if argument \code{pattern} is not specified.}
   \item{pattern}{A filename pattern to search for.
     If \code{\link[base]{NULL}}, then defaults to the fullname as defined by
     arguments \code{name} and \code{tags}.}
   \item{private}{If \code{\link[base:logical]{FALSE}}, files and directories starting
     with a periods are ignored.}
   \item{...}{Arguments passed to \code{\link[affxparser]{findFiles}}.}
   \item{firstOnly}{If \code{\link[base:logical]{TRUE}}, only the first matching pathname is returned.}
   \item{paths}{A \code{\link[base]{character}} \code{\link[base]{vector}} of paths to search.
     If \code{\link[base]{NULL}}, default paths are used.}
   \item{set}{A \code{\link[base]{character}} string specifying what type of annotation
     to search for.}
   \item{verbose}{A \code{\link[base]{logical}} or \code{\link[R.utils]{Verbose}}.}
 }

 \value{
   Returns \code{\link[base]{NULL}}, one or several matching pathnames.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}


\keyword{internal}
