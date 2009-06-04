setMethodS3("subtractBy", "RawGenomicSignals", function(this, ...) {
  applyBinaryOperator(this, ..., FUN=get("-", mode="function"));
})

setMethodS3("addBy", "RawGenomicSignals", function(this, ...) {
  applyBinaryOperator(this, ..., FUN=get("+", mode="function"));
})

setMethodS3("divideBy", "RawGenomicSignals", function(this, ...) {
  applyBinaryOperator(this, ..., FUN=get("/", mode="function"));
})

setMethodS3("multiplyBy", "RawGenomicSignals", function(this, ...) {
  applyBinaryOperator(this, ..., FUN=get("*", mode="function"));
})


setMethodS3("applyBinaryOperator", "RawGenomicSignals", function(this, other, fields=getLocusFields(this), FUN, ..., sort=FALSE) {
  # Argument 'other':
  className <- class(this)[1];
  if (!inherits(other, className)) {
    throw("Argument 'other' is not of class ", className, ": ", 
                                                          class(other)[1]);
  }

  # Argument 'FUN':
  if (!is.function(FUN)) {
    throw("Argument 'FUN' is not a function: ", mode(FUN)[1]);
  }
 

  nbrOfLoci <- nbrOfLoci(this);
  if (nbrOfLoci(other) != nbrOfLoci) {
    throw("The number of loci in argument 'other' does not match the number of loci in this object: ", nbrOfLoci(other), " != ", nbrOfLoci);
  }

  fieldsOther <- getLocusFields(other);
  fields <- intersect(fields, fieldsOther);

  res <- clone(this);

  # Sort by genomic position?
  if (sort) {
    res <- sort(res);
    other <- clone(other);
    other <- sort(other);
  }

  # Has genomic locations?
  if (is.element("x", fields)) {
    # Assert that positions are the same
    if (!all.equal(this$x, other$x)) {
      throw("Cannot subtract argument 'other' from this object, because their genomic locations do not match.");
    }

    # Keep positions
    fields <- setdiff(fields, "x");
  }

  for (field in fields) {
    delta <- FUN(res[[field]], other[[field]]);
    res[[field]] <- delta;
  }
  setLocusFields(res, fields);

  res;  
}, protected=TRUE)



############################################################################
# HISTORY:
# 2009-05-10
# o Added {add,subtract,multiply,divide}By() to RawGenomicSignals.
# o Added applyBinaryOperator().
# o Created.
############################################################################
