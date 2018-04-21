setMethodS3("locallyUnique", "default", function(x, ...) {
  n <- length(x)
  if (n < 2)
    return(x)
  ok <- c(TRUE, (x[-n] != x[-1]))
  x[ok]
})
