%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaCellPositionFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaCellPositionFile}
\docType{class}
\alias{AromaCellPositionFile}


 \title{A binary file holding chromosome/position for each cell}

 \description{
   A binary file holding chromosome/position for each cell.
 }

 \usage{
AromaCellPositionFile(...)
}

 \arguments{
  \item{...}{Arguments passed to constructor of
             \code{\link{AromaCellTabularBinaryFile}}.}
 }

 \details{
   Note that this class does \emph{not} assume a rectangular chip layout.
   In other words, there is no concept of mapping a \emph{spatial}
   location on the array to a cell index and vice versa.
   The reason for this to be able to use this class also for
   non-rectangular chip types.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
