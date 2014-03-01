###########################################################################/**
# @RdocDefault downloadPackagePatch
#
# @title "Download a package patch [DEFUNCT]"
#
# \description{
#  @get "title" from the package online reprocitory.
#  By default, the patches are applied after being downloaded.
# }
#
# @synopsis
#
# \arguments{
#   \item{pkgName}{The name of the package to be patched."}
#   \item{version}{A @character string.}
#   \item{url}{The root URL from where to download the patch.}
#   \item{apply}{If @TRUE, the patches are applied immediately after
#      being downloaded.}
#   \item{rootPath}{The root path to the directory where to install patches.}
#   \item{pkgVer}{A optional @character string to "fake" the currently
#      installed version of the package. Use with great care.}
#   \item{...}{Not used.}
#   \item{verbose}{See @see "R.utils::Verbose".}
# }
#
# \value{
#   Returns (invisibly) the pathnames of the files downloaded.
# }
#
# @author
#
# \seealso{
#   @see "patchPackage"
# }
#
# @keyword internal
#*/###########################################################################
setMethodS3("downloadPackagePatch", "default", function(pkgName, version=NULL, url=NULL, apply=TRUE, rootPath="~/.Rpatches", pkgVer=NULL, ..., verbose=FALSE) {
  .Defunct(msg="downloadPackagePatch() is deprecated without alternatives.");
}, deprecated=TRUE) # downloadPackagePatch()


############################################################################
# HISTORY:
# 2014-02-28
# o CLEANUP: Defuncted previously deprecated downloadPackagePatch().
# 2008-03-11
# o Added argument 'pkgVer' allowing us to fake the package version.
# 2007-12-16
# o Added argument 'rootPath' to downloadPackagePatch() which is the root
#   directory where to store package patches.  The default is now to store
#   patches under ~/.Rpatches/ (previously it was './patches/').
# 2007-05-10
# o Added argument 'apply=TRUE' to downloadPackagePatch() so that downloaded
#   patches are applied immediately after being downloaded.
# 2007-02-28
# o Created.
############################################################################
