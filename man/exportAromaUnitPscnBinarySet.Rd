%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AromaUnitTotalCnBinarySet.exportAromaUnitPscnBinarySet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{exportAromaUnitPscnBinarySet}
\alias{exportAromaUnitPscnBinarySet}

\alias{exportAromaUnitPscnBinarySet.AromaUnitTotalCnBinarySet}
\alias{exportAromaUnitPscnBinarySet.list}

\title{Export total and allele B signal data sets as a unified parent-specific copy number signal data set}

\description{
 Export total and allele B signal data sets as a unified parent-specific copy number signal data set, where each sample is stored in one data file (contrary to the input data sets where each sample is stored in two separated files).
}

\usage{
 \method{exportAromaUnitPscnBinarySet}{AromaUnitTotalCnBinarySet}(dsT, dsB="*", dataSet="*", tags="*", ...,
  rootPath="totalAndFracBData/", overwrite=!skip, skip=TRUE, verbose=FALSE)
 \method{exportAromaUnitPscnBinarySet}{list}(dsList, ...)
}

\arguments{
  \item{dsT, dsB}{An \code{\link{AromaUnitTotalCnBinarySet}} and an \code{\link{AromaUnitFracBCnBinarySet}} with coupled sets of samples that match up by name.  If they don't match up, an exception is thrown.  The allele B fraction (BAF) data set \code{dsB} is by default inferred from the total CN data set \code{dsT}.}
  \item{dataSet, tags}{The name and tags of the output data set.
    The default is to infer those from the input \code{dsT} data set.}
  \item{...}{Not used.}
  \item{rootPath}{The root path of the output data set.}
  \item{overwrite, skip}{Specifies whether to overwrite and/or skip already exported samples.}
  \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns an \code{\link{AromaUnitPscnBinarySet}} object.
}

\section{Allele-specific CRMAv2 pipeline}{
  A common use case is to run allele-specific CRMAv2, e.g.
  \code{dsNList <- doASCRMAv2(csR)}, which outputs a \code{\link[base]{list}} \code{dsNList}
  with elements corresponding to \code{dsT} and \code{dsB}.  This output
  can be exported to \code{\link{AromaUnitPscnBinarySet}} by this method as
  \code{dsN <- exportAromaUnitPscnBinarySet(dsNList)}.
}

\author{Henrik Bengtsson}


\keyword{methods}
\keyword{internal}
