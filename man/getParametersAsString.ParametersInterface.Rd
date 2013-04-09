%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  ParametersInterface.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getParametersAsString.ParametersInterface}
\alias{getParametersAsString.ParametersInterface}
\alias{ParametersInterface.getParametersAsString}
\alias{getParametersAsString,ParametersInterface-method}

\title{Gets the parameters as character}

\description{
 Gets the parameters as character.
}

\usage{
\method{getParametersAsString}{ParametersInterface}(this, ..., collapse=c(", ", "; "), drop=TRUE)
}

\arguments{
 \item{...}{Arguments passed to \code{\link[aroma.core:getParameters.ParametersInterface]{*getParameters}()}.}
 \item{collapse}{(optional) A \code{\link[base]{character}} string used to collapse the
   individual parameter strings.}
 \item{drop}{If \code{\link[base:logical]{TRUE}} and there is only one set of parameters,
   then a single \code{\link[base]{character}} \code{\link[base]{vector}} is returned, otherwise a \code{\link[base]{list}}.}
}

\value{
 Returns a \code{\link[base]{list}} of \code{\link[base]{character}} \code{\link[base]{vector}}s, or a \code{\link[base]{character}} \code{\link[base]{vector}}.
}

\author{Henrik Bengtsson}

\seealso{
  For more information see \code{\link{ParametersInterface}}.
}
\keyword{internal}
\keyword{methods}
