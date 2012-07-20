%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  PairedPSCNData.PLOT.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 \name{plotTracks.PairedPSCNData}
\alias{plotTracks.PairedPSCNData}
\alias{PairedPSCNData.plotTracks}
\alias{plotTracks.PairedPSCNData}
\alias{plotTracks,PairedPSCNData-method}

 \alias{plotTracks}

 \title{Plots parental specific copy numbers along the genome}

 \description{
  Plots parental specific copy numbers along the genome for one or more chromosomes.
  It is possible to specify what type of tracks to plot.
  Each type of track is plotted in its own panel.
 }

 \usage{\method{plotTracks}{PairedPSCNData}(x, tracks=c("tcn", "dh", "tcn,c1,c2", "tcn,c1", "tcn,c2", "c1,c2", "betaN", "betaT", "betaTN")[1:3], pch=".", col=NULL, cex=1, grid=FALSE, xlim=NULL, Clim=c(0, 6), Blim=c(0, 1), xScale=1e-06, ..., add=FALSE, subplots=!add && (length(tracks) > 1), verbose=FALSE)}

 \arguments{
   \item{tracks}{A \code{\link[base]{character}} \code{\link[base]{vector}} specifying what types of tracks to plot.}
   \item{pch}{The type of the scatter points, if any.}
   \item{col}{The color of the scatter points, if any.}
   \item{cex}{The size of the scatter points, if any.}
   \item{grid}{If \code{\link[base:logical]{TRUE}}, horizontal lines are displayed.}
   \item{xlim}{(Optional) The genomic range to plot.}
   \item{Clim}{The range of copy numbers.}
   \item{Blim}{The range of allele B fractions (BAFs) and
     decrease of heterozygosity (DHs).}
   \item{xScale}{The scale factor used for genomic positions.}
   \item{...}{Not used.}
   \item{add}{If \code{\link[base:logical]{TRUE}}, the panels plotted are added to the existing plot,
     otherwise a new plot is created.}
   \item{subplots}{If \code{\link[base:logical]{TRUE}}, then subplots are automatically setup.}
   \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 }

 \value{
   Returns nothing.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}



\keyword{internal}
\keyword{methods}
\keyword{IO}
