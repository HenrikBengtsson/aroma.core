%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Explorer.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{setAlias.Explorer}
\alias{setAlias.Explorer}
\alias{Explorer.setAlias}
\alias{setAlias.Explorer}
\alias{setAlias,Explorer-method}


\title{Sets the alias of the output set}

\description{
  Sets the alias of the output set.
  If specified, the alias overrides the data set name, which is used by
  default.
}

\usage{\method{setAlias}{Explorer}(this, alias=NULL, ...)}

\arguments{
 \item{alias}{A \code{\link[base]{character}} string for the new alias of the output set.
  The alias must consists of valid filename characters, and must not
  contain commas, which are used to separate tags.}
 \item{...}{Not used.}
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[aroma.core:getAlias.Explorer]{*getAlias}()}.
  \code{\link[aroma.core:getName.Explorer]{*getName}()}.
  For more information see \code{\link{Explorer}}.
}
\keyword{internal}
\keyword{methods}
