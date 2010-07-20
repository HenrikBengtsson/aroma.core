###########################################################################/**
# @RdocClass RawGenomicSignals
#
# @title "The RawGenomicSignals class"
#
# \description{
#  @classhierarchy
# }
# 
# @synopsis
#
# \arguments{
#   \item{y}{A @numeric @vector of length J specifying the signal
#     at each locus.}
#   \item{x}{A (optional) @numeric @vector of length J specifying the 
#     position of each locus.}
#   \item{w}{A (optional) non-negative @numeric @vector of length J 
#     specifying a weight of each locus.}
#   \item{chromosome}{An (optional) @integer specifying the chromosome for
#     these genomic signals.}
#   \item{name}{An (optional) @character string specifying the sample name.}
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# @author
#*/########################################################################### 
setConstructorS3("RawGenomicSignals", function(y=NULL, x=NULL, w=NULL, chromosome=NA, name=NULL, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'y':
  object <- NULL;
  if (!is.null(y)) {
    if (inherits(y, "RawGenomicSignals")) {
      object <- y;
      y <- object$y;
      x <- object$x;
      w <- object$w;
      chromosome <- object$chromosome;
      name <- object$name;
    }

    if (!is.vector(y)) {
      throw("Argument 'y' must be a vector: ", mode(y)[1]);
    }

    if (!is.numeric(y)) {
      throw("Argument 'y' must be a numeric: ", class(y)[1]);
    }
  }
  n <- length(y);

  # Argument 'x':
  if (!is.null(x)) {
    x <- Arguments$getNumerics(x, length=c(n,n));
  }

  # Argument 'w':
  if (!is.null(w)) {
    w <- Arguments$getNumerics(w, range=c(0,Inf), length=c(n,n));
  }

  # Argument 'chromosome':
  if (!is.na(chromosome)) {
    chromosome <- Arguments$getIndex(chromosome);
  }

  # Arguments '...':
  args <- list(...);
  if (length(args) > 0) {
    argsStr <- paste(names(args), collapse=", ");
    throw("Unknown arguments: ", argsStr);
  } 

  this <- extend(Object(), "RawGenomicSignals", 
    y = y,
    x = x,
    w = w,
    chromosome = chromosome,
    .name = name
  );

  # Append other locus fields?
  if (!is.null(object)) {
    fields <- setdiff(getLocusFields(object), getLocusFields(this));
    for (field in fields) {
      this[[field]] <- object[[field]];
    }
    addLocusFields(this, fields);
  }

  this;
})


setMethodS3("as.character", "RawGenomicSignals", function(x, ...) {
  # To please R CMD check
  this <- x;

  s <- sprintf("%s:", class(this)[1]);
  name <- getName(this);
  if (is.null(name)) name <- "";
  s <- c(s, sprintf("Name: %s", as.character(name)));
  s <- c(s, sprintf("Chromosome: %d", getChromosome(this)));
  xRange <- xRange(this);
  s <- c(s, sprintf("Position range: [%g,%g]", xRange[1], xRange[2]));
  n <- nbrOfLoci(this);
  s <- c(s, sprintf("Number of loci: %d", n));
  dAvg <- if (n >= 2) diff(xRange)/(n-1) else as.double(NA);
  s <- c(s, sprintf("Mean distance between loci: %g", dAvg));

  fields <- getLocusFields(this);
  fields <- sapply(fields, FUN=function(field) {
    values <- this[[field]];
    mode <- mode(values);
    sprintf("%s [%dx%s]", field, length(values), mode);
  })
  fields <- paste(fields, collapse=", ");
  s <- c(s, sprintf("Loci fields: %s", fields));
  s <- c(s, sprintf("RAM: %.2fMB", objectSize(this)/1024^2));
  class(s) <- "GenericSummary";
  s;
}, private=TRUE) 


setMethodS3("nbrOfLoci", "RawGenomicSignals", function(this, na.rm=FALSE, ...) {
  y <- getSignals(this);
  if (na.rm) {
    y <- y[is.finite(y)];
  }
  length(y);
})

