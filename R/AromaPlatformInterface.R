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




# @title "Checks if a particular unit annotation data file is suitable for this AromaPlatformInterface class"
setMethodS3("isCompatibleWith", "AromaPlatformInterface", function(this, udf, ...) {
  if (getPlatform(this) != getPlatform(udf))
    return(FALSE);
  if (getChipType(this, fullname=FALSE) != getChipType(udf, fullname=FALSE))
    return(FALSE);

  # Compare nbrOfUnits only if there is a nbrOfUnits() method for 'this'.
  tryCatch({
    if (nbrOfUnits(this) != nbrOfUnits(udf))
      return(FALSE);
  }, error = function(ex) {});

  TRUE;
}, protected=TRUE)



setMethodS3("getUnitAnnotationDataFile", "AromaPlatformInterface", function(this, ..., className, force=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'className':
  className <- Arguments$getCharacter(className);
  clazz <- Class$forName(className);

  fcnName <- sprintf("get%s", className);
  if (!exists(fcnName, mode="function")) {
    throw(sprintf("No function %s() available: %s", fcnName, className));
  }
  FCN <- get(fcnName, mode="function");

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  platform <- getPlatform(this);
  chipType <- getChipType(this, fullname=FALSE);
  chipTypeF <- getChipType(this);

  # Compare nbrOfUnits?
  nbrOfUnits <- NULL;
  tryCatch({
    nbrOfUnits <- nbrOfUnits(this);
  }, error = function(ex) {});

  key <- className;
  udfList <- this$.udfList;
  if (!is.list(udfList)) udfList <- list();
  udf <- udfList[[key]];
  if (force || is.null(udf)) {
    verbose && enter(verbose, "Locating a ", className);
    verbose && cat(verbose, "Platform: ", platform);
    verbose && cat(verbose, "Chip type (fullname): ", chipTypeF);
    verbose && cat(verbose, "Chip type: ", chipType);
    verbose && cat(verbose, "Number of units: ", nbrOfUnits);

    udf <- NULL;

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
      verbose && enter(verbose, "Searching for ", className);
      tryCatch({
        udf <- FCN(aPlatform, chipType=chipTypeF, 
                        nbrOfUnits=nbrOfUnits, verbose=less(verbose,10));
        if (!isCompatibleWith(this, udf)) {
          udf <- NULL;
        }
      }, error=function(ex) {
        verbose && cat(verbose, "Could not locate ", className, ": ", 
                                                             ex$message);
      });
      if (!is.null(udf)) {
        verbose && cat(verbose, "Found a matching ", className, ":");
        verbose && print(verbose, udf);
      }
      verbose && exit(verbose);
    }
    verbose && exit(verbose);


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Alt 2
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    if (is.null(udf)) {
      verbose && enter(verbose, "Alt #2: Using known subclasses of ", className);
      # Scan for known subclasses
      classNames <- getKnownSubclasses(clazz);
      verbose && cat(verbose, "Known ", className, " subclasses (including itself):");
      classNames <- c(classNames, getName(clazz));

      for (kk in seq(along=classNames)) {
        className <- classNames[kk];
        verbose && enter(verbose, sprintf("Search #%d of %d using %s$byChipType())", kk, length(classNames), className));
        clazz <- Class$forName(className);
        tryCatch({
          udf <- clazz$byChipType(chipType, nbrOfUnits=nbrOfUnits, ..., 
                                               verbose=less(verbose,10));
          if (!isCompatibleWith(this, udf)) {
            udf <- NULL;
          }
        }, error = function(ex) {});
        if (!is.null(udf)) {
          verbose && cat(verbose, "Found a matching ", className, ":");
          verbose && print(verbose, udf);
          verbose && exit(verbose);
          break;
        }
        verbose && exit(verbose);
      } # for (kk ...)
      verbose && exit(verbose);
    } # if (is.null(udf))


    if (is.null(udf)) {
      throw("Failed to locate a ", className, " for this chip type: ", chipType);
    }

    verbose && exit(verbose);

    udfList[[key]] <- udf;
    this$.udfList <- udfList;

  } # if (force || is.null(udf))

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Sanity check
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  stopifnot(isCompatibleWith(this, udf));

  udf;
}, protected=TRUE)




setMethodS3("getUnitNamesFile", "AromaPlatformInterface", function(this, ...) {
  getUnitAnnotationDataFile(this, className="UnitNamesFile", ...);
})


setMethodS3("getUnitTypesFile", "AromaPlatformInterface", function(this, ...) {
  getUnitAnnotationDataFile(this, className="UnitTypesFile", ...);
})

setMethodS3("getAromaUgpFile", "AromaPlatformInterface", function(this, ...) {
  getUnitAnnotationDataFile(this, className="AromaUgpFile", ...);
})



############################################################################
# HISTORY:
# 2010-02-10
# o CLEANUP: Removed debug print() statements in isCompatibleWith().
# 2010-01-13
# o Now getUnitNamesFile() for AromaPlatformInterface utilizes the 
#   generic getUnitAnnotationDataFile() method.
# o AD HOC: Made getUnitAnnotationDataFile() work also when nbrOfUnits() 
#   does not exist for the class.
# o Added protected isCompatibleWith() for AromaPlatformInterface.  It
#   used to be an internal function before.
# o Added getAromaUgpFile() for AromaPlatformInterface.
# 2009-07-08
# o Added getUnitTypesFile() for AromaPlatformInterface.
# o Added "generic" getUnitAnnotationDataFile() for AromaPlatformInterface.
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
