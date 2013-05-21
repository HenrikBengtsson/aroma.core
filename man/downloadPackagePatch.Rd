%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  999.DEPRECATED,downloadPackagePatch.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{downloadPackagePatch}
\alias{downloadPackagePatch.default}
\alias{downloadPackagePatch}

 \title{Download a package patch}

 \description{
  Download a package patch from the package online reprocitory.
  By default, the patches are applied after being downloaded.
 }

 \usage{
\method{downloadPackagePatch}{default}(pkgName, version=NULL, url=NULL, apply=TRUE, rootPath="~/.Rpatches",
  pkgVer=NULL, ..., verbose=FALSE)
}

 \arguments{
   \item{pkgName}{The name of the package to be patched."}
   \item{version}{A \code{\link[base]{character}} string.}
   \item{url}{The root URL from where to download the patch.}
   \item{apply}{If \code{\link[base:logical]{TRUE}}, the patches are applied immediately after
      being downloaded.}
   \item{rootPath}{The root path to the directory where to install patches.}
   \item{pkgVer}{A optional \code{\link[base]{character}} string to "fake" the currently
      installed version of the package. Use with great care.}
   \item{...}{Not used.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 }

 \value{
   Returns (invisibly) the pathnames of the files downloaded.
 }

 \author{Henrik Bengtsson}

 \seealso{
   \code{\link{patchPackage}}()
 }


\keyword{internal}
