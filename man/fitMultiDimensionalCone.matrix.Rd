%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  fitMultiDimensionalCone.matrix.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{fitMultiDimensionalCone.matrix}
\alias{fitMultiDimensionalCone.matrix}

\title{Fits an affine transformation to multi-dimensional data}

\description{
 Fits an affine transformation to multi-dimensional data using robust estimators.
}

\usage{
\method{fitMultiDimensionalCone}{matrix}(y, alpha=c(0.1, 0.075, 0.05, 0.03, 0.01), q=2, Q=98, ...,
  flavor=c("sfit", "expectile"))
}

\arguments{
  \item{y}{A \code{\link[base]{numeric}} NxK \code{\link[base]{matrix}} with one column for each dimension and
     where N is the number of data points.}
  \item{alpha}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of decreasing values in (0,1).
     This parameter "determines how far we are willing to press the
     boundary of the [genotype cone]".  Lowering \code{alpha} expand
     the cone.  When \code{alpha} goes to zero, all data points will
     be on or inside the cone.}
  \item{q,Q}{Percentiles in [0,100] for which data points that are
     below (above) will be assigned zero weight in the fitting of
     the parameters.}
  \item{...}{Additional arguments passed to the \code{cfit()} function
     of the \pkg{sfit} package.}
  \item{flavor}{A \code{\link[base]{character}} string specifying what model/algorithm
     should be used to fit the genotype cone.}
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
if (require("sfit")) {
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Simulate data (taken from the cfit.matrix() example of 'sfit')
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
N <- 1000

# Simulate sequences
nucleotides <- c("A", "C", "G", "T")
g <- sample(nucleotides, size=N, replace=TRUE)
ndim <- length(nucleotides)

# Simulate concentrations of allele A and allele B
X <- matrix(rexp(N), nrow=N, ncol=ndim)
colnames(X) <- nucleotides
for (nucleotide in nucleotides) {
  cc <- match(nucleotide, nucleotides)
  X[g == nucleotide, -cc] <- 0
}

# The true offset
a0 <- rep(0.3, times=ndim)

# The crosstalk matrix
A <- matrix(c(
  0.9, 0.3, 0.2, 0.1,
  0.1, 0.8, 0.1, 0.1,
  0.3, 0.4, 0.7, 0.1,
  0.1, 0.1, 0.6, 0.9
), nrow=ndim, byrow=TRUE)
A <- apply(A, MARGIN=2, FUN=function(u) u / sqrt(sum(u^2)))

# Simulate random errors on the input
xi <- matrix(rnorm(ndim*N, mean=0, sd=0.05), ncol=ndim)

# Generate the noisy crosstalk affected input data
Z <- t(a0 + A \%*\% t(X + xi))

# Generate the noisy observations of the latter
eps <- matrix(rnorm(ndim*N, mean=0, sd=0.05), ncol=ndim)
Y <- Z + eps

# Fit crosstalk model and calibrate data accordingly
fit <- fitMultiDimensionalCone(Y, flavor="sfit")
Yc <- backtransformMultiDimensionalCone(Y, fit=fit)

lim <- c(-0.5,6)
layout(matrix(c(1,2,3,0,4,5,0,0,6), nrow=3, ncol=3, byrow=TRUE))
par(mar=c(5,4,1,1)+0.1)
for (ii in 1:(ndim-1)) {
  for (jj in (ii+1):ndim) {
    cc <- c(jj,ii)
    labs <- nucleotides[cc]
    plot(Y[,cc], cex=0.8, xlim=lim, ylim=lim, xlab=labs[1], ylab=labs[2])
    points(Yc[,cc], cex=0.8, col="blue")
    Mcc <- fit$M[c(1,1+cc),cc]
    class(Mcc) <- class(fit$M)
    lines(Mcc, lwd=2, col="red")
  }
}

}
}

\author{Henrik Bengtsson}

\seealso{
 To backtransform data fitted using this method,
 see \code{\link[aroma.core:backtransformMultiDimensionalCone.matrix]{*backtransformMultiDimensionalCone}()}.
 Internally, the \code{cfit()} function the \pkg{sfit} package is used.
}


\keyword{methods}
\keyword{internal}
