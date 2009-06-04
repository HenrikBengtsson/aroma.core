setConstructorS3("AromaUnitChromosomeTabularBinaryFile", function(...) {
  this <- extend(AromaUnitTabularBinaryFile(...), "AromaUnitChromosomeTabularBinaryFile",
    "cached:.memoryCache" = list(),
    .chromosomes=NULL
  );

  # Parse attributes (all subclasses must call this in the constructor).
  if (!is.null(this$.pathname))
    setAttributesByTags(this);

  this;
}, abstract=TRUE)


setMethodS3("clearCache", "AromaUnitChromosomeTabularBinaryFile", function(this, ...) {
  # Clear all cached values.
  for (ff in c(".memoryCache")) {
    this[[ff]] <- NULL;
  }

  # Then for this object
  NextMethod(generic="clearCache", object=this, ...); 
}, private=TRUE) 


setMethodS3("getGenomeVersion", "AromaUnitChromosomeTabularBinaryFile", function(this, ...) {
  tags <- getTags(this, ...);
  tags <- grep("^hg", tags, value=TRUE);
  tags;
}, protected=TRUE)



setMethodS3("getFilenameExtension", "AromaUnitChromosomeTabularBinaryFile", abstract=TRUE);


setMethodS3("getColumnNames", "AromaUnitChromosomeTabularBinaryFile", abstract=TRUE);


setMethodS3("indexOfColumn", "AromaUnitChromosomeTabularBinaryFile", function(this, name, ...) {
  cc <- whichVector(getColumnNames(this) == name);
  cc <- Arguments$getIndex(cc);
  cc;
}, protected=TRUE)


setMethodS3("getChromosomes", "AromaUnitChromosomeTabularBinaryFile", function(this, force=FALSE, .chromosomes=NULL, ...) {
  chromosomes <- this$.chromosomes;
  if (force || is.null(chromosomes)) {
    chromosomes <- .chromosomes;
    if (is.null(chromosomes)) {
      cc <- indexOfColumn(this, "chromosome");
      chromosomes <- this[,cc,drop=TRUE];
    }
    chromosomes <- unique(chromosomes);
    chromosomes <- chromosomes[!is.na(chromosomes)];
    chromosomes <- sort(chromosomes);
    this$.chromosomes <- chromosomes;
  }
  chromosomes;
})


setMethodS3("readDataFrame", "AromaUnitChromosomeTabularBinaryFile", function(this, ..., verbose=FALSE) {
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  data <- NextMethod("readDataFrame", this, ..., verbose=less(verbose));

  if (nrow(data) > 0) {
    verbose && enter(verbose, "Converting zeros to NAs");
    # Interpret zeros as NAs
    if (ncol(data) > 0) {
      for (cc in seq(length=ncol(data))) {
        nas <- (!is.na(data[,cc]) & (data[,cc] == 0));
        data[nas,cc] <- NA;
      }
    }
    verbose && exit(verbose);
  }

  data;
})



setMethodS3("getUnitsOnChromosomes", "AromaUnitChromosomeTabularBinaryFile", function(this, chromosomes=getChromosomes(this), ..., unlist=FALSE, useNames=TRUE) {
  # Argument 'chromosomes':
  chromosomes <- Arguments$getIndices(chromosomes);

  # Argument 'unlist':
  unlist <- Arguments$getLogical(unlist);

  # Argument 'useNames':
  useNames <- Arguments$getLogical(useNames);

  # Stratify by chromosome
  cc <- indexOfColumn(this, "chromosome");
  data <- this[,cc,drop=TRUE];

  # Update known chromosomes, if not already done.  
  allChromosomes <- getChromosomes(this, .chromosomes=data);

  res <- vector("list", length(chromosomes));
  for (cc in seq(along=chromosomes)) {
    units <- whichVector(data == chromosomes[cc]);
    res[[cc]] <- units;
  } # for (cc ...)

  if (useNames) {
    names(res) <- sprintf("Chr%02d", chromosomes);
  }

  if (unlist) {
    res <- unlist(res, use.names=useNames);
  }

  res;
}, protected=TRUE)


setMethodS3("getUnitsOnChromosome", "AromaUnitChromosomeTabularBinaryFile", function(this, chromosome, ...) {
  # Argument 'chromosome':
  chromosome <- Arguments$getIndex(chromosome);

  units <- getUnitsOnChromosomes(this, chromosomes=chromosome, 
                                 unlist=TRUE, useNames=FALSE);
  units;
}, protected=TRUE)


setMethodS3("extractByChromosome", "AromaUnitChromosomeTabularBinaryFile", function(this, chromosomes=getChromosomes(this), ...) {
  unitsList <- getUnitsOnChromosomes(this, chromosomes=chromosomes);
  data <- readDataFrame(this, ...);
  data <- cbind(unit=seq(length=nrow(data)), data);
  lapply(unitsList, FUN=function(units) {
    data[units,,drop=FALSE];
  });
}, protected=TRUE)



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# BEGIN: File I/O
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setMethodS3("allocate", "AromaUnitChromosomeTabularBinaryFile", function(static, ..., platform, chipType, footer=list()) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'platform':
  platform <- Arguments$getCharacter(platform, length=c(1,1));

  # Argument 'chipType':
  chipType <- Arguments$getCharacter(chipType, length=c(1,1));

  # Argument 'footer':
  if (is.null(footer)) {
  } else if (!is.list(footer)) {
    throw("Argument 'footer' must be NULL or a list: ", class(footer)[1]);
  }


  # Create file footer
  footer <- c(
    list(
      createdOn=format(Sys.time(), "%Y%m%d %H:%M:%S", usetz=TRUE),
      platform=platform, 
      chipType=chipType
    ), 
    footer
  );

  # Allocate file
  allocate.AromaMicroarrayTabularBinaryFile(static, ..., footer=footer);
}, static=TRUE)




############################################################################
# HISTORY:
# 2009-05-08
# o Added allocate() to AromaUnitChromosomeTabularBinaryFile.  This will
#   enforce all subclasses to specify a platform and chip type.
# o Added extractByChromosome().
# o Added indexOfColumn().
# o Extracted AromaUnitChromosomeTabularBinaryFile from AromaUgpFile, where
#   the latter now inherits from the former.
############################################################################
