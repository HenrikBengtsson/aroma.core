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
setConstructorS3("RawGenomicSignals", function(y=NULL, x=NULL, w=NULL, chromosome=0L, name=NULL, ...) {
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

  # Argument 'chromosome':
  if (is.null(chromosome)) {
    chromosome <- as.integer(NA);
  }
  if (length(chromosome) == 1) {
    chromosome <- rep(chromosome, times=n);
  }
  chromosome <- Arguments$getIntegers(chromosome, range=c(0,Inf), length=c(n,n), disallow=c("NaN", "Inf"));

  # Argument 'x':
  if (!is.null(x)) {
    x <- Arguments$getNumerics(x, length=c(n,n));
  }

  # Argument 'w':
  if (!is.null(w)) {
    w <- Arguments$getNumerics(w, range=c(0,Inf), length=c(n,n));
  }

  # Arguments '...':
  args <- list(...);
  if (length(args) > 0) {
    argsStr <- paste(names(args), collapse=", ");
    throw("Unknown arguments: ", argsStr);
  } 

  this <- extend(BasicObject(), "RawGenomicSignals", 
    chromosome = chromosome,
    x = x,
    y = y,
    w = w
  );

  this <- setName(this, name);

  # Append other locus fields?
  if (!is.null(object)) {
    fields <- setdiff(getLocusFields(object), getLocusFields(this));
    for (field in fields) {
      this[[field]] <- object[[field]];
    }
    this <- addLocusFields(this, fields);
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
  chrs <- getChromosomes(this);
  nbrOfChrs <- length(chrs);
  s <- c(s, sprintf("Chromosomes: %s [%d]", seqToHumanReadable(chrs), nbrOfChrs));
  n <- nbrOfLoci(this);
  s <- c(s, sprintf("Number of loci: %d", n));
  if (nbrOfChrs == 1) {
    xRange <- xRange(this);
    s <- c(s, sprintf("Position range: [%g,%g]", xRange[1], xRange[2]));
    dAvg <- if (n >= 2) diff(xRange)/(n-1) else as.double(NA);
    s <- c(s, sprintf("Mean distance between loci: %g", dAvg));
  }
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

setMethodS3("getChromosomes", "RawGenomicSignals", function(this, ...) {
  chrs <- this$chromosome;
  if (is.null(chrs)) {
    chrs <- as.integer(NA);
  }
  chrs <- as.integer(chrs);
  chrs <- unique(chrs);
  chrs <- sort(chrs);
  chrs;
})

setMethodS3("nbrOfChromosomes", "RawGenomicSignals", function(this, ...) {
  chrs <- getChromosomes(this, ...);
  length(chrs);
})


setMethodS3("assertOneChromosome", "RawGenomicSignals", function(this, ...) {
  if (nbrOfChromosomes(this) > 1) {
    throw(sprintf("Cannot perform operation. %s has more than one chromosome: %s", class(this)[1], nbrOfChromosomes(this)));
  }
}, protected=TRUE)




# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# EXTRACT METHODS
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
setMethodS3("extractSubset", "RawGenomicSignals", function(this, subset, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'subset':
  n <- nbrOfLoci(this);
  if (is.logical(subset)) {
    subset <- Arguments$getLogicals(subset, length=c(n,n));
    subset <- which(subset);
  } else {
    subset <- Arguments$getIndices(subset, max=n);
  }

  res <- clone(this);
  clearCache(res);

  fields <- getLocusFields(res);
  for (ff in seq(along=fields)) {
    field <- fields[ff];
    res[[field]] <- res[[field]][subset];
  } # for (ff ...)

  res;
}) # extractSubset()


setMethodS3("extractRegion", "RawGenomicSignals", function(this, region, chromosome=NULL, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'chromosome':

  # Argument 'region':
  region <- Arguments$getNumerics(region, length=c(2,2));
  stopifnot(region[1] <= region[2]);


  # Subset by chromosome
  if (!is.null(chromosome)) {
    rgs <- extractChromosome(this, chromosome=chromosome);
  } else {
    rgs <- this;
  }

  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(rgs);

  x <- getPositions(rgs);
  keep <- whichVector(region[1] <= x & x <= region[2]);

  extractSubset(rgs, keep);
}) # extractRegion()



setMethodS3("extractRegions", "RawGenomicSignals", function(this, regions, chromosomes=NULL, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'regions':
  cl <- class(regions)[1];
  if (inherits(regions, "CopyNumberRegions")) {
    regions <- as.data.frame(regions);
    regions <- regions[,c("chromosome", "start", "stop")];
  } else if (is.matrix(regions)) {
    regions <- as.data.frame(regions);
  }
  if (!is.data.frame(regions)) {
    throw("Argument 'regions' is neither a CopyNumberRegions object, a data.frame, nor a matrix: ", cl);
  }

  # Argument 'chromosomes':
  if (is.null(chromosomes) && !is.element("chromosome", colnames(regions))) {
    # Backward compatibility only
    # This is a single-chromosome method. Assert that is the case.
    assertOneChromosome(this);
    chromosomes <- getChromosomes(this);
    chromosomes <- rep(chromosomes, times=nrow(regions));
  }

  # Argument 'regions' (again):
  if (!is.null(chromosomes)) {
    if (is.element("chromosome", names(regions))) {
      throw("Argument 'chromosomes' must not be specified when argument 'regions' already specifies chromosomes: ", hpaste(colnames(regions)));
    }
    regions <- cbind(data.frame(chromosome=chromosomes), regions);
    chromosomes <- NULL; # Not needed anymore
  }

  reqs <- c("chromosome", "start", "stop");
  missing <- reqs[!is.element(reqs, colnames(regions))];
  if (length(missing)) {
    throw("Missing fields in argument 'regions': ", hpaste(missing));
  }

  # Extract fields of interest
  regions <- regions[,reqs];

  # Assert the fields are numeric
  for (key in colnames(regions)) {
    regions[[key]] <- Arguments$getNumerics(regions[[key]], .name=key);
  }

  # Assert ordered (start,stop)
  stopifnot(all(regions[["start"]] <= regions[["stop"]]));



  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # For each chromosome
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  chromosome <- this$chromosome;
  x <- getPositions(this);
  keep <- rep(FALSE, times=length(x));
  for (rr in seq(length=nrow(regions))) {
    region <- unlist(regions[rr,], use.names=TRUE);
    chr <- region["chromosome"];
    start <- region["start"];
    stop <- region["stop"];
    keepRR <- (chromosome == chr & start <= x & x <= stop);
    keep <- keep | keepRR;
  } # for (rr ...)

  keep <- which(keep);

  extractSubset(this, keep);
}) # extractRegions()


setMethodS3("extractChromosomes", "RawGenomicSignals", function(this, chromosomes=NULL, ...) {
  # Argument 'chromosomes':
  if (!is.null(chromosomes)) {
    chromosomes <- Arguments$getChromosomes(chromosomes);
    chromosomes <- unique(chromosomes);
    chromosomes <- sort(chromosomes);
  }

  # Nothing todo?
  if (is.null(chromosomes)) {
    return(this);
  }

  keep <- is.element(this$chromosome, chromosomes);
  keep <- which(keep);

  extractSubset(this, keep);
}) # extractChromosomes()


setMethodS3("extractChromosome", "RawGenomicSignals", function(this, chromosome, ...) {
  # Argument 'chromosome':
  chromosome <- Arguments$getChromosome(chromosome);

  extractChromosomes(this, chromosomes=chromosome, ...);  
}) # extractChromosome()



setMethodS3("extractRawGenomicSignals", "default", abstract=TRUE);





setMethodS3("getPositions", "RawGenomicSignals", function(this, ...) {
  # This is a single-chromosome method. Assert that is the case.
  assertOneChromosome(this);

  x <- this$x;
  if (is.null(x)) {
    x <- seq(length=nbrOfLoci(this));
  }
  x;
})


setMethodS3("getChromosome", "RawGenomicSignals", function(this, ...) {
  # This is a single-chromosome method. Assert that is the case.
  assertOneChromosome(this);

  chr <- this$chromosome;
  if (is.null(chr)) {
    chr <- as.integer(NA);
  }
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
  getBasicField(this, ".name");
})


setMethodS3("setName", "RawGenomicSignals", function(this, name, ...) {
  if (!is.null(name)) {
    name <- Arguments$getCharacter(name);
  }
  this <- setBasicField(this, ".name", name);
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
  fields <- getBasicField(this, ".locusFields");
  if (is.null(fields)) {
    fields <- c("chromosome", "x", "y");
    if (hasWeights(this)) {
      fields <- c(fields, "w");
    }
  }
  fields;
})

setMethodS3("setLocusFields", "RawGenomicSignals", function(this, fields, ...) {
  # Argument 'field':
  fields <- Arguments$getCharacters(fields);

  # Always keep (chromosome, x,y)
  fields <- unique(c("chromosome", "x", "y", fields));

  # Update

  this <- setBasicField(this, ".locusFields", fields);

  invisible(this);
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

  # Order by (chromosome, x)
  o <- order(res$chromosome, getPositions(res));

  for (field in getLocusFields(res)) {
    res[[field]] <- res[[field]][o];
  }

  res;
})


setMethodS3("getXY", "RawGenomicSignals", function(this, sort=TRUE, ...) {
  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this);

  xy <- data.frame(x=this$x, y=this$y);
  if (sort)
    xy <- xy[order(xy$x),,drop=FALSE];
  xy;
}, protected=TRUE)

setMethodS3("getCXY", "RawGenomicSignals", function(this, sort=TRUE, ...) {
  cxy <- data.frame(chromosome=this$chromosome, x=this$x, y=this$y);
  if (sort) {
    cxy <- cxy[order(cxy$chromosome, cxy$x),,drop=FALSE];
  }
  cxy;
}, protected=TRUE)






setMethodS3("kernelSmoothing", "RawGenomicSignals", function(this, xOut=NULL, ..., verbose=FALSE) {
  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this);

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
  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this);

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
  xRange <- range(x, na.rm=TRUE);
  verbose && printf(verbose, "Range of positions: [%.0f,%.0f]\n", 
                                           xRange[1], xRange[2]);

  locusFields <- NULL;
  wOut <- NULL;

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
    verbose && str(verbose, xOut);

    # Smoothed weights
    if (!is.null(weights)) {
      wOut <- Ys[,2,drop=TRUE];
      wOut[is.na(wOut)] <- 0;
    }
    verbose && exit(verbose);
  } # if (byCount)

  verbose && enter(verbose, "Creating result object");
  res <- clone(this);
  clearCache(res);
  res$y <- ys;
  res$x <- xOut;
  res$w <- wOut;

  # Drop all locus fields not binned [AD HOC: Those should also be binned. /HB 2009-06-30]
  if (!is.null(locusFields)) {
    res <- setLocusFields(res, locusFields);
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
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'method':
  method <- match.arg(method);

  # Argument 'estimator':
  estimator <- match.arg(estimator);

  n <- nbrOfLoci(this);

  # Nothing todo?
  if (n <= 1) {
    return(as.double(NA));
  }

  # Argument 'weights':
  if (!is.null(weights)) {
    weights <- Arguments$getNumerics(weights, range=c(0,Inf), length=c(n,n));
  }

  # Get the estimator function
  if (!is.null(weights)) {
    estimator <- sprintf("weighted %s", estimator);
    estimator <- toCamelCase(estimator);
  }  
  estimatorFcn <- get(estimator, mode="function");


  if (method == "diff") {
    # Sort along genome
    rgs <- sort(this);
    y <- getSignals(rgs);

    # Insert NAs ("dividers") between chromosomes?
    if (nbrOfChromosomes(this) > 1) {
      chrs <- rgs$chromosome;
      dchrs <- diff(chrs);
      ats <- which(is.finite(dchrs) & dchrs > 0);
      y <- insert(y, ats=ats);  # R.utils::insert()
      if (!is.null(weights)) {
        weights <- insert(weights, ats=ats);
      }
      rm(chrs, dchrs, ats);
    }
    rm(rgs);

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
    y <- getSignals(this);
    if (!is.null(weights)) {
      sigma <- estimatorFcn(y, w=weights, na.rm=na.rm);
    } else {
      sigma <- estimatorFcn(y, na.rm=na.rm);
    }
  }

  sigma;
})


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# GRAPHICS RELATED METHODS
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
setMethodS3("getXScale", "RawGenomicSignals", function(this, ...) {
  scale <- getBasicField(this, ".xScale");
  if (is.null(scale)) scale <- 1e-6;
  scale;
})

