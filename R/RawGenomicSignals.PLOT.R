# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# GRAPHICS RELATED METHODS
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
setMethodS3("getXScale", "RawGenomicSignals", function(this, ...) {
  scale <- getBasicField(this, ".xScale")
  if (is.null(scale)) scale <- 1e-6
  scale
})

setMethodS3("getYScale", "RawGenomicSignals", function(this, ...) {
  scale <- getBasicField(this, ".yScale")
  if (is.null(scale)) scale <- 1
  scale
})

setMethodS3("setXScale", "RawGenomicSignals", function(this, scale=1e-6, ...) {
  scale <- Arguments$getNumeric(scale)
  this <- setBasicField(this, ".xScale", scale)
  invisible(this)
})

setMethodS3("setYScale", "RawGenomicSignals", function(this, scale=1, ...) {
  scale <- Arguments$getNumeric(scale)
  this <- setBasicField(this, ".yScale", scale)
  invisible(this)
})

setMethodS3("plot", "RawGenomicSignals", function(x, field=NULL, xlab="Position", ylab="Signal", ylim=c(-3,3), pch=20, xScale=getXScale(this), yScale=getYScale(this), ...) {
  # To please R CMD check
  this <- x

  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this)

  # Argument 'field':
  if (is.null(field)) {
    field <- getSignalColumnName(this)
  } else {
    field <- Arguments$getCharacter(field)
  }

  x <- getPositions(this)
  y <- this[[field]]

  plot(xScale*x, yScale*y, ylim=ylim, xlab=xlab, ylab=ylab, pch=pch, ...)
})


setMethodS3("points", "RawGenomicSignals", function(x, field=NULL, pch=20, ..., xScale=getXScale(this), yScale=getYScale(this)) {
  # To please R CMD check
  this <- x

  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this)

  # Argument 'field':
  if (is.null(field)) {
    field <- getSignalColumnName(this)
  } else {
    field <- Arguments$getCharacter(field)
  }

  x <- getPositions(this)
  y <- this[[field]]

  points(xScale*x, yScale*y, pch=pch, ...)
})

setMethodS3("lines", "RawGenomicSignals", function(x, field=NULL, ..., xScale=getXScale(this), yScale=getYScale(this)) {
  # To please R CMD check
  this <- x

  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this)

  # Argument 'field':
  if (is.null(field)) {
    field <- getSignalColumnName(this)
  } else {
    field <- Arguments$getCharacter(field)
  }

  x <- getPositions(this)
  y <- this[[field]]

  o <- order(x)
  x <- x[o]
  y <- y[o]

  x <- x*xScale
  y <- y*yScale

  lines(x, y, ...)
})


setMethodS3("drawDensity", "RawGenomicSignals", function(this, field=NULL, side=2, lwd=2, ..., adjust=0.2) {
  # Argument 'field':
  if (is.null(field)) {
    field <- getSignalColumnName(this)
  } else {
    field <- Arguments$getCharacter(field)
  }

  y <- this[[field]]
  y <- y[is.finite(y)]
  y <- rep(y, length.out=max(2, length(y)))
  d <- density(y, adjust=adjust)
  draw(d, side=side, lwd=lwd, ...)
})
