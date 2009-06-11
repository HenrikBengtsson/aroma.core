###########################################################################/**
# @RdocClass SegmentedGenomicSignalsInterface
#
# @title "The SegmentedGenomicSignalsInterface class interface"
#
# \description{
#  @classhierarchy
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# @author
#*/########################################################################### 
setConstructorS3("SegmentedGenomicSignalsInterface", function(...) {
  extend(Interface(), "SegmentedGenomicSignalsInterface");
})

setMethodS3("setStates", "SegmentedGenomicSignalsInterface", function(this, states=NULL, ...) {
  # Argument 'states':
  if (!is.null(states)) {
    if (is.function(states)) {
    } else {
      throw("Argument 'states' must be a function: ", mode(states));
    }
  }

  this$.states <- states;

  invisible(this);
})


setMethodS3("getStates", "SegmentedGenomicSignalsInterface", function(this, x=getPositions(this), ...) {
  # Argument 'x':
  x <- Arguments$getNumerics(x, disallow=NULL);

  nbrOfLoci <- length(x);

  states <- this$.states;

  if (is.function(states)) {
    fcn <- states;
    chromosome <- getChromosome(this);
    name <- getName(this);
    states <- fcn(x, chromosome=chromosome, name=name, ...);
    storage.mode(states) <- "integer";
  }

  # Sanity check
  stopifnot(length(states) == nbrOfLoci);

  states;
})


setMethodS3("getUniqueStates", "SegmentedGenomicSignalsInterface", function(this, ...) {
  states <- getStates(this, ...);
  states <- unique(states);
  states <- sort(states, na.last=TRUE);
  states;
})


setMethodS3("as.data.frame", "SegmentedGenomicSignalsInterface", function(x, ...) {
  # To please R CMD check
  this <- x;

  df <- NextMethod("as.data.frame", this, ...);
  df$state <- getStates(this, x=df$x);

  df;
})


setMethodS3("extractSubsetByState", "SegmentedGenomicSignalsInterface", function(this, states, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'states':
  states <- Arguments$getVector(states);


  # Identify loci that have the requested states
  signalStates <- getStates(this);
  keep <- is.element(signalStates, states);
  keep <- whichVector(keep);

  # Extract this subset
  extractSubset(this, subset=keep, ...);
})

 

