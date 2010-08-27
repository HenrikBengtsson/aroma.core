###########################################################################/**
# @RdocClass AromaGenomeTextFile
#
# @title "The AromaGenomeTextFile class"
#
# \description{
#  @classhierarchy
#
#  An AromaGenomeTextFile represents a annotation tabular text file that
#  specifies the number of bases (nucleotides) per chromosome for a 
#  particular genome/organism.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "R.filesets::TabularTextFile".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# \details{
#   An AromaGenomeTextFile is a tab-delimited text file with a header
#   containing (at least) column names 'chromosome' and 'nbrOfBases'.
#   The 'chromosome' column specifies the chromosomes (character strings)
#   and the 'nbrOfBases' column specifies the lengths (integer) of the
#   chromosomes in number of bases (nucleotides).
#
#   The filename of an AromaGenomeTextFile should have format
#   "<genome>,chromosomes(,<tag>)*.txt",
#   and be located in annotationData/genomes/<genome>/, e.g.
#   annotationData/genomes/Human/Human,chromosomes,max,20090503.txt.
# }
#
# @examples "../incl/AromaGenomeTextFile.Rex"
#
# @author
#*/###########################################################################
setConstructorS3("AromaGenomeTextFile", function(...) {
  extend(TabularTextFile(...), "AromaGenomeTextFile");
})


setMethodS3("readDataFrame", "AromaGenomeTextFile", function(this, ..., colClassPatterns=c("*"="NULL", chromosome="character", nbrOfBases="integer", nbrOfGenes="integer")) {
  NextMethod("readDataFrame", this, colClassPatterns=colClassPatterns, ...);
})



## setMethodS3("readGenomeData", "AromaGenomeTextFile", function(this, ..., verbose=FALSE) {
##   # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##   # Validate arguments
##   # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##   # Argument 'verbose':
##   verbose <- Arguments$getVerbose(verbose);
##   if (verbose) {
##     pushState(verbose);
##     on.exit(popState(verbose));
##   }
## 
## 
##   verbose && enter(verbose, "Reading genome chromosome annotation file");
## 
##   data <- readDataFrame(this, ..., verbose=less(verbose, 10));
## 
##   verbose && enter(verbose, "Translating chromosome names");
##   chromosomes <- row.names(data);
##   map <- c("X"=23, "Y"=24, "Z"=25);  # AD HOC; only for the human genome
##   for (kk in seq(along=map)) {
##     chromosomes <- gsub(names(map)[kk], map[kk], chromosomes, fixed=TRUE);
##   }
##   row.names(data) <- chromosomes;
##   verbose && exit(verbose);
## 
##   verbose && exit(verbose);
## 
##   data;
## })



setMethodS3("findByGenome", "AromaGenomeTextFile", function(static, genome, tags=NULL, pattern=sprintf("^%s,chromosomes(,.*)*[.]txt$", genome, paste(tags, collapse=",")), paths=c("annotationData/", system.file("annotationData", package="aroma.core")), ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'genome':
  genome <- Arguments$getCharacter(genome);

  # Argument 'tags':
  tags <- Arguments$getTags(tags, collapse=",");

  # Argument 'pattern':
  if (!is.null(pattern)) {
    pattern <- Arguments$getRegularExpression(pattern);
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Locating genome annotation file");

  fullname <- paste(c(genome, tags), collapse=",");

  verbose && cat(verbose, "Genome name: ", genome);
  verbose && cat(verbose, "Genome tags: ", tags);
  verbose && cat(verbose, "Genome fullname: ", fullname);

  pattern <- sprintf(pattern, fullname);
  verbose && cat(verbose, "Pattern: ", pattern);

  # Paths to search in
  keep <- (nchar(paths) > 0);
  paths <- paths[keep];
  keep <- sapply(paths, FUN=isDirectory);
  paths <- paths[keep];
  paths <- lapply(paths, FUN=function(path) Arguments$getReadablePath(path));
  paths <- c(list(NULL), paths);

  verbose && cat(verbose, "Paths to be searched:");
  verbose && str(verbose, paths);

  for (kk in seq(along=paths)) {
    path <- paths[[kk]];
    verbose && cat(verbose, "Path: ", path);
    pathname <- findAnnotationData(name=fullname, set="genomes", 
                pattern=pattern, ..., paths=path, verbose=less(verbose, 10));
    if (!is.null(pathname)) {
      verbose && cat(verbose, "Found file: ", pathname);
      break;
    }
  }

  verbose && exit(verbose);

  pathname;
}, static=TRUE)


setMethodS3("byGenome", "AromaGenomeTextFile", function(static, genome, ..., onMissing=c("error", "warning", "ignore")) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'onMissing':
  onMissing <- match.arg(onMissing);

  # Locate genome file
  pathname <- findByGenome(static, genome=genome, ...);

  # Failed to locate a file?
  if (is.null(pathname)) {
    msg <- sprintf("Failed to locate a genome annotation data file for genome '%s'.", genome);
    verbose && cat(verbose, msg);

    if (onMissing == "error") {
      throw(msg);
    } else if (onMissing == "warning") {
      warning(msg);
    } else if (onMissing == "ignore") {
    }
  }

  newInstance(static, pathname);
}, static=TRUE)


############################################################################
# HISTORY:
# 2010-08-22
# o Added Rdoc comments and an example.
# o Created.
############################################################################
