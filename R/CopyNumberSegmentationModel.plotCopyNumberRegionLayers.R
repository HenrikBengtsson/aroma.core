setMethodS3("plotCopyNumberRegionLayers", "CopyNumberSegmentationModel", function(this, path=NULL, col="red", lwd=4, ...) {
  # The report path
  if (is.null(path)) {
    path <- getReportPath(this)
    path <- filePath(getParent(path), "rawCNs,sampleLayer")
  }
  path <- Arguments$getWritablePath(path)

  # Get chip type (used to annotate the plot)
  chipType <- getChipType(this)

  plotFitLayers(this, FUN=function(..., fit, unit, verbose=FALSE) {
    verbose && enter(verbose, "Plotting transparent image")
    suppressWarnings({
      # Create empty plot
      newPlot(this, ..., xlab="", ylab="", yaxt="n", flavor="ce", unit=unit)

      # Draw CNRs
      cnRegions <- extractCopyNumberRegions(fit)
      verbose && print(verbose, cnRegions, level=-50)
      drawLevels(cnRegions, lwd=lwd, col=col, xScale=1/10^unit)
    })
  }, path=path, ...)
}, protected=TRUE) # plotCopyNumberRegions()
