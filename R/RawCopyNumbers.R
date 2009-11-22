###########################################################################/**
# @RdocClass RawCopyNumbers
#
# @title "The RawCopyNumbers class"
#
# \description{
#  @classhierarchy
# }
# 
# @synopsis
#
# \arguments{
#   \item{cn}{A @numeric @vector of length J specifying the copy number
#     at each loci.}
#   \item{...}{Arguments passed to @see "RawGenomicSignals".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# @examples "../incl/RawCopyNumbers.Rex"
#
# @author
#*/########################################################################### 
setConstructorS3("RawCopyNumbers", function(cn=NULL, ...) {
  extend(RawGenomicSignals(y=cn, ...), "RawCopyNumbers")
})


setMethodS3("getPhysicalPositions", "RawCopyNumbers", function(this, ...) {
  getPositions(this, ...);
}, protected=TRUE, deprecated=TRUE)


setMethodS3("getCNs", "RawCopyNumbers", function(this, ...) {
  getSignals(this);
}, protected=TRUE)

setMethodS3("getCn", "RawCopyNumbers", function(this, ...) {
  getSignals(this);
}, protected=TRUE)


setMethodS3("as.data.frame", "RawCopyNumbers", function(x, ..., translate=TRUE) {
  # To please R CMD check
  this <- x;

  df <- NextMethod("as.data.frame");

  # Translate column names?
  if (translate) {
    colnames(df) <- gsub("y", "cn", colnames(df), fixed=TRUE);
  }

  df;
})


setMethodS3("extractRawCopyNumbers", "RawCopyNumbers", function(this, ..., logBase=2) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'logBase':
  if (!is.null(logBase)) {
    logBase <- Arguments$getDouble(logBase, range=c(1, 10));
  }

  # Get the current logarithmic base, if any
  logBase0 <- this$.yLogBase;

  res <- clone(this);

  if (logBase0 != logBase) {
    # Get current signals
    y <- getSignals(this);
  
    # Unlog?
    if (!is.null(logBase0)) {
      y <- logBase0^y;
    }
  
    # Log?
    if (!is.null(logBase)) {
      y <- log(y) / log(logBase);
    }

    res$y <- y;
    res$.yLogBase <- logBase;
  }

  res;
})


setMethodS3("plot", "RawCopyNumbers", function(x, ..., ylab="Copy number") {
  NextMethod("plot", x, ..., ylab=ylab);
})


setMethodS3("cnRange", "RawCopyNumbers", function(this, ...) {
  signalRange(this, ...);
})



setMethodS3("extractRawCNs", "default", function(...) {
  extractRawCopyNumbers(...);
})

setMethodS3("extractRawCopyNumbers", "default", abstract=TRUE);



############################################################################
# HISTORY:
# 2009-11-22
# o Added extractRawCopyNumbers() to RawCopyNumbers, which can be used to
#   change the log base.  Maybe other features are added later.
# 2009-05-10
# o Added argument 'translate=TRUE' to as.data.frame().
# 2009-02-19
# o Now inherits from RawGenomicSignals.R.
# o Added argument 'byCount' to binnedSmoothing() of RawCopyNumbers.
# 2009-02-17
# o Now RawCopyNumbers() also takes another RawCopyNumbers object as
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
