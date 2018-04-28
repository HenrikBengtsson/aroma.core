setMethodS3("getDeviceResolution", "default", function(scale=1, ...) {
  res <- scale * par("cra") / par("cin")
  res
})
