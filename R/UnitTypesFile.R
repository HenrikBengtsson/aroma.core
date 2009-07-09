###########################################################################/**
# @RdocClass UnitTypesFile
#
# @title "The UnitTypesFile interface class"
#
# \description{
#  @classhierarchy
#
#  A UnitTypesFile provides methods for querying the unit types of
#  a given chip type, e.g. genotyping or copy-number unit, exon unit etc.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "UnitAnnotationDataFile".}
# }
#
# \section{Methods}{
#  @allmethods "public"
# }
#
# @author
#*/###########################################################################
setConstructorS3("UnitTypesFile", function(...) {
  extend(UnitAnnotationDataFile(...), "UnitTypesFile");
})

setMethodS3("getUnitTypes", "UnitTypesFile", abstract=TRUE);

setMethodS3("nbrOfUnits", "UnitTypesFile", function(this, ...) {
  length(getUnitTypes(this));
})



############################################################################
# HISTORY:
# 2009-07-08
# o Created from UnitTypesFile.R.
############################################################################