setMethodS3("getPositions", "RawGenomicSignals", function(this, ...) {
  x <- this$x;
  if (is.null(x)) {
    x <- seq(length=nbrOfLoci(this));
  }
  x;
})


setMethodS3("getChromosome", "RawGenomicSignals", function(this, ...) {
  chr <- this$chromosome;
  if (is.null(chr))
    chr <- NA;
  chr <- as.integer(chr);
  chr;
})


setMethodS3("getSignals", "RawGenomicSignals", function(this, ...) {
  this$y;
})


setMethodS3("setWeights", "RawGenomicSignals", function(this, weights, ...) {
  # Argument 'weights':
  n <- length(getSignals(this));
  weights <- Arguments$getNumerics(weights, length=rep(n,2), range=c(0,Inf));
  this$w <- weights;
  invisible(this);
})

setMethodS3("getWeights", "RawGenomicSignals", function(this, ...) {
  this$w;
})

setMethodS3("hasWeights", "RawGenomicSignals", function(this, ...) {
  (!is.null(getWeights(this, ...)));
})



setMethodS3("getName", "RawGenomicSignals", function(this, ...) {
  this$.name;
})


setMethodS3("setName", "RawGenomicSignals", function(this, name, ...) {
  if (!is.null(name)) {
    name <- Arguments$getCharacter(name);
  }
  this$.name <- name;
  invisible(this);
})


setMethodS3("as.data.frame", "RawGenomicSignals", function(x, ...) {
  # To please R CMD check
  this <- x;

  fields <- getLocusFields(this);
  data <- NULL;
  for (cc in seq(along=fields)) {
    field <- fields[cc];
    values <- this[[field]];
    if (cc == 1) {
      data <- data.frame(values);
    } else {
      data[[field]] <- values;
    }
  } # for (cc ...)
  colnames(data) <- fields;

  data;
})

setMethodS3("summary", "RawGenomicSignals", function(object, ...) {
  # To please R CMD check
  this <- object;

  summary(as.data.frame(this));
})


setMethodS3("getLocusFields", "RawGenomicSignals", function(this, ...) {
  fields <- this$.locusFields;
  if (is.null(fields)) {
    fields <- c("x", "y");
    if (hasWeights(this)) {
      fields <- c(fields, "w");
    }
  }
  fields;
})

setMethodS3("setLocusFields", "RawGenomicSignals", function(this, fields, ...) {
  # Argument 'field':
  fields <- Arguments$getCharacters(fields);

  oldFields <- this$.locusFields;

  # Always keep (x,y)
  fields <- unique(c("x", "y", fields));

  # Update
  this$.locusFields <- fields;

  invisible(oldFields);
})

setMethodS3("addLocusFields", "RawGenomicSignals", function(this, fields, ...) {
  oldFields <- getLocusFields(this);
  fields <- c(oldFields, fields);
  fields <- unique(fields);
  setLocusFields(this, fields, ...);
})

setMethodS3("getLociFields", "RawGenomicSignals", function(this, ...) {
  getLocusFields(this, ...);
}, deprecated=TRUE, protected=TRUE)


setMethodS3("sort", "RawGenomicSignals", function(x, ...) {
  # To please R CMD check
  this <- x;

  res <- clone(this);
  x <- getPositions(res);
  o <- order(x);
  rm(x);
  for (field in getLocusFields(res)) {
    res[[field]] <- res[[field]][o];
  }
  res;
})


setMethodS3("getXY", "RawGenomicSignals", function(this, sort=TRUE, ...) {
  xy <- data.frame(x=this$x, y=this$y);
  if (sort)
    xy <- xy[order(xy$x),,drop=FALSE];
  xy;
})



