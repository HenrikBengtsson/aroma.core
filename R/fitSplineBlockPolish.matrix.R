setMethodS3("fitSplineBlockPolish", "matrix", function(z, blockSizes=c(20,20), spar=0.7, maxIter=1, ...) {
  effectFcn <- function(z, x, ...) {
    ok <- (is.finite(x) & is.finite(z))
    xok <- x[ok]
    zok <- z[ok]
    # Not needed anymore
    ok <- NULL
    fit <- smooth.spline(x=xok, y=zok, ...)
    predict(fit, x=x)$y
  }

  matrixBlockPolish(z, blockSizes=blockSizes, FUN=effectFcn,
                                           spar=spar, maxIter=maxIter, ...)
})
