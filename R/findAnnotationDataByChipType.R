###########################################################################/**
# @RdocDefault findAnnotationDataByChipType
#
# @title "Locates an annotation data file by its chip type"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{chipType}{A @character string.}
#   \item{pattern}{A filename pattern to search for.}
#   \item{...}{Arguments passed to @see "findAnnotationData".}
# }
#
# @author
#
# @keyword internal
#*/###########################################################################
setMethodS3("findAnnotationDataByChipType", "default", function(chipType, pattern=chipType, ...) {
  findAnnotationData(name=chipType, pattern=pattern, set="chipTypes", ...)
}, protected=TRUE)
