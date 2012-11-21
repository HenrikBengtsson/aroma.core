###########################################################################/**
# @RdocClass AromaPlatform
#
# @title "The AromaPlatform class"
#
# \description{
#  @classhierarchy
#
#  An AromaPlatform provides methods for a given platform, e.g.
#  Affymetrix, Agilent, Illumina.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \section{Methods}{
#  @allmethods "public"
# }
#
# @author
#*/###########################################################################
setConstructorS3("AromaPlatform", function(...) {
  extend(Object(), "AromaPlatform");
})


setMethodS3("byName", "AromaPlatform", function(static, name, ...) {
  className <- sprintf("%sPlatform", capitalize(name));
  clazz <- Class$forName(className);
  newInstance(clazz);
}, static=TRUE);


setMethodS3("getName", "AromaPlatform", function(this, ...) {
  name <- class(this)[1];
  name <- name[1];
  name <- gsub("Platform", "", name);
  name;
})

setMethodS3("findUnitNamesFile", "AromaPlatform", abstract=TRUE, protected=TRUE)

setMethodS3("getUnitNamesFile", "AromaPlatform", abstract=TRUE)

setMethodS3("findUnitTypesFile", "AromaPlatform", abstract=TRUE, protected=TRUE)

setMethodS3("getUnitTypesFile", "AromaPlatform", abstract=TRUE)


setMethodS3("getAromaUgpFile", "AromaPlatform", function(static, ...) {
  AromaUgpFile$byName(...);
}, static=TRUE)




############################################################################
# HISTORY:
# 2009-07-08
# o Added getUnitTypesFile() for AromaPlatform.
# 2008-05-18
# o Created.
############################################################################
