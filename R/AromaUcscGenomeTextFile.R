setConstructorS3("AromaUcscGenomeTextFile", function(...) {
  extend(AromaGenomeTextFile(...), "AromaUcscGenomeTextFile");
})


setMethodS3("findByGenome", "AromaUcscGenomeTextFile", function(static, genome, type, tags=NULL, pattern=sprintf("^%s,UCSC(|,%s),%s[.]txt$", genome, paste(tags, collapse=","), type), ...) {
  findByGenome.AromaGenomeTextFile(static, genome=genome, tags=NULL, pattern=pattern, ...);
}, static=TRUE)

setMethodS3("readDataFrame", "AromaUcscGenomeTextFile", function(this, colClassPatterns=c("*"=NA), ...) {
  NextMethod("readDataFrame", this, colClassPatterns=colClassPatterns, ...);
})

############################################################################
# HISTORY:
# 2011-11-17
# o Created.
############################################################################
