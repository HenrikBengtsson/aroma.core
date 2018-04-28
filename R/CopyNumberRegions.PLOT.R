setMethodS3("drawDensity", "CopyNumberRegions", function(this, field="mean", adjust=0.2, side=2, lwd=2, ...) {
  # Get the density
  d <- getDensity(this, field=field, adjust=adjust)

  # Draw
  draw(d, side=side, lwd=lwd, ...)
})
