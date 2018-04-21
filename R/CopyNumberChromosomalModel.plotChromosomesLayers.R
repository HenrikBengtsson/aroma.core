setMethodS3("plotChromosomesLayers", "CopyNumberChromosomalModel", function(this, FUN, path, chromosomes=getChromosomes(this), xlim=NULL, ..., pixelsPerMb=3, zooms=2^(0:6), height=400, xmargin=c(50,50), imageFormat="current", transparent=FALSE, skip=TRUE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'FUN':
  if (!is.function(FUN)) {
    throw("Arguments 'FUN' is not a function: ", class(FUN)[1])
  }

  # Argument 'chromosomes':
  if (is.null(chromosomes)) {
    chromosomes <- getChromosomes(this)
  }

  # Argument 'pixelsPerMb':
  pixelsPerMb <- Arguments$getDouble(pixelsPerMb, range=c(0.001,9999))

  # Argument 'zooms':
  zooms <- Arguments$getIntegers(zooms, range=c(1,9999))
  zooms <- unique(zooms)

  # Argument 'height':
  height <- Arguments$getInteger(height, range=c(1,4096))

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }


  # Get genome annotation data (chromosome lengths etc)
  genome <- getGenomeData(this)

  # In units of 10^unit bases (default is Mb)
  unit <- 6

  # Default 'ylim'
  ylim <- c(-1,+1)*3

  xlim0 <- xlim

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Setup the PNG device
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (is.null(imageFormat)) {
    imageFormat <- "current"
  }

  resScale <- 1
  if (identical(imageFormat, "current")) {
    plotDev <- NULL
    zooms <- zooms[1]
  } else if (identical(imageFormat, "screen")) {
    screenDev <- function(pathname, width, height, ...,
                                                  xpinch=50, ypinch=xpinch) {
      # Dimensions are in pixels. Rescale to inches
      width <- width/xpinch
      height <- height/ypinch
      dev.new(width=width, height=height, ...)
    }

    # When plotting to the screen, use only the first zoom
    zooms <- zooms[1]
    plotDev <- screenDev
  } else if (identical(imageFormat, "png")) {
    pngDev <- findPngDevice(transparent=TRUE)
    plotDev <- pngDev
    if (identical(pngDev, png2))
      resScale <- 2
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Define the plot function
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Creating image layers")

  for (chromosome in chromosomes) {
    nbrOfBases <- genome$nbrOfBases[chromosome]
    widthMb <- nbrOfBases / 10^unit

    # Argument 'xlim' missing?
    xlim <- xlim0
    if (is.null(xlim)) {
      xlim <- c(0, widthMb)
    }
    verbose && enter(verbose, sprintf("Plotting chromosome %02d [%.2f Mbp]", chromosome, widthMb))

    tryCatch({
      for (zz in seq_along(zooms)) {
        zoom <- zooms[zz]

        # Create the pathname to the file
        imgName <- sprintf("chr%02d,x%04d.%s", chromosome, zoom, imageFormat)
        pathname <- filePath(path, imgName)

        # pngDev() (that is bitmap()) does not accept spaces in pathnames
        pathname <- gsub(" ", "_", pathname)
        if (!imageFormat %in% c("screen", "current")) {
          if (skip && isFile(pathname)) {
            next
          }
        }

        # Calculate width in pixels from Mbps
        width <- round(zoom * widthMb * pixelsPerMb + sum(xmargin))

        # Plot to PNG file
        verbose && printf(verbose, "Pathname: %s\n", pathname)
        verbose && printf(verbose, "Dimensions: %dx%d\n", width, height)

        args <- list(cns=this, chromosome=chromosome, xlim=xlim, ylim=ylim, unit=unit, width=width, height=height, zoom=zoom, pixelsPerMb=pixelsPerMb, nbrOfBases=nbrOfBases, ..., verbose=less(verbose,1))

        if (!is.null(plotDev))
          plotDev(pathname, width=width, height=height)

        if (transparent) {
          par(bg=NA, xaxs="r")
        } else {
          par(xaxs="r")
        }

        tryCatch({
          do.call(FUN, args=args)
        }, error = function(ex) {
          print(ex)
        }, finally = {
          if (!imageFormat %in% c("screen", "current"))
            dev.off()
        })
      } # for (zz in ...)
    }, error = function(ex) {
      print(ex)
    }, finally = {
    }) # tryCatch()

    verbose && exit(verbose)
  } # for (...)

  verbose && exit(verbose)

  invisible()
}, protected=TRUE) # plotChromosomesLayers()



