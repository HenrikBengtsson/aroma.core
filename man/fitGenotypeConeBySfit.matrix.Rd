%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  fitGenotypeCone.matrix.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 \name{fitGenotypeConeBySfit.matrix}
\alias{fitGenotypeConeBySfit.matrix}

 \title{Fits an affine transformation to allele A and allele B data}

 \description{
  Fits an affine transformation to allele A and allele B data using robust estimators.
 }

 \usage{
\method{fitGenotypeConeBySfit}{matrix}(y, alpha=c(0.1, 0.075, 0.05, 0.03, 0.01), q=2, Q=98, ...)
}

 \arguments{
   \item{y}{A \code{\link[base]{numeric}} Nx2 \code{\link[base]{matrix}} with one column for each allele and
      where N is the number of data points.}
   \item{alpha}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of decreasing values in (0,1).
      This parameter "determines how far we are willing to press the
      boundary of the [genotype cone]".  Lowering \code{alpha} expand
      the cone.  When \code{alpha} goes to zero, all data points will
      be on or inside the cone.}
   \item{q,Q}{Percentiles in [0,100] for which data points that are
      below (above) will be assigned zero weight in the fitting of
      the parameters.}
   \item{...}{Additional arguments passed to the \code{cfit()} of
      the \pkg{sfit} package.}
 }

 \value{
   Returns the parameter estimates as a named \code{\link[base]{list}} with elements:
    \item{M}{An estimate of the three vertices defining the genotype
      triangle.  These three vertices are describes as an 2x3 \code{\link[base]{matrix}}
      with column \code{origin}, \code{AA}, and \code{BB}.}
    \item{Minv}{The inverse of \code{M}.}
    \item{origin}{The estimate of the shift.}
    \item{W}{The estimate of shear/rotation matrix with columns
             \code{AA} and \code{BB}.}
    \item{Winv}{The inverse of \code{W}.}
    \item{params}{The parameters used for the fit, i.e.
       \code{alpha}, \code{q}, \code{Q}, and  those passed in \code{...}.}
    \item{dimData}{The dimension of the input data.}
 }

 \examples{
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Fit genotype cone based on available methods (==packages)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
flavors <- c("sfit", "expectile")
keep <- sapply(flavors, FUN=require, character.only=TRUE)
flavors <- flavors[keep]
cat("Available fitting flavors:", paste(flavors, collapse=", "), "\n");


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Simulate data (taken from the cfit.matrix() example of 'sfit')
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#set.seed(0xbeef);

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
Z <- t(a0 + A \%*\% t(X + xi))

# Add noise to Y
eps <- matrix(rnorm(2*N, mean=0, sd=0.05), ncol=2)
Y <- Z + eps


lim <- c(-1/2,6)
xlab <- "Allele A"
ylab <- "Allele B"
plot(Y, xlab=xlab, ylab=ylab, xlim=lim, ylim=lim)
lines(x=c(0,0,2*lim[2]), y=c(2*lim[2],0,0), col="#aaaaaa", lwd=3, lty=3)

# Different alpha sequences to illustrate the impact
alphas <- c(0.075, 0.05, 0.01, 0.03, 0.002, 0.001)

cols <- seq(from=2, to=length(alphas)+1)
legend("topright", sprintf("\%.3f", alphas), col=cols, lwd=4, title="Alphas")

for (kk in seq(along=alphas)) {
  for (flavor in flavors) {
    fit <- fitGenotypeCone(Y, alpha=alphas[kk], flavor=flavor)
    radials(fit$M, lwd=3, col=cols[kk], lty=ifelse(flavor == "sfit", 1,2))
    drawApex(fit$M, col=cols[kk], pch=19, cex=2)
    YN <- backtransformGenotypeCone(Y, fit=fit);
    points(YN, col=cols[kk]);
  }
}
lines(x=c(0,0,2*lim[2]), y=c(2*lim[2],0,0), col="#aaaaaa", lwd=3, lty=3)
}

 \author{Henrik Bengtsson}

 \seealso{
  To backtransform data fitted using this method,
  see \code{\link{backtransformGenotypeCone}}().
  Internally, the \code{cfit()} function the \pkg{sfit} package is used.
 }


\keyword{methods}
\keyword{internal}
