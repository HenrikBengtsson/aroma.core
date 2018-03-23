###########################################################################/**
# @RdocClass SegmentedAlleleBFractions
#
# @title "The SegmentedAlleleBFractions class"
#
# \description{
#  @classhierarchy
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "RawAlleleBFractions".}
#   \item{states}{A @function returning the copy-number states given a
#     @vector of locus positions.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# @author
#*/########################################################################### 
setConstructorS3("SegmentedAlleleBFractions", function(..., states=NULL) {
  this <- extend(RawAlleleBFractions(...), c("SegmentedAlleleBFractions", 
                                   uses("SegmentedGenomicSignalsInterface")));
  this <- setStates(this, states=states);
  this;
})
