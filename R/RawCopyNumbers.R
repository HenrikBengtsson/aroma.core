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
  this <- extend(RawGenomicSignals(y=cn, ...), "RawCopyNumbers")
  this <- setColumnNamesMap(this, y="cn")
  this
})


setMethodS3("getSignals", "RawCopyNumbers", function(this, ...) {
  this$cn
})

setMethodS3("getCNs", "RawCopyNumbers", function(this, ...) {
  getSignals(this)
}, protected=TRUE)

setMethodS3("getCn", "RawCopyNumbers", function(this, ...) {
  getSignals(this)
}, protected=TRUE)


setMethodS3("extractRawCopyNumbers", "RawCopyNumbers", function(this, ..., logBase=2) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'logBase':
  if (!is.null(logBase)) {
    logBase <- Arguments$getDouble(logBase, range=c(1, 10))
  }

  # Get the current logarithmic base, if any
  logBase0 <- getBasicField(this, ".yLogBase")

  res <- clone(this)

  if (!isTRUE(all.equal(logBase0, logBase))) {
    # Get current signals
    y <- getSignals(this)
  
    # Unlog?
    if (!is.null(logBase0)) {
      y <- logBase0^y
    }
  
    # Log?
    if (!is.null(logBase)) {
      y <- log(y) / log(logBase)
    }

    res <- setSignals(res, y)
    res <- setBasicField(res, ".yLogBase", logBase)
  }

  res
})


setMethodS3("plot", "RawCopyNumbers", function(x, ..., ylim=c(0,5), ylab="Copy number") {
  NextMethod("plot", ylim=ylim, ylab=ylab)
})


setMethodS3("cnRange", "RawCopyNumbers", function(this, ...) {
  signalRange(this, ...)
})



setMethodS3("extractRawCNs", "default", function(...) {
  extractRawCopyNumbers(...)
})

setMethodS3("extractRawCopyNumbers", "default", abstract=TRUE)
