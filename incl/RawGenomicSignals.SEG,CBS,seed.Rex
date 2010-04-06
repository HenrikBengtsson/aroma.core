if (require("DNAcopy")) {

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
x <- sort(runif(length(y), max=length(y))) * 1e5;
w <- runif(J)
w[650:800] <- 0.001


cn <- RawCopyNumbers(y, x)
print(cn)

plot(cn, col="#aaaaaa", xlab="Position (Mb)")

cnS <- binnedSmoothing(cn, by=500e3)
print(cnS)
lines(cnS, col="black", lwd=3)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Segment
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
legend <- c()

seed <- 0xBEEF;
seed <- NULL;

cnrLast <- NULL;
for (kk in 1:20) {
  print(kk);
  fit <- segmentByCBS(cn, seed=seed)
  cnr <- extractCopyNumberRegions(fit)
  print(cnr)
  drawLevels(cnr, col=kk, lwd=3)
  if (kk > 1) {
    stopifnot(equals(cnr, cnrLast));
  }
  cnrLast <- cnr;
} # for (kk ...)

} # if (require("DNAcopy"))
