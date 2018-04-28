setConstructorS3("CbsSegmentationDataFile", function(...) {
  extend(SegmentationDataFile(...), "CbsSegmentationDataFile")
})

setMethodS3("loadFit", "CbsSegmentationDataFile", function(this, ...) {
  pathname <- getPathname(this)
  loadObject(pathname)
}, protected=TRUE)
