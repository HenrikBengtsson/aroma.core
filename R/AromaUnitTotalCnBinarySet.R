###########################################################################/**
# @RdocClass AromaUnitTotalCnBinarySet
#
# @title "The AromaUnitTotalCnBinarySet class"
#
# \description{
#  @classhierarchy
#
#  An AromaUnitTotalCnBinarySet object represents a set of 
#  @see "AromaUnitTotalCnBinaryFile"s with \emph{identical} chip types.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "AromaUnitSignalBinarySet".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#*/###########################################################################
setConstructorS3("AromaUnitTotalCnBinarySet", function(...) {
  extend(AromaUnitSignalBinarySet(...), "AromaUnitTotalCnBinarySet");
})


setMethodS3("byName", "AromaUnitTotalCnBinarySet", function(static, name, tags=NULL, ..., chipType=NULL, paths=c("totalAndFracBData", "rawCnData", "cnData", "smoothCnData")) {
  suppressWarnings({
    path <- findByName(static, name=name, tags=tags, chipType=chipType, 
                                           ..., paths=paths, mustExist=TRUE);
  })

  suppressWarnings({
    byPath(static, path=path, ..., pattern=".*,total[.]asb$");
  })
}, static=TRUE) 



############################################################################
# HISTORY:
# 2009-08-31
# o Added totalAndFracBData/ to the search path of byName() of 
#   AromaUnit(FracB|Total)CnBinarySet.
# 2009-02-09
# o Now byName() of AromaUnit(FracB|Total)CnBinarySet searches rawCnData/
#   then cnData/.
# 2008-05-11
# o Created.
############################################################################
