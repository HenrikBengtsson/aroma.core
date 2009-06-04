setConstructorS3("AromaPlatformInterface", function(...) {
  extend(Interface(), "AromaPlatformInterface");
})


setMethodS3("getPlatform", "AromaPlatformInterface", abstract=TRUE);


setMethodS3("getAromaPlatform", "AromaPlatformInterface", function(this, ..., force=FALSE) {
  ap <- this$.ap;

  if (force || is.null(ap)) {
    platform <- getPlatform(this, ...);
    ap <- AromaPlatform$byName(platform, ...);
    this$.ap <- ap;
  }

  ap;
})



setMethodS3("getUnitNamesFile", "AromaPlatformInterface", function(this, force=FALSE, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local files
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  isCompatibleWith <- function(unf, ugp) {
    if (getPlatform(unf) != getPlatform(ugp))
      return(FALSE);
    if (getChipType(unf, fullname=FALSE) != getChipType(ugp, fullname=FALSE))
      return(FALSE);
    if (nbrOfUnits(unf) != nbrOfUnits(ugp))
      return(FALSE);
    TRUE;
  } # isCompatibleWith()

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  platform <- getPlatform(this);
  chipType <- getChipType(this, fullname=FALSE);
  chipTypeF <- getChipType(this);
  nbrOfUnits <- nbrOfUnits(this);

  unf <- this$.unf;
  if (force || is.null(unf)) {
    verbose && enter(verbose, "Locating a UnitNamesFile");
    verbose && cat(verbose, "Platform: ", platform);
    verbose && cat(verbose, "Chip type (fullname): ", chipTypeF);
    verbose && cat(verbose, "Chip type: ", chipType);
    verbose && cat(verbose, "Number of units: ", nbrOfUnits);

    unf <- NULL;

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Alt 1
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    verbose && enter(verbose, "Alt #1: Using an AromaPlatform object");

    verbose && enter(verbose, "Locating AromaPlatform object");
    aPlatform <- NULL;
    tryCatch({
      aPlatform <- getAromaPlatform(this);
      verbose && print(verbose, aPlatform);
    }, error=function(ex) {
#      warning("Could not find the AromaPlatform for this ", class(this)[1], " object: ", ex$message);
    });
    verbose && exit(verbose);

    if (!is.null(aPlatform)) {
      verbose && enter(verbose, "Searching for UnitNamesFile");
      tryCatch({
        unf <- getUnitNamesFile(aPlatform, chipType=chipTypeF, 
                        nbrOfUnits=nbrOfUnits, verbose=less(verbose,10));
        if (!isCompatibleWith(unf, this)) {
          unf <- NULL;
        }
      }, error=function(ex) {
        verbose && cat(verbose, "Could not locate UnitNamesFile: ", 
                                                             ex$message);
      });
      if (!is.null(unf)) {
        verbose && cat(verbose, "Found a matching UnitNamesFile:");
        verbose && print(verbose, unf);
      }
      verbose && exit(verbose);
    }
    verbose && exit(verbose);


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Alt 2
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    if (is.null(unf)) {
      verbose && enter(verbose, "Alt #2: Using known subclasses of UnitNamesFile");
      # Scan for known subclasses
      classNames <- getKnownSubclasses(UnitNamesFile);
      verbose && cat(verbose, "Known UnitNamesFile subclasses:");
      verbose && print(verbose, classNames);

      for (kk in seq(along=classNames)) {
        className <- classNames[kk];
        verbose && enter(verbose, sprintf("Search #%d of %d using %s$byChipType())", kk, length(classNames), className));
        clazz <- Class$forName(className);
        tryCatch({
          unf <- clazz$byChipType(chipType, nbrOfUnits=nbrOfUnits, ..., 
                                               verbose=less(verbose,10));
          if (!isCompatibleWith(unf, this)) {
            unf <- NULL;
          }
        }, error = function(ex) {});
        if (!is.null(unf)) {
          verbose && cat(verbose, "Found a matching UnitNamesFile:");
          verbose && print(verbose, unf);
          verbose && exit(verbose);
          break;
        }
        verbose && exit(verbose);
      } # for (kk ...)
      verbose && exit(verbose);
    } # if (is.null(unf))


    if (is.null(unf)) {
      throw("Failed to locate a UnitNamesFile for this chip type: ", chipType);
    }

    verbose && exit(verbose);

    this$.unf <- unf;
  } # if (force || is.null(unf))

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Sanity check
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  stopifnot(isCompatibleWith(unf, this));

  unf;
})




############################################################################
# HISTORY:
# 2009-05-19
# o Now getUnitNamesFile() searches using the fullname chip type.
#   Not happy though with the current ad hoc setup.
# 2009-05-11
# o Added rather generic getUnitNamesFile() for AromaPlatformInterface.
# 2008-06-12
# o Added abstract getPlatform().
# 2008-05-18
# o Created.
############################################################################