setMethodS3("extractRegion", "RawGenomicSignals", function(this, region, ...) {
  # Argument 'region':
  region <- Arguments$getNumerics(region, length=c(2,2));
  stopifnot(region[1] <= region[2]);

  res <- clone(this);

  x <- getPositions(this);
  keep <- whichVector(region[1] <= x & x <= region[2]);

  fields <- getLocusFields(res);
  for (ff in seq(along=fields)) {
    field <- fields[ff];
    res[[field]] <- this[[field]][keep];
  } # for (ff ...)

  res;   
})



setMethodS3("extractRegions", "RawGenomicSignals", function(this, regions, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'regions':
  cl <- class(regions)[1];
  if (inherits(regions, "CopyNumberRegions")) {
    regions <- as.data.frame(regions);
    regions <- regions[,c("start", "stop")];
  }
  if (is.data.frame(regions)) {
    regions <- as.matrix(regions);
  }
  if (!is.matrix(regions)) {
    throw("Argument 'regions' is not a matrix or data.frame: ", cl);
  }
  if (ncol(regions) != 2) {
    throw("Argument 'regions' does not have two columns: ", ncol(regions));
  }
  regions <- Arguments$getNumerics(regions);
  stopifnot(all(regions[1] <= regions[2]));

  res <- clone(this);
  x <- getPositions(this);

  keep <- rep(FALSE, times=length(x));
  for (kk in seq(length=nrow(regions))) {
    region <- regions[kk,,drop=TRUE];
    keepKK <- (region[1] <= x & x <= region[2]);
    keep <- keep | keepKK;
  }

  fields <- getLocusFields(res);
  for (ff in seq(along=fields)) {
    field <- fields[ff];
    res[[field]] <- this[[field]][keep];
  }

  res;
}) # extractRegions()


setMethodS3("extractSubset", "RawGenomicSignals", function(this, subset, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'subset':
  subset <- Arguments$getIndices(subset, max=nbrOfLoci(this));

  res <- clone(this);
  clearCache(res);

  for (field in getLocusFields(res)) {
    res[[field]] <- res[[field]][subset];
  }

  res;
})



setMethodS3("kernelSmoothing", "RawGenomicSignals", function(this, xOut=NULL, ..., verbose=FALSE) {
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
  y <- getSignals(this);
  x <- getPositions(this);

  if (is.null(xOut)) {
    xOut <- x;
  }

  verbose && cat(verbose, "xOut:");
  verbose && str(verbose, xOut);

  verbose && enter(verbose, "Kernel smoothing");
  verbose && cat(verbose, "Arguments:");
  args <- list(y=y, x=x, xOut=xOut, ...);
  verbose && str(verbose, args);
  ys <- kernelSmoothing(y=y, x=x, xOut=xOut, ...);
  verbose && str(verbose, ys);
  verbose && exit(verbose);


  verbose && enter(verbose, "Creating result object");
  res <- clone(this);
  clearCache(res);
  res$y <- ys;
  res$x <- xOut;
  verbose && exit(verbose);

  verbose && exit(verbose);

  res;
}) # kernelSmoothing()


setMethodS3("gaussianSmoothing", "RawGenomicSignals", function(this, sd=10e3, ...) {
  kernelSmoothing(this, kernel="gaussian", h=sd, ...);
})



