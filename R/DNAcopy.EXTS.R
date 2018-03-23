setMethodS3("extractCopyNumberRegions", "DNAcopy", function(object, ...) {
  output <- object$output;

  CopyNumberRegions(
    chromosome=output[["chrom"]], 
    start=output[["loc.start"]], 
    stop=output[["loc.end"]], 
    mean=output[["seg.mean"]],
    count=output[["num.mark"]]
  );
})


setMethodS3("extractRawCopyNumbers", "DNAcopy", function(object, ...) {
  data <- object$data;
  chromosome <- unique(data$chrom);
  chromosome <- Arguments$getIndex(chromosome);
  RawCopyNumbers(cn=data[[3]], x=data$maploc, chromosome=chromosome);
})
  

setMethodS3("drawCnRegions", "DNAcopy", function(this, ...) {
  cnr <- extractCopyNumberRegions(this, ...);
  drawLevels(cnr, ...);
})
