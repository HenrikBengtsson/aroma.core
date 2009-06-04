setMethodS3("append", "RawGenomicSignals", function(this, other, addId=TRUE, ...) {
  # Argument 'other':
  if (!inherits(other, class(this)[1])) {
    throw("Cannot append argument 'other', because it is of an non-compatible class: ", class(other)[1]);
  }

  if (addId) {
    # Keep track of origins, but updating the locus IDs
    if (is.null(this$id)) {
      this$id <- rep(1L, times=nbrOfLoci(this));
    }
  
    if (is.null(other$id)) {
      nextId <- max(this$id, na.rm=TRUE) + 1L;
      other$id <- rep(nextId, times=nbrOfLoci(other));
    }
    addLocusFields(this, "id");
  }

  for (ff in getLocusFields(this)) {
    this[[ff]] <- c(this[[ff]], other[[ff]]);
  }

  invisible(this);
})

############################################################################
# HISTORY:
# 2009-05-07
# o Created.
############################################################################
