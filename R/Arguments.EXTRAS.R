setMethodS3("getChromosomes", "Arguments", function(static, chromosomes, range=c(1,24), ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'chromosome':
  if (is.character(chromosomes)) {
    # Interpret X and Y
    map <- c("X"=23, "Y"=24)
    idxs <- (chromosomes %in% names(map))
    chromosomes[idxs] <- map[chromosomes[idxs]]
  }

  chromosomes <- Arguments$getIndices(chromosomes, range=range, ...)

  chromosomes
}, static=TRUE, protected=TRUE)


setMethodS3("getChromosome", "Arguments", function(static, chromosome, ..., length=1) {
  getChromosomes(static, chromosomes=chromosome, length=length, ...)
}, static=TRUE, protected=TRUE)
