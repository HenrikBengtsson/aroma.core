%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  colKernelSmoothing.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 \name{colKernelSmoothing.matrix}
\alias{colKernelSmoothing.matrix}
\alias{colKernelSmoothing.matrix}

 \alias{colKernelSmoothing}
 \alias{kernelSmoothing}
 \alias{kernelSmoothing.numeric}

 \title{Kernel smoothing of a matrix column by column}

 \description{
  Kernel smoothing of a matrix column by column.
 }

 \usage{\method{colKernelSmoothing}{matrix}(Y, x=seq_len(nrow(Y)), w=NULL, xOut=x, kernel=c("gaussian", "uniform"), h, censorH=3, na.rm=TRUE, robust=FALSE, ..., verbose=FALSE)}

 \arguments{
   \item{Y}{A \code{\link[base]{numeric}} JxI \code{\link[base]{matrix}} (or a \code{\link[base]{vector}} of length J.)}
   \item{x}{A (optional) \code{\link[base]{numeric}} \code{\link[base]{vector}} specifying the positions of
     the J entries. The default is to assume uniformly distributed
     positions.}
   \item{w}{A optional \code{\link[base]{numeric}} \code{\link[base]{vector}} of prior weights for each of
     the J entries.}
   \item{xOut}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} specifying K target positions where
      the kernel is applied.}
   \item{kernel}{A \code{\link[base]{character}} string or a \code{\link[base]{function}} specifying the
      kernel used.}
   \item{h}{A single positive \code{\link[base]{numeric}} specifying the bandwidth of
      the kernel.}
   \item{censorH}{A single positive \code{\link[base]{numeric}} specifying the where to
      truncate the kernel. If \code{\link[base:is.finite]{Inf}}, no truncation is done.}
   \item{na.rm}{If \code{\link[base:logical]{TRUE}}, missing values are excluded, otherwise not.}
   \item{robust}{If \code{\link[base:logical]{TRUE}}, robust estimators are used, otherwise not.}
   \item{...}{Not used.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 }

 \value{
   Returns a \code{\link[base]{numeric}} KxI \code{\link[base]{matrix}} (or a \code{\link[base]{vector}} of length K).
 }

 %% \details{
 %%   M_i' = w*M = w*(T-R) = w*T - w*R = T_i' - R'
 %%
 %%   Before smoothing, the reference R_i == median(T_i).
 %%   Keep this property for R' too.
 %%
 %%   R' = median(T_i')
 %%   T_i' = M_i' - R'
 %%
 %%   => w*T = w*M + w*R = M' + w*R
 %% }

 \examples{
J <- 100
I <- 4
Y <- matrix(rnorm(I*J, sd=1/2), ncol=I)
# Introduce a gain in column 2 and 3
Y[30:50,2:3] <- Y[30:50,2:3] + 3
x <- 1:J

xOut <- x
Ys1 <- colKernelSmoothing(Y, x=x, xOut=xOut, kernel="gaussian", h=1)
Ys5 <- colKernelSmoothing(Y, x=x, xOut=xOut, kernel="gaussian", h=5)

xlim <- range(c(x,xOut))
ylim <- c(-3,5)
layout(matrix(1:I, ncol=1))
par(mar=c(3,3,1,1)+0.1, pch=19)
for (ii in 1:I) {
  plot(NA, xlim=xlim, ylim=ylim)
  points(x, Y[,ii], col="#999999")
  lines(xOut, Ys1[,ii], col=2)
  points(xOut, Ys1[,ii], col=2)
  lines(xOut, Ys5[,ii], col=3)
  points(xOut, Ys5[,ii], col=3)
}
}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   \code{\link[aroma.core:colBinnedSmoothing.matrix]{*colBinnedSmoothing}()}.
 }





\keyword{methods}
\keyword{array}
\keyword{iteration}
\keyword{robust}
\keyword{univar}
