%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  matrixBlockPolish.matrix.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{matrixBlockPolish.matrix}
\alias{matrixBlockPolish.matrix}

\title{Applies a polishing function to blocks of rows and columns repeatedly}

\description{
 Applies a polishing function to blocks of rows and columns repeatedly.
}

\usage{
\method{matrixBlockPolish}{matrix}(z, x=NULL, blockSizes=c(1, 1), FUN, ..., tol=0.01, maxIter=10,
  returnEffects=FALSE)
}

\arguments{
  \item{z}{A \code{\link[base]{numeric}} KxN \code{\link[base]{matrix}}.}
  \item{x}{A optional KxNx2 \code{\link[base]{array}} (or KxN \code{\link[base]{matrix}}).}
  \item{blockSizes}{A positive \code{\link[base]{integer}} \code{\link[base]{vector}} of length two.}
  \item{FUN}{A \code{\link[base]{function}} taking \code{\link[base]{numeric}} arguments \code{z} and
     \code{x} and returns a \code{\link[base]{numeric}} object with either a scalar
     or the same number of elements as in \code{z}.}
  \item{...}{Additional arguments passed to the \code{FUN} \code{\link[base]{function}}.}
  \item{tol}{A positive threshold specifying when the algorithm has
     converged.}
  \item{maxIter}{The maximum number of iterations.}
  \item{returnEffects}{If \code{\link[base:logical]{TRUE}}, the row and column effects are returned,
     otherwise not.}
}

\value{
  Returns a named \code{\link[base]{list}}.
}

\examples{
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Example 1: median polish
# From example(medpolish) in the 'stats' package
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Deaths from sport parachuting;  from ABC of EDA, p.224:
deaths <- matrix(c(14,15,14, 7,4,7, 8,2,10, 15,9,10, 0,2,0), ncol=3, byrow=TRUE)
rownames(deaths) <- c("1-24", "25-74", "75-199", "200++", "NA")
colnames(deaths) <- 1973:1975
print(deaths)

fit1 <- medpolish(deaths, trace=FALSE)
r1 <- residuals(fit1)
fit2 <- matrixBlockPolish(deaths, FUN=function(y, x, ...) median(y, ...))
r2 <- residuals(fit2)
stopifnot(all.equal(r1,r2))


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Example 2: smooth spline polish ("spatial smoothing")
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# From example(image) in 'graphics' package
x <- y <- seq(-4*pi, 4*pi, len=27)
r <- sqrt(outer(x^2, y^2, FUN="+"))
z <- cos(r^2) * exp(-r/6)

fit <- matrixBlockPolish(z, FUN=function(z, x, ...) median(z, ...),
                                                      returnEffects=TRUE)
r1 <- residuals(fit)

fit <- matrixBlockPolish(z, FUN=function(z, x, ...) {
  fit <- smooth.spline(x=x, y=z, ...);
  predict(fit, x=x)$y;
}, spar=0.25)
r2 <- residuals(fit)
print(range(r2))
image(r2)
}

\author{Henrik Bengtsson}

\seealso{
 \code{\link[stats]{medpolish}}.
 \code{\link[aroma.light:medianPolish.matrix]{medianPolish}()}.
}


\keyword{methods}
\keyword{internal}
