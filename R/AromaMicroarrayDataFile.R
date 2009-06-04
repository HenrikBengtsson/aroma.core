###########################################################################/**
# @RdocClass AromaMicroarrayDataFile
#
# @title "The abstract AromaMicroarrayDataFile class"
#
# \description{
#  @classhierarchy
#
#  An AromaMicroarrayDataFile object represents a single microarray data
#  file. Each such file originates from a specific chip type on a given
#  platform.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "R.filesets::GenericDataFile".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#
# \seealso{
#   An object of this class is typically part of an 
#   @see "AromaMicroarrayDataSet".
# }
#*/###########################################################################
setConstructorS3("AromaMicroarrayDataFile", function(...) {
  extend(GenericDataFile(...), "AromaMicroarrayDataFile");
}, abstract=TRUE)


setMethodS3("getPlatform", "AromaMicroarrayDataFile", abstract=TRUE);


setMethodS3("getChipType", "AromaMicroarrayDataFile", abstract=TRUE);


setMethodS3("getLabel", "AromaMicroarrayDataFile", function(this, ...) {
  label <- this$label;
  if (is.null(label))
    label <- getName(this, ...);
  label;
}, private=TRUE)


setMethodS3("setLabel", "AromaMicroarrayDataFile", function(this, label, ...) {
  this$label <- label;
  invisible(this);
}, private=TRUE)

 

############################################################################
# HISTORY:
# 2007-09-16
# o Created from AffymetrixFile.R.
############################################################################
