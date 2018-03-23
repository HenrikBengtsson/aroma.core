setMethodS3("onFitAddGenotypeCalls", "default", function(fit, ...) {
}, protected=FALSE)

setMethodS3("onFitAddGenotypeCalls", "GladModel", function(gladFit, callList, arrayName, resScale=1e6, ylim=NULL, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  gladFit <- Arguments$getInstanceOf(gladFit, "profileCGH");

  # Nothing to do?
  if (is.null(callList)) {
    return();
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Setup
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Extract data
  pv <- gladFit$profileValues;

  # Identify chip types included
  chipTypes <- sort(unique(pv$chipType));
  if (length(chipTypes) == 0) {
    warning("Could not add genotype call tracks.  No chip type information available.");
    return();
  }

  callCols <- c("-"="lightgray", AA="red", AB="blue", BB="red", NC="orange");

  # Extract the chromosome from the GLAD fit object
  pv <- gladFit$profileValues;

  verbose && enter(verbose, "Adding genotype calls");

  # Figure out where to put the genotype track?
  if (is.null(ylim)) {
    ylim <- par("usr")[3:4];
    ylim <- ylim + c(+1,-1)*0.04*diff(ylim);
    ylim <- ylim + c(+1,-1)*0.04*diff(ylim);
  }

  # Get (chip type, unit) information
  chipType <- pv$chipType;
  unit <- pv$unit;

  # Add call tracks for each chip type available
  for (chipType in chipTypes) {
    # Got genotype calls for this chip type?
    callSet <- callList[[chipType]];
    if (is.null(callSet))
      next;

    # Got chip-effect estimates for this chip type?
    idxs <- which(pv$chipType == chipType);
    if (length(idxs) == 0)
      next;

    # Got genotype calls for this array?
    if (!arrayName %in% getNames(callSet))
      next;

    # Get subset of genotype calls for this array & chromosome.
    units <- pv$unit[idxs];
    call <- callSet[units, arrayName];
    call <- as.character(call);

    # Get the positions of these calls
    x <- pv$PosBase[idxs];
    x <- x/resScale;

    # Plot the homozygote/heterozygote genotype tracks
    y <- rep(ylim[1], length(callCols));
    names(y) <- names(callCols);
    y["AB"] <- y["AB"] + 0.02*diff(ylim);
    y <- y[call];
    points(x,y, pch=".", cex=2, col=callCols[call]);

    # Not needed anymore
    idxs <- call <- callSet <- units <- x <- y <- NULL;
  } # for (chipType ...)

  verbose && exit(verbose);
}, protected=TRUE) # onFitAddGenotypeCalls()
