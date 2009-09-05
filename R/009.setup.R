.setupAromaCore <- function(pkg, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Patches
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Patch base::matrix() to be more memory efficient when 'dimnames==NULL'.
  .patchMatrix();

  # Patch log2()/log10() that are slow to display warnings
  .patchLog2();

  # Patch slow serialize() on Windows (speeds up digest() a lot!)
  .patchSerialize();

  # Get smoothScatter() for geneplotter (<= 1.21.4) if R (< 2.9.0).
  .patchSmoothScatter();


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Apply downloaded patches
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  patchPackage("aroma.core");


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Read settings file ".<name>Settings" and store it in package
  # variable '<name>Settings'.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  name <- "aroma";
  varName <- sprintf("%sSettings", name);
  basename <- paste(".", varName, sep="");
  settings <- AromaSettings$loadAnywhere(basename, verbose=TRUE);
  if (is.null(settings))
    settings <- AromaSettings(basename);
  assign(varName, settings, pos=getPosition(pkg));


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Assert that digest() gives a consistent result across R versions
  # and platforms.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!identical(getOption("aroma.core::assertDigest"), FALSE)) {
    .assertDigest("error");
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Fix the search path every time a package is loaded
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  setHook("base::library:onLoad", function(...) {
    # Fix the search path
    pkgs <- fixSearchPath(aroma.core);
    if (length(pkgs) > 0) {
      warning("Packages reordered in search path: ", 
                                            paste(pkgs, collapse=", "));
    }
  }, action="append");
} # .setupAromaCore()



############################################################################
# HISTORY:
# 2009-09-04
# o Now smoothScatter() is copying the one in 'geneplotter' v1.2.4 or older,
#   if not R v2.9.0.
# 2009-05-13
# o Now the search() path is fixed for aroma.core as well.
# 2009-02-22
# o Now R.utils Settings object 'aromaSettings' is loaded/assign.
# 2008-07-24
# o Added patch for serialize() on Windows.
# 2008-02-14
# o Renamed existing threshold hold to 'timestampsThreshold', 
#   'medianPolishThreshold', and 'skipThreshold'.
# 2008-02-12
# o Added default values for settings 'models$RmaPlm$...'.
# 2008-01-30
# o Added default values for settings 'rules$allowAsciiCdfs' and
#   'output$maxNbrOfArraysForTimestamps'.
# 2007-12-13
# o Added code for automatic updates on startup.  In active by default.
# o Added settings for 'checkForPatches' and 'checkInterval'.
# o Now the settings are set according to a tempate, if missing.
# 2007-08-30
# o Added "patch" to make sure that there is rowMedians() supporting 
#   missing values.
# 2007-07-04
# o Removed the patch for digest(); digest v0.3.0 solved the problem.
# o Added a patch of functions in 'base', e.g. matrix().
# 2007-04-04
# o Moved the patch of digest() here.
# 2007-03-07
# o Added test for consistency of digest().
# 2007-03-06
# o Added onLoad hook function for library() and require() to call
#   fixSearchPath() of the package, which reorders the search path so that
#   problematic packages are after this package in the search path.
# 2007-02-22
# o Added default settings stubs.
# 2007-02-12
# o Created.
############################################################################
