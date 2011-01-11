%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RawGenomicSignals.segmentByGLAD.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 \name{segmentByGLAD.RawGenomicSignals}
\alias{segmentByGLAD.RawGenomicSignals}
\alias{RawGenomicSignals.segmentByGLAD}
\alias{segmentByGLAD.RawGenomicSignals}
\alias{segmentByGLAD,RawGenomicSignals-method}


 \title{Segment copy numbers using the GLAD method}

 \description{
  Segment copy numbers using the GLAD method of the \pkg{GLAD} package.
 }

 \usage{\method{segmentByGLAD}{RawGenomicSignals}(this, ..., flavor=c("glad", "daglad"), cache=FALSE, force=FALSE, verbose=FALSE)}

 \arguments{
   \item{...}{Additional arguments passed to the segmentation function.}
   \item{flavor}{A \code{\link[base]{character}} string specifying what flavor of
      GLAD should be used.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 }

 \value{
  Returns the fit object.
 }

 \details{
   Internally \code{\link[GLAD]{glad}} or  \code{\link[GLAD]{daglad}} is used to
   segment the signals.
   This segmentation method does not support weighted segmentation.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   For more information see \code{\link{RawGenomicSignals}}.
 }


\keyword{internal}
\keyword{methods}
\keyword{IO}
