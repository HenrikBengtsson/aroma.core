# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Simulating copy-number data
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Number of loci
J <- 1000

mu <- double(J)
mu[200:300] <- mu[200:300] + 1
mu[650:800] <- mu[650:800] - 1
eps <- rnorm(J, sd=1/2)
y <- mu + eps
x <- sort(runif(length(y), max=length(y)))
w <- runif(J)
w[650:800] <- 0.001


cn <- RawCopyNumbers(y, x)
print(cn)

plot(cn, col="#aaaaaa")

cnS <- binnedSmoothing(cn, by=10)
print(cnS)
lines(cnS, col="black", lwd=3)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Segment
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
legend <- c()

fit <- segmentByCBS(cn)
cnr <- extractCopyNumberRegions(fit)
print(cnr)
drawLevels(cnr, col="red", lwd=3)
legend <- c(legend, red="CBS")

fit <- segmentByGLAD(cn)
cnr <- extractCopyNumberRegions(fit)
print(cnr)
drawLevels(cnr, col="blue", lwd=3)
legend <- c(legend, blue="GLAD")

if (require("HaarSeg")) {
  fit <- segmentByHaarSeg(cn)
  cnr <- extractCopyNumberRegions(fit)
  print(cnr)
  drawLevels(cnr, col="orange", lwd=3)
  legend <- c(legend, orange="HaarSeg")
}

legend("topleft", pch=19, col=names(legend), legend, bty="n", horiz=TRUE)