setMethodS3("getYScale", "RawGenomicSignals", function(this, ...) {
  scale <- getBasicField(this, ".yScale");
  if (is.null(scale)) scale <- 1;
  scale;
})

setMethodS3("setXScale", "RawGenomicSignals", function(this, scale=1e-6, ...) {
  scale <- Arguments$getNumeric(scale);
  this <- setBasicField(this, ".xScale", scale);
  invisible(this);
})

setMethodS3("setYScale", "RawGenomicSignals", function(this, scale=1, ...) {
  scale <- Arguments$getNumeric(scale);
  this <- setBasicField(this, ".yScale", scale);
  invisible(this);
})

setMethodS3("plot", "RawGenomicSignals", function(x, xlab="Position", ylab="Signal", ylim=c(-3,3), pch=20, xScale=getXScale(this), yScale=getYScale(this), ...) {
  # To please R CMD check
  this <- x;

  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this);

  x <- getPositions(this);
  y <- getSignals(this);

  plot(xScale*x, yScale*y, ylim=ylim, xlab=xlab, ylab=ylab, pch=pch, ...);
})


setMethodS3("points", "RawGenomicSignals", function(x, pch=20, ..., xScale=getXScale(this), yScale=getYScale(this)) {
  # To please R CMD check
  this <- x;

  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this);

  x <- getPositions(this);
  y <- getSignals(this);
  points(xScale*x, yScale*y, pch=pch, ...);
})

