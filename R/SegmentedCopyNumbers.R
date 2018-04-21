###########################################################################/**
# @RdocClass SegmentedCopyNumbers
#
# @title "The SegmentedCopyNumbers class"
#
# \description{
#  @classhierarchy
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "RawCopyNumbers".}
#   \item{states}{A @function returning the copy-number states given a
#     @vector of locus positions.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# @examples "../incl/SegmentedCopyNumbers.Rex"
#
# @author
#*/########################################################################### 
setConstructorS3("SegmentedCopyNumbers", function(..., states=NULL) {
  this <- extend(RawCopyNumbers(...), c("SegmentedCopyNumbers", 
                                   uses("SegmentedGenomicSignalsInterface")))
  this <- setStates(this, states=states)
  this
})
