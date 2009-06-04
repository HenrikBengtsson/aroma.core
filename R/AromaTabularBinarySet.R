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
  extend(GenericTabularFileSet(files=files, ...), "AromaTabularBinarySet");
})


############################################################################
# HISTORY:
# 2008-05-16
# o Removed extractMatrix() which now implemented in generic super class.
# 2008-05-11
# o Added extractMatrix().
# o Created.
############################################################################
