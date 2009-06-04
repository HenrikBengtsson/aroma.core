###########################################################################/**
# @RdocDefault downloadPackagePatch
#
# @title "Download a package patch"
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
  require("R.utils") || stop("Package not loaded: R.utils");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'pkgName':
  require(pkgName, character.only=TRUE) || stop("Package not loaded: ", pkgName);
  
  # Argument 'rootPath':
  rootPath <- Arguments$getWritablePath(rootPath);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Locate the patch URL
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (is.null(url)) {
    desc <- packageDescription(pkgName);
    for (field in c("PatchURL", "URL", "ContribURL", "DevelURL")) {
      url <- desc[[field]];
      if (!is.null(url))
        break;
    }
    if (is.null(url))
      throw("Failed to infer patch URL from DESCRIPTION file: ", pkgName);
  }

  # The complete patch URL
  rootUrl <- paste(url, "patches", pkgName, sep="/");
  verbose && cat(verbose, "Patch root URL: ", rootUrl);

  # Get the package version
  if (is.null(pkgVer)) {
    pkgVer <- packageDescription(pkgName)$Version;
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get the vector of files to be downloaded
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  url <- paste(rootUrl, "download.R", sep="/");
  files <- NULL;
  tryCatch({
    source(url, local=TRUE);
  }, error = function(ex) {
    cat("Failed to source: ", url, "\n", sep="");
    stop(ex$message);
  })

  if (is.null(files)) {
    msg <- paste("No patches available for ", pkgName, " v", 
                                              pkgVer, ".", sep="");
#    verbose && cat(verbose, msg);
    cat(msg, "\n", sep="");
    return(invisible(NULL));
  }

  version <- attr(files, "version");
  patchUrl <- paste(rootUrl, version, sep="/");
  verbose && cat(verbose, "Patch URL: ", patchUrl);

  path <- file.path(rootPath, pkgName, version);
  mkdirs(path);
  verbose && cat(verbose, "Download directory: ", path);

  verbose && cat(verbose, "Downloading ", length(files), " file(s):");
  verbose && print(verbose, files);

  for (file in files) {
    url <- paste(patchUrl, file, sep="/");
    verbose && enter(verbose, "Downloading ", file);
    pathname <- file.path(path, file);
    res <- download.file(url, pathname, cacheOK=FALSE);
    verbose && exit(verbose);
  }
  pathnames <- file.path(path, files);

  if (apply) {
    patchPackage(pkgName);
  }

  invisible(pathnames);
}) # downloadPackagePatch()


############################################################################
# HISTORY:
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