setMethodS3("lines", "RawGenomicSignals", function(x, ..., xScale=getXScale(this), yScale=getYScale(this)) {
  # To please R CMD check
  this <- x;

  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this);

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
  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this);

  seq(from=from, to=to, by=by);
})

setMethodS3("xRange", "RawGenomicSignals", function(this, na.rm=TRUE, ...) {
  # This is a single-chromosome method. Assert that's the case.
  assertOneChromosome(this);

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
  this <- setBasicField(this, ".sigma", sigma);
  invisible(this);
})

setMethodS3("getSigma", "RawGenomicSignals", function(this, ..., force=FALSE) {
  sigma <- getBasicField(this, ".sigma");
  if (is.null(sigma)) {
    sigma <- estimateStandardDeviation(this, ...);
    this <- setSigma(this, sigma);
  }
  sigma;
})



# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# TRICKS DURING Object -> BasicObject -> data.frame transition
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# Adding clone() and clearCache() for RawGenomicSignals so that its
# methods work regardless of RawGenomicSignals extending BasicObject
# or Object (the original implementation).
setMethodS3("clone", "RawGenomicSignals", function(this, ...) {
  if (inherits(this, "Object")) {
    this <- NextMethod("clone", this, ...);
  }
  this;
}, protected=TRUE)

