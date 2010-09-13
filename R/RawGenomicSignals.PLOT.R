setMethodS3("drawDensity", "RawGenomicSignals", function(this, side=2, lwd=2, ..., adjust=0.2) {
  y <- getSignals(this);
  y <- y[is.finite(y)];
  y <- rep(y, length.out=max(2, length(y)));
  d <- density(y, adjust=adjust);
  draw(d, side=side, lwd=lwd, ...);
})


###########################################################################
# HISTORY:
# 2010-09-12
# o Added drawDensity() for RawGenomicSignals.
# o Created.
###########################################################################
