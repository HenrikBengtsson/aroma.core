###########################################################################/**
# @RdocClass AromaCellTabularBinaryFile
#
# @title "The AromaCellTabularBinaryFile class"
#
# \description{
#  @classhierarchy
#
#  A AromaCellTabularBinaryFile is an @see "AromaTabularBinaryFile" with
#  the constraint that the rows map one-to-one to the cells (features)
#  of a microarray.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "AromaTabularBinaryFile".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#
# \seealso{
#   @see "AromaUnitTabularBinaryFile".
# }
#*/########################################################################### 
setConstructorS3("AromaCellTabularBinaryFile", function(...) {
  extend(AromaMicroarrayTabularBinaryFile(...), "AromaCellTabularBinaryFile");
})


setMethodS3("nbrOfCells", "AromaCellTabularBinaryFile", function(this, ...) {
  nbrOfRows(this, ...);
})






############################################################################
# HISTORY:
# 2008-07-09
# o Created from AromaUnitTabularBinaryFile.R.
############################################################################