setMethodS3("clearCache", "RawGenomicSignals", function(this, ...) {
  if (inherits(this, "Object")) {
    this <- NextMethod("clearCache", this, ...);
  }
  this;
}, protected=TRUE)

setMethodS3("getBasicField", "RawGenomicSignals", function(this, key, ...) {
  if (inherits(this, "Object")) {
    this[[key]];
  } else {
    attr(this, key);
  }
}, protected=TRUE)

setMethodS3("setBasicField", "RawGenomicSignals", function(this, key, value, ...) {
  if (inherits(this, "Object")) {
    this[[key]] <- value;
  } else {
    attr(this, key) <- value;
  }
  invisible(this);
}, protected=TRUE)




############################################################################
# HISTORY:
# 2012-03-01
# o Added (get|set)BasicField() for the Object -> BasicObject
#   -> data.frame transition.
# o Now all setNnn() methods returns invisible(this).
# o Preparing to support multiple-chromosome RawGenomicSignals;
#   - Added getChromosomes() and nbrOfChromosomes().
#   - Added single-chromosome assertions for methods assume that.
#   - Turn single-chromosome methods into multi-chromosome ones;
#     as.character(), (get|set)LocusFields(), sort(),
#     estimateStandardDeviation(), extractRegion(), extractRegions().
#   - Added getCXY().
#   - Added extractChromosome() and extractChromosomes().
#   - Added argument 'chromosome' to extractRegion().
#   - Added argument 'chromosomes' to extractRegions().
# o CLEANUP: Now extractRegion() and extractRegions() use extractSubset().
# 2012-02-04
# o GENERALIZATION: Now binnedSmoothing() of RawGenomicSignals default to
#   generate the same target bins as binnedSmoothing() of a numeric vector.
#   Before the bins had to be specified explicitly by the caller.
# 2011-12-15
# o ROBUSTNESS: Now binnedSmoothing(..., xOut) for RawGenomicSignals
#   guarantees to return length(xOut) loci.
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
