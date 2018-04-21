
setMethodS3("drawCytoband", "ChromosomalModel", function(this, chromosome=NULL, cytobandLabels=TRUE, unit=6, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (length(chromosome) != 1) {
    throw("Argument 'chromosome' must be a single chromosome: ", paste(chromosome, collapse=", "))
  }

  # Do we know how to plot the genome?
  genome <- getGenome(this)
  pattern <- sprintf("^%s,cytobands(|,.*)*[.]txt$", genome)
  gf <- getGenomeFile(this, genome=genome, pattern=pattern, mustExist=FALSE)
  # If no cytoband annotation data is available, skip it
  if (is.null(gf)) {
    return()
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Load annotation data file
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  colClasses <- c("*"="character", "(start|end)"="integer", 
                       "intensity"="integer", "isCentromere"="logical")
  data <- readDataFrame(gf, colClasses=colClasses)

  # Infer chromosome indices
  data$chromosomeIdx <- Arguments$getChromosomes(data$chromosome)


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Setup a cytoband data frame recognized by the GLAD plot functions
  # TO DO: Setup our own plot functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Get chromosome lengths
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  genomeInfo <- aggregate(data$end, 
    by=list(Chromosome=data$chromosome, ChrNumeric=data$chromosomeIdx), 
    FUN=max, na.rm=TRUE)
  names(genomeInfo) <- c("Chromosome", "ChrNumeric", "Length")

  labelChr <- data.frame(chromosome=chromosome)
  labelChr <- merge(labelChr, genomeInfo[, c("ChrNumeric", "Length")], 
                         by.x="chromosome", by.y="ChrNumeric", all.x=TRUE)
  labelChr$Length <- 0

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Get the cytoband details for the chromosome of interest
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Drop column 'chromosome'
  data2 <- data[,(colnames(data) != "chromosome"), drop=FALSE]
  data2 <- merge(labelChr, data2, by.x="chromosome", by.y="chromosomeIdx")

  # Rescale x positions according to units
  xScale <- 1/(10^unit)
  data2$start <- xScale*data2$start
  data2$end <- xScale*data2$end

  # Translate names to GLAD names
  names <- names(data2)
  names <- gsub("intensity", "color", names)
  names <- gsub("isCentromere", "centro", names)
  names <- capitalize(names)
  names(data2) <- names
  
  # Where should the cytoband be added and how wide should it be?
  usr <- par("usr")
  dy <- diff(usr[3:4])

  drawCytoband2(data2, chromosome=chromosome, 
    labels=cytobandLabels, y=usr[4]+0.02*dy, height=0.03*dy, ...)
}, private=TRUE) # drawCytoband()
