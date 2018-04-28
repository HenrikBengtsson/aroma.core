###########################################################################/**
# @RdocClass AromaTabularBinarySet
#
# @title "The AromaTabularBinarySet class"
#
# \description{
#  @classhierarchy
#
#  An AromaTabularBinarySet object represents a set of 
#  @see "AromaTabularBinaryFile"s with \emph{identical} chip types.
# }
# 
# @synopsis
#
# \arguments{
#   \item{files}{A @list of @see "AromaTabularBinaryFile":s.}
#   \item{...}{Arguments passed to @see "R.filesets::GenericDataFileSet".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#*/###########################################################################
setConstructorS3("AromaTabularBinarySet", function(files=NULL, ...) {
  extend(GenericTabularFileSet(files=files, ...), "AromaTabularBinarySet")
})


setMethodS3("getDefaultFullName", "AromaTabularBinarySet", function(this, parent=1L, ...) {
  NextMethod("getDefaultFullName", parent=parent)
}, protected=TRUE)
