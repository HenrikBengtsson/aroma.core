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
fit <- segmentByCBS(cn)
cnr <- extractCopyNumberRegions(fit)
print(cnr)
drawLevels(cnr, col="red")

fit <- segmentByGLAD(cn)
cnr <- extractCopyNumberRegions(fit)
print(cnr)
drawLevels(cnr, col="blue")

fit <- segmentByHaarSeg(cn)
cnr <- extractCopyNumberRegions(fit)
print(cnr)
drawLevels(cnr, col="orange")

