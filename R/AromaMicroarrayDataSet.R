###########################################################################/**
# @RdocClass AromaMicroarrayDataSet
#
# @title "The AromaMicroarrayDataSet class"
#
# \description{
#  @classhierarchy
#
#  An AromaMicroarrayDataSet object represents a set of 
#  @see "AromaMicroarrayDataFile"s with \emph{identical} chip types.
# }
# 
# @synopsis
#
# \arguments{
#   \item{files}{A @list of @see "AromaMicroarrayDataFile":s.}
#   \item{...}{Arguments passed to @see "R.filesets::GenericDataFileSet".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#*/###########################################################################
setConstructorS3("AromaMicroarrayDataSet", function(files=NULL, ...) {
  extend(GenericDataFileSet(files=files, ...), "AromaMicroarrayDataSet")
})


setMethodS3("validate", "AromaMicroarrayDataSet", function(this, ...) {
  chipTypes <- lapply(this, FUN=getChipType)
  chipTypes <- unique(chipTypes)
  if (length(chipTypes) > 1L) {
    throw("The located ", class(this)[1L], " contains files with different chip types: ", paste(chipTypes, collapse=", "))
  }

  NextMethod("validate")
}, protected=TRUE)


setMethodS3("getPlatform", "AromaMicroarrayDataSet", function(this, ...) {
  getPlatform(getOneFile(this, ...))
})


setMethodS3("getDefaultFullName", "AromaMicroarrayDataSet", function(this, parent=1L, ...) {
  NextMethod("getDefaultFullName", parent=parent)
}, protected=TRUE)


setMethodS3("getChipType", "AromaMicroarrayDataSet", function(this, ...) {
  getChipType(getOneFile(this, ...))
})
