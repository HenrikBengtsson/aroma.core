setMethodS3("plotRawCopyNumbers", "CopyNumberChromosomalModel", function(this, path=NULL, col="black", ...) {
  # The report path
  if (is.null(path)) {
    path <- getReportPath(this)
    path <- filePath(getParent(path), "rawCNs,sampleLayer")
  }
  path <- Arguments$getWritablePath(path)

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }


  # Get chip type (used to annotate the plot)
  chipType <- getChipType(this)

  plotSampleLayers(this, FUN=function(..., array, chromosome, unit, verbose=FALSE) {
    verbose && enter(verbose, "Plotting transparent image")
    if (verbose && isVisible(verbose, -20)) {
      args <- list(..., array=array, chromosome=chromosome, unit=unit)
      verbose && str(verbose, args)
    }

    suppressWarnings({
      # Create empty plot
      newPlot(this, ..., xlab="", ylab="", yaxt="n", flavor="ce", unit=unit)

      # Extract raw CN estimates
      rawCns <- extractRawCopyNumbers(this, array=array, chromosome=chromosome, verbose=less(verbose, 5))
      verbose && print(verbose, rawCns, level=-50)

      # Plot raw CNs data points
      points(rawCns, xScale=1/10^unit, col=col, ...)

      # Add number-of-loci annotation to graph
      n <- nbrOfLoci(rawCns, na.rm=TRUE)
      stext(text=sprintf("n=%d", n), side=4, pos=0, line=0, cex=0.8)

      # Add std dev estimates
      sd <- estimateStandardDeviation(rawCns)
      text <- substitute(hat(sigma)==sd, list(sd=sprintf("%.3g", sd)))
      stext(text=text, side=3, pos=0.5, line=-2)
    })

    # Add chip-type annotation
    stext(chipType, side=4, pos=1, line=0, cex=0.8)

    verbose && exit(verbose)
  }, path=path, ...)
}, protected=TRUE) # plotRawCopyNumbers()
