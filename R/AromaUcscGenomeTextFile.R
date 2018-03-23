setConstructorS3("AromaUcscGenomeTextFile", function(...) {
  extend(AromaGenomeTextFile(...), "AromaUcscGenomeTextFile");
})


setMethodS3("findByGenome", "AromaUcscGenomeTextFile", function(static, genome, type, tags=NULL, pattern=sprintf("^%s,UCSC(|,%s),%s[.]txt$", genome, paste(tags, collapse=","), type), ...) {
  NextMethod("findByGenome", genome=genome, tags=NULL, pattern=pattern);
}, static=TRUE)

setMethodS3("readDataFrame", "AromaUcscGenomeTextFile", function(this, colClasses=c("*"=NA), ...) {
  NextMethod("readDataFrame", colClasses=colClasses);
})