setMethodS3("plotAxesLayers", "CopyNumberChromosomalModel", function(this, path=NULL, pixelsPerTick=2.5, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  drawXAxisRuler <- function(xrange=NULL, ticksBy=1) {
    xlim <- par("usr")[1:2]
    if (is.null(xrange))
      xrange <- xlim

    for (kk in 1:3) {
      at <- seq(from=xrange[1], to=xrange[2], by=ticksBy*c(1,5,10)[kk])
      keep <- (at >= xlim[1] & at <= xlim[2])
      at <- at[keep]
      tcl <- c(0.2,0.4,0.6)[kk]
      lwd <- c(1,1,2)[kk]
      for (ss in c(1,3))
        axis(side=ss, at=at, tcl=tcl, lwd=lwd, labels=FALSE)
    }
    cxy <- par("cxy")
    text(x=at, y=par("usr")[3]-0.5*cxy[2], labels=at, srt=90,
                                       adj=1, cex=1, xpd=TRUE)
  } # drawXAxisRuler()



  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'pixelsPerTick':
  pixelsPerTick <- Arguments$getDouble(pixelsPerTick, range=c(1,256))

  # The report path
  if (is.null(path)) {
    path <- getReportPath(this)
    path <- filePath(getParent(path), "axes,chrLayer")
    path <- Arguments$getWritablePath(path)
  }
  path <- Arguments$getWritablePath(path)


  plotChromosomesLayers(this, FUN=function(..., zoom, unit, nbrOfBases, pixelsPerMb, verbose=FALSE) {
    # Calculate Mbps per ticks
    ticksBy <- 10^ceiling(log10(pixelsPerTick / (zoom * pixelsPerMb)))
    verbose && printf(verbose, "Ticks by: %f\n", ticksBy)

    suppressWarnings({
      # Create empty plot
      newPlot(this, ..., xlab="", ylab="", unit=unit, flavor="ce")

      # Add ruler
      drawXAxisRuler(xrange=c(0,nbrOfBases)/10^unit, ticksBy=ticksBy)
    })
  }, path=path, ...)
}, protected=TRUE) # plotAxesLayers()


setMethodS3("plotGridHorizontalLayers", "CopyNumberChromosomalModel", function(this, path=NULL, cnLevels=c(1/2,1,3/2), col="blue", lty=2, ...) {
  # The report path
  if (is.null(path)) {
    path <- getReportPath(this)
    path <- filePath(getParent(path), "gridH,chrLayer")
  }
  path <- Arguments$getWritablePath(path)

  plotChromosomesLayers(this, FUN=function(..., verbose=FALSE) {
    verbose && enter(verbose, "Plotting transparent image")
    suppressWarnings({
      # Create empty plot
      newPlot(this, ..., xlab="", ylab="", yaxt="n", flavor="ce")

      for (level in cnLevels) {
        abline(h=log2(level), col=col, lty=lty)
      }
    })
  }, path=path, ...)
}, protected=TRUE) # plotGridHorizontalLayers()



setMethodS3("plotCytobandLayers", "CopyNumberChromosomalModel", function(this, path=NULL, ...) {
  # The report path
  if (is.null(path)) {
    path <- getReportPath(this)
    path <- filePath(getParent(path), "cytoband,chrLayer")
  }
  path <- Arguments$getWritablePath(path)

  plotChromosomesLayers(this, FUN=function(..., chromosome, unit=unit, verbose=FALSE) {
    suppressWarnings({
      # Create empty plot
      newPlot(this, chromosome=chromosome, unit=unit, ..., xlab="", ylab="", yaxt="n", flavor="ce")

      # Add cytoband to graph (optional; class specific)
      drawCytoband(this, chromosome=chromosome, unit=unit)
    })
  }, path=path, ...)
}, protected=TRUE) # plotCytobandLayers()
