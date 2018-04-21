setMethodS3("drawCnRegions", "HaarSeg", function(object, ...) {
  cnr <- extractCopyNumberRegions(object, ...)
  drawLevels(cnr, ...)
})


setMethodS3("extractCopyNumberRegions", "HaarSeg", function(object, ...) {
  output <- object$output
  regions <- output$SegmentsTable
  data <- object$data
  x <- data$x

  # Identify the locus indices where the regions starts and ends
  starts <- regions[,1]
  counts <- regions[,2]
  ends <- starts+counts-1

  # Translate to genomic positions
  starts <- x[starts]
  ends <- x[ends]

  # Get the mean levels of each region
  means <- regions[,3]

  CopyNumberRegions(
    chromosome=data$chromosome,
    start=starts, 
    stop=ends, 
    mean=means,
    count=counts
  )
})


setMethodS3("extractRawCopyNumbers", "HaarSeg", function(object, ...) {
  data <- object$data
  RawCopyNumbers(cn=data$M, x=data$x, chromosome=data$chromosome)
})
