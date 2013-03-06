%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaCellCpgFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AromaCellCpgFile}
\docType{class}
\alias{AromaCellCpgFile}


 \title{A binary file holding local CpG density for each cell (probe/feature)}

 \description{
   A binary file holding local CpG density for each cell (probe/feature).
 }

 \usage{
AromaCellCpgFile(...)
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

 \author{Mark Robinson}
\keyword{classes}
