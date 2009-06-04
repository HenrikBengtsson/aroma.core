setMethodS3("remap", "default", function(x, map, values=NULL, ...) {
  # Argument 'map':
  mode <- mode(x);
  if (!identical(mode(map), mode)) {
    throw("Argument 'map' is of a different mode than 'x': ", 
                                        mode(map), " != ", mode);
  }

  # Argument 'values':
  if (is.null(values)) {
    values <- seq(along=map);
    mode(values) <- mode;
  }

  # Nothing todo?
  if (identical(map, values)) {
    return(x);
  }

  # Allocate return object
  y <- vector(mode(values), length(x));
  dim(y) <- dim(x);

  # Remap
  nbrOfValues <- length(map);
  for (kk in seq(length=nbrOfValues)) {
    idxs <- (x == map[kk]);
    idxs <- whichVector(idxs);
    if (length(idxs) > 0) {
      y[idxs] <- values[kk];
    }
  }
  rm(idxs);

  y;
}, protected=TRUE)


############################################################################
# HISTORY:
# 2008-07-09
# o Created.
############################################################################