setMethodS3("binnedSmoothing", "RawGenomicSignals", function(this, ..., weights=getWeights(this), byCount=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'weights':
  if (!is.null(weights)) {
    weights <- Arguments$getNumerics(weights, length=rep(nbrOfLoci(this),2),
                                                           range=c(0,Inf));
  }

  # Argument 'byCount':
  byCount <- Arguments$getLogical(byCount);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Smoothing data set");
  y <- getSignals(this);
  x <- getPositions(this);
  n <- length(x);
  xRange <- range(x, na.rm=TRUE);
  verbose && printf(verbose, "Range of positions: [%.0f,%.0f]\n", 
                                           xRange[1], xRange[2]);

  locusFields <- NULL;
  wOut <- NULL;
  if (n > 0) {
    if (byCount) {
      verbose && enter(verbose, "Binned smoothing (by count)");
      # Smoothing y and x (and w).
      Y <- cbind(y=y, x=x, w=weights);
      locusFields <- colnames(Y);
      xRank <- seq(length=nrow(Y));
      verbose && cat(verbose, "Positions (ranks):");
      verbose && str(verbose, xRank);
      verbose && cat(verbose, "Arguments:");
      args <- list(Y=Y, x=xRank, w=weights, ...);
      verbose && str(verbose, args);
      Ys <- colBinnedSmoothing(Y=Y, x=xRank, w=weights, ..., verbose=less(verbose, 10));
      verbose && str(verbose, Ys);
      xOut <- attr(Ys, "xOut");
      verbose && str(verbose, xOut);
      # The smoothed y:s
      ys <- Ys[,1,drop=TRUE];
      # The smoothed x:s, which becomes the new target positions
      xOut <- Ys[,2,drop=TRUE];
      # Smoothed weights
      if (!is.null(weights)) {
        wOut <- Ys[,3,drop=TRUE];
      }
      rm(xRank, Y, Ys);
      verbose && exit(verbose);
    } else {
      verbose && enter(verbose, "Binned smoothing (by position)");
      # Smoothing y (and w).
      Y <- cbind(y=y, w=weights);
      verbose && cat(verbose, "Arguments:");
      args <- list(Y=Y, w=weights, ...);
      verbose && str(verbose, args);
      Ys <- colBinnedSmoothing(Y=Y, x=x, w=weights, ..., verbose=less(verbose, 10));
      # The smoothed y:s
      ys <- Ys[,1,drop=TRUE];
      verbose && str(verbose, ys);
      xOut <- attr(Ys, "xOut");
      # Smoothed weights
      if (!is.null(weights)) {
        wOut <- Ys[,2,drop=TRUE];
        wOut[is.na(wOut)] <- 0;
      }
      verbose && exit(verbose);
    }
  } else {
    ys <- double(0);
    xOut <- double(0);
  } # if (n > 0)


  verbose && enter(verbose, "Creating result object");
  res <- clone(this);
  clearCache(res);
  res$y <- ys;
  res$x <- xOut;
  res$w <- wOut;

  # Drop all locus fields not binned [AD HOC: Those should also be binned. /HB 2009-06-30]
  if (!is.null(locusFields)) {
    setLocusFields(res, locusFields);
  }
  verbose && exit(verbose);

  verbose && exit(verbose);

  res;
}) # binnedSmoothing()




###########################################################################/**
# @set "class=RawGenomicSignals"
# @RdocMethod estimateStandardDeviation
#
# @title "Estimates the standard deviation of the raw Ys"
#
# \description{
#  @get "title" robustly or non-robustly using either a "direct" estimator
#  or a first-order difference estimator.
# }
#
# @synopsis
#
# \arguments{
#   \item{method}{If \code{"diff"}, the estimate is based on the first-order
#     contigous differences of raw Ys. If \code{"direct"}, it is based 
#     directly on the raw Ys.}
#   \item{estimator}{If \code{"mad"}, the robust @see "stats::mad" estimator
#     is used.  If \code{"sd"}, the @see "stats::sd" estimator is used.}
#   \item{na.rm}{If @TRUE, missing values are excluded first.}
#   \item{weights}{Locus specific weights.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a non-negative @numeric value.
# }
#
# @author
#
# \seealso{
#   @see "base::diff", @see "stats::sd", and @see "stats::mad".
#   @seeclass
# }
#
# @keyword IO
# @keyword programming
#*/########################################################################### 
setMethodS3("estimateStandardDeviation", "RawGenomicSignals", function(this, method=c("diff", "direct"), estimator=c("mad", "sd"), na.rm=TRUE, weights=getWeights(this), ...) {
  # Argument 'method':
  method <- match.arg(method);

  # Argument 'estimator':
  estimator <- match.arg(estimator);

  y <- getSignals(this);
  n <- length(y);
  if (n <= 1) {
    return(as.double(NA));
  }

  # Argument 'weights':
  if (!is.null(weights)) {
    weights <- Arguments$getNumerics(weights, range=c(0,Inf), length=rep(n,2));
  }

  # Get the estimator function
  if (!is.null(weights)) {
    estimator <- sprintf("weighted %s", estimator);
    estimator <- toCamelCase(estimator);
  }  
  estimatorFcn <- get(estimator, mode="function");

  if (method == "diff") {
    y <- diff(y);

    # Weighted estimator?
    if (!is.null(weights)) {
      # Calculate weights per pair
      weights <- (weights[1:(n-1)]+weights[2:n])/2;
      sigma <- estimatorFcn(y, w=weights, na.rm=na.rm)/sqrt(2);
    } else {
      sigma <- estimatorFcn(y, na.rm=na.rm)/sqrt(2);
    }
  } else if (method == "direct") {
    if (!is.null(weights)) {
      sigma <- estimatorFcn(y, w=weights, na.rm=na.rm);
    } else {
      sigma <- estimatorFcn(y, na.rm=na.rm);
    }
  }

  sigma;
})


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Graphics related methods
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setMethodS3("getXScale", "RawGenomicSignals", function(this, ...) {
  scale <- this$.xScale;
  if (is.null(scale)) scale <- 1e-6;
  scale;
})

