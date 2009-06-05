%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RawGenomicSignals.segmentByHaarSeg.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 \name{segmentByHaarSeg.RawGenomicSignals}
\alias{segmentByHaarSeg.RawGenomicSignals}
\alias{RawGenomicSignals.segmentByHaarSeg}
\alias{segmentByHaarSeg.RawGenomicSignals}
\alias{segmentByHaarSeg,RawGenomicSignals-method}


 \title{Segment copy numbers using the HaarSeg method}

 \description{
  Segment copy numbers using the HaarSeg method of the \pkg{HaarSeg} package.
 }

 \usage{\method{segmentByHaarSeg}{RawGenomicSignals}(this, ..., cache=FALSE, force=FALSE, verbose=FALSE)}

 \arguments{
   \item{...}{Additional arguments passed to the segmentation function.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 }

 \value{
  Returns the fit object.
 }

 \details{
   Internally \code{\link[aroma.core:HaarSeg::haarSeg.RawGenomicSignals]{*HaarSeg::haarSeg}()} is used to segment the signals.
   This segmentation method support weighted segmentation.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   Internally the segmentation function
   \code{\link[aroma.core:HaarSeg::haarSeg.RawGenomicSignals]{*HaarSeg::haarSeg}()} is used.
   For more information see \code{\link{RawGenomicSignals}}.
 }


\keyword{internal}
\keyword{methods}
\keyword{IO}