setMethodS3("kernelSmoothingByState", "SegmentedGenomicSignalsInterface", function(this, xOut=NULL, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'xOut':
  if (!is.null(xOut)) {
    xOut <- Arguments$getNumerics(xOut);
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Smoothing data set");
  x <- getPositions(this);

  if (is.null(xOut)) {
    xOut <- x;
  }
  verbose && cat(verbose, "xOut:");
  verbose && str(verbose, xOut);

  naValue <- as.double(NA);
  yOut <- rep(naValue, length(xOut));

  y <- getSignals(this);
  states <- getStates(this);

  uniqueStates <- unique(states);
  uniqueStates <- sort(uniqueStates, na.last=TRUE);
  verbose && cat(verbose, "Unique states:");
  verbose && str(verbose, uniqueStates);

  # Identify states of target loci
  statesOut <- getStates(this, x=xOut);

  for (ss in seq(along=uniqueStates)) {
    state <- uniqueStates[ss];
    verbose && enter(verbose, sprintf("State #%d ('%d') of %d", 
                                      ss, state, length(uniqueStates)));

    # Identifying loci with this state
    if (is.na(state)) {
      keep <- is.na(states);
    } else {
      keep <- (states == state);
    }
    keep <- whichVector(keep);
    statesSS <- states[keep];
    ySS <- y[keep];
    xSS <- x[keep];

    # Identify target loci with this state
    if (is.na(state)) {
      keep <- is.na(statesOut);
    } else {
      keep <- (statesOut == state);
    }
    keep <- whichVector(keep);
    xOutSS <- xOut[keep];

    verbose && enter(verbose, "Kernel smoothing");
    verbose && cat(verbose, "Arguments:");
    args <- list(y=ySS, x=xSS, xOut=xOutSS, ...);
    verbose && str(verbose, args);
    yOutSS <- kernelSmoothing(y=ySS, x=xSS, xOut=xOutSS, ...);
    verbose && str(verbose, yOutSS);
    verbose && exit(verbose);
      
    yOut[keep] <- yOutSS;
    verbose && exit(verbose);
  } # for (ss ...)
  verbose && str(verbose, yOut);

  verbose && enter(verbose, "Creating result object");
  res <- clone(this);
  clearCache(res);
  res$y <- yOut;
  res$x <- xOut;
  verbose && exit(verbose);

  verbose && exit(verbose);

  res;
}) # kernelSmoothingByState()



setMethodS3("binnedSmoothingByState", "SegmentedGenomicSignalsInterface", function(this, from=xMin(this), to=xMax(this), by=NULL, length.out=NULL, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  x <- getPositions(this);
  # Argument 'from' & 'to':
  if (is.null(from)) {
    from <- min(x, na.rm=TRUE);
  } else {
    from <- Arguments$getInteger(from);
  }
  if (is.null(to)) {
    to <- max(x, na.rm=TRUE);
  } else {
    to <- Arguments$getInteger(to, range=c(from, Inf));
  }

  # Arguments 'by' & 'length.out':
  if (is.null(by) & is.null(length.out)) {
    throw("Either argument 'by' or 'length.out' needs to be given.");
  }
  if (!is.null(by)) {
    by <- Arguments$getNumeric(by, range=c(0,to-from));
  }
  if (!is.null(length.out)) {
    length.out <- Arguments$getInteger(length.out, range=c(1,Inf));
  }
 
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Binning data set");
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Allocate result set
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Allocating result set");
  res <- clone(this);
  clearCache(res);

  # Target 'x':
  if (!is.null(by)) {
    xOut <- seq(from=from, to=to, by=by);
  } else {
    xOut <- seq(from=from, to=to, length.out=length.out);
  }
  verbose && cat(verbose, "xOut:");
  verbose && str(verbose, xOut);
  # Sanity check
  xOut <- Arguments$getNumerics(xOut);
  res$x <- xOut;

  # Target 'y':
  res$y <- rep(as.double(NA), length(xOut));

  verbose && print(verbose, res);
  verbose && exit(verbose);


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Binning (target) state by state
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  statesOut <- getStates(res);
  verbose && cat(verbose, "statesOut:");
  verbose && str(verbose, statesOut);
  uniqueStates <- unique(statesOut);
  uniqueStates <- sort(uniqueStates, na.last=TRUE);
  verbose && cat(verbose, "Unique output states:");
  verbose && str(verbose, uniqueStates);

  for (ss in seq(along=uniqueStates)) {
    state <- uniqueStates[ss];
    verbose && enter(verbose, sprintf("State #%d ('%d') of %d", 
                                      ss, state, length(uniqueStates)));

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Identify target loci with this state
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    verbose && enter(verbose, "Extracting subset of (target) loci with this signal state");
    idxsOut <- whichVector(is.element(statesOut, state));
    resSS <- extractSubset(res, idxsOut, verbose=less(verbose,50));
    print(resSS);
    verbose && exit(verbose);
    # Nothing to do? [Should actually never happen!]
    if (nbrOfLoci(resSS) == 0) {
      verbose && exit(verbose);
      next;
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Identifying source loci with this state
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    verbose && enter(verbose, "Extracting subset of (source) loci with this signal state");
    gsSS <- extractSubsetByState(this, states=state, verbose=less(verbose,50));
    print(gsSS);
    verbose && exit(verbose);
    # Nothing to do?
    if (nbrOfLoci(gsSS) == 0) {
      verbose && exit(verbose);
      next;
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Bin loci of this state towards target loci (of the same state)
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    verbose && enter(verbose, "Binned smoothing of temporary object");
    xOutSS <- getPositions(resSS);
    verbose && cat(verbose, "Arguments:");
    args <- list(xOut=xOutSS, by=by, ...);
    verbose && str(verbose, args);
    resSS <- binnedSmoothing(gsSS, xOut=xOutSS, by=by, ...);
    verbose && print(verbose, resSS);
    rm(gsSS, args);
    verbose && exit(verbose);

    res$y[idxsOut] <- resSS$y;
    rm(resSS);

    verbose && exit(verbose);
  } # for (ss ...)

  verbose && print(verbose, res);
  verbose && exit(verbose);

  res;
}) # binnedSmoothingByState()



setMethodS3("getStateColors", "SegmentedGenomicSignalsInterface", function(this, ...) {
  states <- getStates(this);

  # Neutral states
  col <- rep("#000000", nbrOfLoci(this));

  # Losses
  col[states < 0] <- "blue";

  # Gains
  col[states > 0] <- "red";

  # Unknown
  col[is.na(states)] <- "#999999";

  col;
})


setMethodS3("plot", "SegmentedGenomicSignalsInterface", function(x, ..., col=getStateColors(x)) {
  NextMethod("plot", ..., col=col);
})

setMethodS3("points", "SegmentedGenomicSignalsInterface", function(x, ..., col=getStateColors(x)) {
  NextMethod("points", ..., col=col);
})



############################################################################
# HISTORY:
# 2009-06-10
# o Added setStates().
# o Created SegmentedGenomicSignalsInterface class from SegmentedCopyNumbers.R.
# 2009-05-16
# o Now all methods of SegmentedRawCopyNumbers() coerce numerics only if
#   necessary, i.e. it keeps integers if integers, otherwise to doubles.
#   This is a general design of aroma.* that saves some memory.
# 2009-04-06
# o Now binnedSmoothingByState() of SegmentedCopyNumbers uses 
#   extractSubsetByState() and then binnedSmoothing() on that object.  
#   This makes the code slightly less redundant.
# 2009-02-19
# o Adopted to make use of new RawGenomicSignals.
# 2009-02-16
# o Now getStates() also passes the optional 'name' field to the "truth"
#   function.
# 2009-02-08
# o Added getUniqueStates().
# 2009-02-07
# o Added extractSubsetByState().
# o Created.
############################################################################