setMethodS3("getYScale", "RawGenomicSignals", function(this, ...) {
  scale <- this$.yScale;
  if (is.null(scale)) scale <- 1;
  scale;
})

setMethodS3("setXScale", "RawGenomicSignals", function(this, xScale=1e-6, ...) {
  xScale <- Arguments$getNumeric(xScale);
  this$.xScale <- xScale;
})

setMethodS3("setYScale", "RawGenomicSignals", function(this, xScale=1, ...) {
  yScale <- Arguments$getNumeric(yScale);
  this$.yScale <- yScale;
})

setMethodS3("plot", "RawGenomicSignals", function(x, xlab="Position", ylab="Signal", ylim=c(-3,3), pch=20, xScale=getXScale(this), yScale=getYScale(this), ...) {
  # To please R CMD check
  this <- x;

  x <- getPositions(this);
  y <- getSignals(this);

  plot(xScale*x, yScale*y, ylim=ylim, xlab=xlab, ylab=ylab, pch=pch, ...);
})


setMethodS3("points", "RawGenomicSignals", function(x, pch=20, ..., xScale=getXScale(this), yScale=getYScale(this)) {
  # To please R CMD check
  this <- x;

  x <- getPositions(this);
  y <- getSignals(this);
  points(xScale*x, yScale*y, pch=pch, ...);
})

setMethodS3("lines", "RawGenomicSignals", function(x, ..., xScale=getXScale(this), yScale=getYScale(this)) {
  # To please R CMD check
  this <- x;

  x <- getPositions(this);
  y <- getSignals(this);

  o <- order(x);
  x <- x[o];
  y <- y[o];

  x <- x*xScale;
  y <- y*yScale;

  lines(x, y, ...);
})


setMethodS3("xSeq", "RawGenomicSignals", function(this, from=1, to=xMax(this), by=100e3, ...) {
  seq(from=from, to=to, by=by);
})

setMethodS3("xRange", "RawGenomicSignals", function(this, na.rm=TRUE, ...) {
  x <- getPositions(this);
  range(x, na.rm=na.rm);
})

setMethodS3("xMin", "RawGenomicSignals", function(this, ...) {
  xRange(this, ...)[1];
})

setMethodS3("xMax", "RawGenomicSignals", function(this, ...) {
  xRange(this, ...)[2];
})

setMethodS3("yRange", "RawGenomicSignals", function(this, na.rm=TRUE, ...) {
  y <- getSignals(this);
  range(y, na.rm=na.rm);
})

setMethodS3("yMin", "RawGenomicSignals", function(this, ...) {
  yRange(this, ...)[1];
})

setMethodS3("yMax", "RawGenomicSignals", function(this, ...) {
  yRange(this, ...)[2];
})


