setMethodS3("plotSampleLayers", "CopyNumberChromosomalModel", function(this, arrays=NULL, chromosomes=getChromosomes(this), FUN, path, xlim=NULL, ..., pixelsPerMb=3, zooms=2^(0:6), height=400, xmargin=c(50,50), imageFormat="current", transparent=FALSE, skip=TRUE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'arrays':
  if (identical(arrays, "fitted")) {
  } else {
    arrays <- indexOf(this, arrays);
  }

  allChromosomes <- getChromosomes(this);

  # Argument 'chromosomes':
  if (identical(chromosomes, "fitted")) {
  } else if (is.null(chromosomes)) {
    chromosomes <- getChromosomes(this);
  } else if (is.numeric(chromosomes)) {
    chromosomes <- Arguments$getChromosomes(chromosomes,
                                                range=range(allChromosomes));
    chromosomes <- intersect(chromosomes, allChromosomes);
  } else if (is.character(chromosomes)) {
    chromosomes <- Arguments$getChromosomes(chromosomes,
                                                range=range(allChromosomes));
    chromosomes <- intersect(chromosomes, getChromosomes(this));
  }

  # Argument 'FUN':
  if (!is.function(FUN)) {
    throw("Arguments 'FUN' is not a function: ", class(FUN)[1]);
  }

  # Argument 'pixelsPerMb':
  pixelsPerMb <- Arguments$getDouble(pixelsPerMb, range=c(0.001,9999));

  # Argument 'zooms':
  zooms <- Arguments$getIntegers(zooms, range=c(1,9999));
  zooms <- unique(zooms);

  # Argument 'height':
  height <- Arguments$getInteger(height, range=c(1,4096));

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  # Get genome annotation data (chromosome lengths etc)
  genome <- getGenomeData(this);

  # In units of 10^unit bases (default is Mb)
  unit <- 6;

  # Default 'ylim'
  ylim <- c(-1,+1)*3;


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Setup the PNG device
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (is.null(imageFormat)) {
    imageFormat <- "current";
  }

  resScale <- 1;
  if (identical(imageFormat, "current")) {
    plotDev <- NULL;
    zooms <- zooms[1];
  } else if (identical(imageFormat, "screen")) {
    screenDev <- function(pathname, width, height, ..., xpinch=50, ypinch=xpinch) {
      # Dimensions are in pixels. Rescale to inches
      width <- width/xpinch;
      height <- height/ypinch;
      dev.new(width=width, height=height, ...);
    }

    # When plotting to the screen, use only the first zoom
    zooms <- zooms[1];
    plotDev <- screenDev;
  } else if (identical(imageFormat, "png")) {
    pngDev <- findPngDevice(transparent=TRUE);
    plotDev <- pngDev;
    if (identical(pngDev, png2))
      resScale <- 2;
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Array by array
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  xlim0 <- xlim;
  res <- list();
  arrayFullNames <- getFullNames(this)[arrays];
  arrayNames <- getNames(this)[arrays];
  nbrOfArrays <- length(arrayNames);
  for (aa in seq_len(nbrOfArrays)) {
    array <- arrays[aa]; # A number
    arrayFullName <- arrayFullNames[aa];
    arrayName <- arrayNames[aa];

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Chromosome by chromosome
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    res[[arrayName]] <- list();
    for (chromosome in chromosomes) {
      verbose && enter(verbose,
                          sprintf("Array #%d ('%s') of %d on chromosome %s",
                                    aa, arrayName, nbrOfArrays, chromosome));

      # Infer the length (in bases) of the chromosome
      nbrOfBases <- genome$nbrOfBases[chromosome];
      widthMb <- nbrOfBases / 10^unit;

      xlim <- xlim0;
      # Argument 'xlim' missing?
      if (is.null(xlim)) {
        xlim <- c(0, widthMb);
      }

      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # Zoom by zoom
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      for (zoom in zooms) {
        # Create the pathname to the file
        imgName <- sprintf("%s,chr%02d,x%04d.%s",
                          arrayFullName, chromosome, zoom, imageFormat);
        pathname <- filePath(path, imgName);

        # pngDev() (that is bitmap()) does not accept spaces in pathnames
        pathname <- gsub(" ", "_", pathname);
        if (!imageFormat %in% c("screen", "current")) {
          if (skip && isFile(pathname)) {
            next;
          }
        }

        # Calculate width in pixels from Mbps
        width <- round(zoom * widthMb * pixelsPerMb + sum(xmargin));

        # Plot to PNG file
        verbose && printf(verbose, "Pathname: %s\n", pathname);
        verbose && printf(verbose, "Dimensions: %dx%d\n", width, height);

        if (!is.null(plotDev))
          plotDev(pathname, width=width, height=height);

        if (transparent) {
          par(bg=NA, xaxs="r");
        } else {
          par(xaxs="r");
        }

        tryCatch({
          args <- list(cncModel=this, array=array, chromosome=chromosome,
                       xlim=xlim, ylim=ylim, unit=unit,
                       width=width, height=height,
                       zoom=zoom, pixelsPerMb=pixelsPerMb,
                       nbrOfBases=nbrOfBases, ..., verbose=less(verbose,1));
          do.call(FUN, args=args);
        }, error = function(ex) {
          print(ex);
        }, finally = {
          if (!imageFormat %in% c("screen", "current"))
            dev.off();
        });
      } # for (zoom in ...)

      verbose && exit(verbose);
    } # for (chromosome in ...)
  } # for (aa in ...)

  invisible();
}, protected=TRUE) # plotSampleLayers()
