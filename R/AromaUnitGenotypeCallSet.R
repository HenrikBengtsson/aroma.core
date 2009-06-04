###########################################################################/**
# @RdocClass AromaUnitGenotypeCallSet
#
# @title "The AromaUnitGenotypeCallSet class"
#
# \description{
#  @classhierarchy
#
#  An AromaUnitGenotypeCallSet object represents a set of 
#  @see "AromaUnitGenotypeCallFile"s with \emph{identical} chip types.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "AromaUnitCallSet".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#*/###########################################################################
setConstructorS3("AromaUnitGenotypeCallSet", function(...) {
  extend(AromaUnitCallSet(...), "AromaUnitGenotypeCallSet");
})


setMethodS3("fromFiles", "AromaUnitGenotypeCallSet", function(static, ..., pattern=".*,genotypes[.]acf$") {
  suppressWarnings({
    fromFiles.AromaUnitCallSet(static, ..., pattern=pattern);
  })
})


setMethodS3("byName", "AromaUnitGenotypeCallSet", function(static, name, tags=NULL, ..., chipType=NULL, pattern=".*,genotypes[.]acf$") {
  suppressWarnings({
    path <- findByName(static, name=name, tags=tags, chipType=chipType, 
                                           ..., mustExist=TRUE);
  })

  suppressWarnings({
    fromFiles(static, path=path, ..., pattern=pattern);
  })
}, static=TRUE) 


setMethodS3("extractGenotypeMatrix", "AromaUnitCallSet", function(this, ..., drop=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Extracting genotypes across all arrays");
  verbose && cat(verbose, "Number of files: ", nbrOfFiles(this));

  res <- NULL;
  for (kk in seq(this)) {  
    df <- getFile(this, kk);
    verbose && enter(verbose, sprintf("File #%d ('%s') of %d", 
                                kk, getName(df), nbrOfFiles(this)));

    values <- extractGenotypeMatrix(df, ..., drop=FALSE, 
                                            verbose=less(verbose,10));
    verbose && str(verbose, values);

    if (kk == 1) {
      dim <- dim(values);
      dim[length(dim)] <- nbrOfFiles(this);
      dimnames <- list(rownames(values), getNames(this));
      res <- array(values[1], dim=dim, dimnames=dimnames);
    }

    res[,kk] <- values;

    verbose && exit(verbose);
  } # for (kk ...)

  # Drop singletons?
  if (drop) {
    res <- drop(res);
  }

  verbose && exit(verbose);

  res;
})



setMethodS3("extractGenotypes", "AromaUnitGenotypeCallSet", function(this, ...) {
  extractGenotypeMatrix(this, ...);
})


############################################################################
# HISTORY:
# 2009-01-10
# o Fixed extractGenotypesMatrix().
# 2008-12-09
# o Created.
############################################################################
