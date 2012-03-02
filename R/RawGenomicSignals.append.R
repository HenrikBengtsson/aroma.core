setMethodS3("append", "RawGenomicSignals", function(this, other, addId=TRUE, ...) {
  # Argument 'other':
  other <- Arguments$getInstanceOf(other, class(this)[1]);

  if (addId) {
    # Keep track of origins, but updating the locus IDs
    if (is.null(this$id)) {
      this$id <- rep(1L, times=nbrOfLoci(this));
    }
  
    if (is.null(other$id)) {
      nextId <- max(this$id, na.rm=TRUE) + 1L;
      other$id <- rep(nextId, times=nbrOfLoci(other));
    }
    this <- addLocusFields(this, "id");
  }

  if (inherits(this, "Object") || inherits(this, "BasicObject")) {
    for (ff in getLocusFields(this)) {
      this[[ff]] <- c(this[[ff]], other[[ff]]);
    }
  } else {
    fields <- getLocusFields(this);
    this <- this[,fields,drop=FALSE];
    other <- other[,fields,drop=FALSE];
    this <- rbind(this, other);
  }

  invisible(this);
})

############################################################################
# HISTORY:
# 2009-05-07
# o Created.
############################################################################
