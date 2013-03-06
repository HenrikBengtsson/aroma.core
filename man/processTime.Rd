%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  processTime.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{processTime}
\alias{processTime.default}
\alias{processTime}

\title{Gets the running time of the R process and its children processes}

\description{
  Gets the running time of the R process and its children processes.
  This function is a safe wrapper for \code{\link[base]{proc.time}}(), which might
  not exist on all platforms.  It "determines how much time (in seconds)
  the currently running \R process already consumed".  In addition it adds
  descriptive names of the returned values.
  For more details, see \code{\link[base]{proc.time}}().
}

\usage{
\method{processTime}{default}(since=NULL, units=c("seconds", "milliseconds", "minutes", "hours", "days"), fmtstr=NULL, ...)
}

\arguments{
 \item{since}{An optional \code{\link[base]{numeric}} \code{\link[base]{vector}} to be subtracted from the value
   of \code{\link[base]{proc.time}}().  This is useful for calculating "lap times".}
 \item{units}{A \code{\link[base]{character}} string specifying the unit of the
   returned values.}
 \item{fmtstr}{If given, a format string to convert the times to strings
   via \code{\link[base]{sprintf}}().}
 \item{...}{Not used.}
}

\value{
  Returns a named \code{\link[base]{numeric}} \code{\link[base]{vector}} of length 5.
  For more details, see \code{\link[base]{proc.time}}().
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[base]{proc.time}}().
  \code{\link[base]{system.time}}().
  \code{\link[base]{gc.time}}().
}



\keyword{programming}
\keyword{internal}
