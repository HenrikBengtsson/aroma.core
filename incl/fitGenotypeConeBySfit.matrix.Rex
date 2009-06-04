# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Simulate data (taken from the cfit.matrix() example of 'sfit')
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
N <- 1000

# Simulate genotypes
g <- sample(c("AA", "AB", "AB", "BB"), size=N, replace=TRUE)

# Simulate concentrations of allele A and allele B
X <- matrix(rexp(N), nrow=N, ncol=2)
colnames(X) <- c("A", "B")
X[g == "AA", "B"] <- 0
X[g == "BB", "A"] <- 0
X[g == "AB",] <- X[g == "AB",] / 2

# Transform noisy X
xi <- matrix(rnorm(2*N, mean=0, sd=0.05), ncol=2)
a0 <- c(0,0)+0.3
A <- matrix(c(0.9, 0.1, 0.1, 0.8), nrow=2, byrow=TRUE)
A <- apply(A, MARGIN=2, FUN=function(u) u / sqrt(sum(u^2)))
Z <- t(a0 + A %*% t(X + xi))

# Add noise to Y
eps <- matrix(rnorm(2*N, mean=0, sd=0.05), ncol=2)
Y <- Z + eps


lim <- c(0,6)
xlab <- "Allele A"
ylab <- "Allele B"
plot(Y, xlab=xlab, ylab=ylab, xlim=lim, ylim=lim)

# Different alpha sequences to illustrate the impact
alphas <- list(
  "default" = c(0.10, 0.075, 0.05, 0.03, 0.01),
  "a bit"   = c(0.10, 0.075),
  "some"    = c(0.10, 0.075, 0.05, 0.03),
  "lots"    = c(0.10, 0.075, 0.05, 0.03, 0.01, 0.002),
  "heaps"   = c(0.10, 0.075, 0.05, 0.03, 0.01, 0.002, 0.0001)
)

cols <- 1 + seq(along=alphas)
legend("topright", names(alphas), col=cols, lwd=4, title="Alpha seq's:")

for (kk in seq(along=alphas)) {
  fit <- fitGenotypeCone(Y, alpha=alphas[[kk]])
  lines(fit$M, lwd=4, col=cols[kk])
}
