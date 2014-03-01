###########################################################################/**
# @RdocDefault patchPackage
#
# @title "Applies patches for a specific package [DEFUNCT]"
#
# \description{
#  @get "title" from the package online reprocitory.
# }
#
# @synopsis
#
# \arguments{
#   \item{pkgName}{The name of the package to be patched."}
#   \item{paths}{A @character @vector of paths containing package patches.}
#   \item{deleteOld}{If @TRUE, old patch directories are deleted.}
#   \item{verbose}{See @see "R.utils::Verbose".}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns the number of files sourced.
# }
#
# @author
#
# \seealso{
#   @see "downloadPackagePatch"
# }
#
# @keyword internal
#*/###########################################################################
setMethodS3("patchPackage", "default", function(pkgName, paths=c("~/.Rpatches/", "patches/"), deleteOld=TRUE, verbose=FALSE, ...) {
  .Defunct(msg="patchPackage() is deprecated without alternatives.");
}, deprecated=TRUE) # patchPackage()


############################################################################
# HISTORY:
# 2014-02-28
# o CLEANUP: Defuncted previously deprecated downloadPackagePatch().
# 2008-05-21
# o BUG FIX: Argument 'deleteOld' was passed to Arguments$getVerbose().
# 2008-05-09
# o BUG FIX: The package date was hardwired to the aroma.affymetrix package.
# 2007-12-16
# o Added ~/.Rpatches/ to the set of default directories of patchPackage().
# 2007-05-10
# o Now patchPackage(..., deleteOld=TRUE) removes not only old patches, but
#   also patches that are older than the package itself.
# 2007-02-28
# o Created.
############################################################################
