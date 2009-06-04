J <- 100
I <- 4
Y <- matrix(rnorm(I*J, sd=1/2), ncol=I)
# Introduce a gain in column 2 and 3
Y[30:50,2:3] <- Y[30:50,2:3] + 3
x <- 1:J

Ys3 <- colBinnedSmoothing(Y, x=x, from=2, by=3)
Ys5 <- colBinnedSmoothing(Y, x=x, from=3, by=5)

xlim <- range(x)
ylim <- c(-3,5)
layout(matrix(1:I, ncol=1))
par(mar=c(3,3,1,1)+0.1, pch=19)
for (ii in 1:I) {
  plot(NA, xlim=xlim, ylim=ylim)
  points(x, Y[,ii], col="#999999")
  xOut <- attr(Ys3, "xOut");
  lines(xOut, Ys3[,ii], col=2)
  points(xOut, Ys3[,ii], col=2)
  xOut <- attr(Ys5, "xOut");
  lines(xOut, Ys5[,ii], col=3)
  points(xOut, Ys5[,ii], col=3)
}
