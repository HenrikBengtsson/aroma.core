# Dummy to please R CMD check
aromaSettings <- NULL

.loadSettings <- function(pkgname, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Read settings file ".<name>Settings" and store it in package
  # variable '<name>Settings'.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ...but don't load settings if running R CMD check
  name <- "aroma"
  varName <- sprintf("%sSettings", name)
  basename <- paste(".", varName, sep="")
  if (queryRCmdCheck() == "notRunning") {
    settings <- AromaSettings$loadAnywhere(basename, verbose=TRUE)
  } else {
    settings <- NULL
  }
  if (is.null(settings)) {
    settings <- AromaSettings(basename)
  }

  assign(varName, settings, envir=getNamespace(pkgname))
} # .loadSettings()


.setupAromaCore <- function(pkg, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Assert that digest() gives a consistent result across R versions
  # and platforms.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!identical(getOption("aroma.core::assertDigest"), FALSE)) {
    R.cache:::.assertDigest("error")
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Fix the search path every time a package is loaded
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  setHook("base::library:onLoad", function(...) {
    # Fix the search path
    pkgs <- fixSearchPath(aroma.core)
    if (length(pkgs) > 0L) {
      warning("Packages reordered in search path: ",
                                            paste(pkgs, collapse=", "))
    }
  }, action="append")
} # .setupAromaCore()
