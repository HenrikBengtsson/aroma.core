setMethodS3("getChromosomes", "Arguments", function(static, chromosomes, range=c(1,24), ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'chromosome':
  if (is.character(chromosomes)) {
    # Interpret X and Y
    map <- c("X"=23, "Y"=24);
    idxs <- (chromosomes %in% names(map));
    chromosomes[idxs] <- map[chromosomes[idxs]];
  }

  chromosomes <- Arguments$getIndices(chromosomes, range=range, ...);

  chromosomes;
}, static=TRUE, protected=TRUE)


setMethodS3("getChromosome", "Arguments", function(static, chromosome, ..., length=1) {
  getChromosomes(static, chromosomes=chromosome, length=length, ...);
}, static=TRUE, protected=TRUE)



setMethodS3("getTags", "Arguments", function(static, ..., na.rm=TRUE, collapse=",") {
  # Generate tags
  tags <- paste(..., sep=",", collapse=",");
  tags <- Arguments$getCharacters(tags);
  tags <- strsplit(tags, split=",");
  tags <- unlist(tags);
  tags <- trim(tags);

  # Drop missing tags?
  if (na.rm) {
    tags <- tags[!is.na(tags)];
  }

  # Drop empty tags
  tags <- tags[nchar(tags) > 0];

  # Nothing to do?
  if (length(tags) == 0) {
    return(NULL);
  }

  # Collapse?
  if (!is.null(collapse)) {
    tags <- paste(tags, collapse=collapse);
  }

  tags;
}, static=TRUE, protected=TRUE)


############################################################################
# HISTORY:
# 2010-01-25
# o Added static getTags() to Arguments.
# 2007-03-15
# o BUG FIX: Forgot to pass '...' down in getChromosome().
# 2007-03-06
# o Added getChromosome() and getChromosomes().
# o Created.
############################################################################