setMethodS3("signalRange", "RawGenomicSignals", function(this, na.rm=TRUE, ...) {
  y <- getSignals(this);
  range(y, na.rm=na.rm);
})

setMethodS3("setSigma", "RawGenomicSignals", function(this, sigma, ...) {
  sigma <- Arguments$getNumeric(sigma, range=c(0,Inf), disallow=NULL);
  this$.sigma <- sigma;
})

setMethodS3("getSigma", "RawGenomicSignals", function(this, ..., force=FALSE) {
  sigma <- this$.sigma;
  if (is.null(sigma)) {
    sigma <- estimateStandardDeviation(this, ...);
    setSigma(this, sigma);
  }
  sigma;
})




setMethodS3("extractRawGenomicSignals", "default", abstract=TRUE);




############################################################################
# HISTORY:
# 2010-07-19
# o Now extractRegion() for RawGenomicSignals also accepts a
#   CopyNumberRegions object for argument 'regions'.
# o Added extractRegions() for RawGenomicSignals.
# 2009-11-22
# o Now all chromosome plot functions have xScale=1e-6 by default.
# 2009-10-10
# o Added setName().
# 2009-09-07
# o Added yRange(), yMin() and yMax() to RawGenomicSignals.
# 2009-07-03
# o BUG FIX: binnedSmoothing() added non existing locus field 'w'.
# 2009-06-30
# o Now binnedSmoothing() of RawGenomicSignals drops locus fields that were
#   not binned.  Ideally all locus fields (including custom ones) should be
#   binned, but we leave that for a future implementation.
# 2009-06-13
# o Now RawGenomicSignals(y=rgs) sets all locus fields in 'rgs' if it is
#   a RawGenomicSignals object.
# 2009-05-16
# o Now all methods of RawCopyNumbers() coerce numerics only if necessary,
#   i.e. it keeps integers if integers, otherwise to doubles.  This is a
#   general design of aroma.* that saves some memory.
# 2009-05-13
# o Now as.character() also reports mean distance between loci.
# o Added extractRegion() to RawGenomicSignals.
# o Now estimateStandardDeviation() takes a weighted estimate by default, 
#   if weights are available.
# 2009-05-12
# o BUG FIX: extractSubset() of RawGenomicSignals did not recognize all
#   locus fields.
# o Now getSigma() returns the current standard deviation estimate, and
#   if not available, then it estimate it using estimateStandardDeviation().
# o Now binnedSmoothing() of RawGenomicSignals uses weighted estimates
#   (by default) if weights exists.
# 2009-05-10
# o Added argument 'w=NULL' to the constructor.
# o Added getWeights(), setWeights(), and hasWeights() to RawGenomicSignals.
# 2009-05-07
# o Added (get|set)(X|Y)Scale() to RawGenomicSignals.
# o Added setLocusFields().
# o Renamed getLociFields() to getLocusFields().
# o BUG FIX: lines() of RawGenomicSignals did not recognize x/yScale.
# 2009-04-06
# o BUG FIX: binnedSmoothing(..., byCount=TRUE) of RawGenomicSignals would
#   give error "[...] object "ys" not found".
# 2009-02-19
# o Renamed from RawCopyNumbers RawGenomicSignals.
# o Added argument 'byCount' to binnedSmoothing() of RawGenomicSignals.
# 2009-02-17
# o Now RawGenomicSignals() also takes another RawCopyNumbers object as
#   input.
# 2009-02-16
# o Added optional constructor argument 'name'.
# 2009-02-07
# o Added Rdoc comments and example.
# 2008-05-21
# o Added field 'chromosome' (single value).
# 2008-05-17
# o Added abstract default extractCopyNumberRegions().
# o Moved to aroma.core. 
# 2008-03-31
# o Put recently added sd() and mad() into estimateStandardDeviation().
# 2008-03-10
# o Added standard deviation estimator sd() and mad() which my default
#   uses a first-order difference variance estimator.
# 2007-08-22
# o Created.  Need a generic container for holding copy number data and
#   to plot them nicely.
############################################################################
