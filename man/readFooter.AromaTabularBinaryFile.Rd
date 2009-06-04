%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaTabularBinaryFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{readFooter.AromaTabularBinaryFile}
\alias{readFooter.AromaTabularBinaryFile}
\alias{AromaTabularBinaryFile.readFooter}
\alias{readFooter.AromaTabularBinaryFile}
\alias{readFooter,AromaTabularBinaryFile-method}


\title{Reads the file footer in XML format into a named nested list}

\description{
 Reads the file footer in XML format into a named nested list.
}

\usage{\method{readFooter}{AromaTabularBinaryFile}(this, asXmlString=FALSE, ...)}

\arguments{
  \item{asXmlString}{If \code{\link[base:logical]{TRUE}}, the file footer is returned as
     a \code{\link[base]{character}} string.}
  \item{...}{Not used.}
}

\value{
 Returns a named \code{\link[base]{list}} structure (or a \code{\link[base]{character}} string).
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[aroma.core:writeFooter.AromaTabularBinaryFile]{*writeFooter}()}.
  For more information see \code{\link{AromaTabularBinaryFile}}.
}



\keyword{internal}
\keyword{methods}
\keyword{IO}
\keyword{programming}
