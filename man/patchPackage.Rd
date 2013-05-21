%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  999.DEPRECATED,patchPackage.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{patchPackage}
\alias{patchPackage.default}
\alias{patchPackage}

 \title{Applies patches for a specific package}

 \description{
  Applies patches for a specific package from the package online reprocitory.
 }

 \usage{
\method{patchPackage}{default}(pkgName, paths=c("~/.Rpatches/", "patches/"), deleteOld=TRUE, verbose=FALSE,
  ...)
}

 \arguments{
   \item{pkgName}{The name of the package to be patched."}
   \item{paths}{A \code{\link[base]{character}} \code{\link[base]{vector}} of paths containing package patches.}
   \item{deleteOld}{If \code{\link[base:logical]{TRUE}}, old patch directories are deleted.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
   \item{...}{Not used.}
 }

 \value{
   Returns the number of files sourced.
 }

 \author{Henrik Bengtsson}

 \seealso{
   \code{\link{downloadPackagePatch}}()
 }


\keyword{internal}
