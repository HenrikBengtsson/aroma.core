log2center <- function(x) {
  # turn x into a *log2* ratio
  suppressWarnings({
    x <- log2(x);
  });
  # Remove the mean
  avg <- median(x, na.rm=TRUE);
  x <- x - avg;
  x;
}


log2neg <- function(x) { 
  x <- -x;
  x[x <= 0] <- NA; 
  log2(x); 
}

log2pos <- function(x) { 
  x[x <= 0] <- NA; 
  log2(x); 
}

log2abs <- function(x) { 
  x <- abs(x);
  x[x <= 0] <- NA; 
  log2(x); 
}


sqrtcenter <- function(x) {
  # turn x into a *log2* ratio
  x <- sqrt(x);
  # Remove the mean
  avg <- median(x, na.rm=TRUE);
  x <- x - avg;
  x;
}

sqrtneg <- function(x) {
  x <- -x;
  x[x <= 0] <- NA; 
  sqrt(x); 
}

sqrtpos <- function(x) { 
  x[x <= 0] <- NA; 
  sqrt(x); 
}

sqrtabs <- function(x) { 
  x <- abs(x);
  x[x <= 0] <- NA; 
  sqrt(x); 
}


############################################################################
# HISTORY:
# 2008-03-17
# o Added log2center() and sqrtcenter().
# 2007-02-14
# o Created.
############################################################################
