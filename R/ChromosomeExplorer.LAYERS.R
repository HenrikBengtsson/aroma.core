setMethodS3("writeAxesLayers", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this);

  path <- getPath(this);
  path <- filePath(getParent(path), "axes,chrLayer");
  path <- Arguments$getWritablePath(path);
  plotAxesLayers(model, path=path, imageFormat="png", transparent=TRUE, ...);

  invisible(path);
}, private=TRUE)


setMethodS3("writeGridHorizontalLayers", "ChromosomeExplorer", function(this, ...) {
  model <- getModel(this);

  path <- getPath(this);
  path <- filePath(getParent(path), "gridH,chrLayer");
  path <- Arguments$getWritablePath(path);
  plotGridHorizontalLayers(model, path=path, imageFormat="png", transparent=TRUE, ...);

  invisible(path);
}, private=TRUE)



setMethodS3("writeCytobandLayers", "ChromosomeExplorer", function(this, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get the model
  model <- getModel(this);

  path <- getPath(this);
  path <- filePath(getParent(path), "cytoband,chrLayer");
  path <- Arguments$getWritablePath(path);
  plotCytobandLayers(model, path=path, imageFormat="png", transparent=TRUE, ...);

  invisible(path);
}, private=TRUE)


setMethodS3("getSampleLayerName", "Explorer", function(this, name, class="sampleLayer", ...) {
  layer <- c(getSampleLayerPrefix(this), name, class);
  layer <- paste(layer, collapse=",");
  layer;
}, private=TRUE)


setMethodS3("writeRawCopyNumberLayers", "ChromosomeExplorer", function(this, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get the model
  model <- getModel(this);

  path <- getPath(this);
  layer <- getSampleLayerName(this, "rawCNs");
  path <- filePath(getParent(path), layer);

  path <- Arguments$getWritablePath(path);
  plotRawCopyNumbers(model, path=path, imageFormat="png", transparent=TRUE, ...);

  invisible(path);
}, private=TRUE)


setMethodS3("writeCopyNumberRegionLayers", "ChromosomeExplorer", function(this, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get the model
  model <- getModel(this);

  # Not supported?
  if (!inherits(model, "CopyNumberSegmentationModel"))
    return(NULL);

  path <- getPath(this);
  tags <- getAsteriskTags(model, collapse=",");
  path <- filePath(getParent(path), sprintf("%s,sampleLayer", tags));

  path <- Arguments$getWritablePath(path);
  plotCopyNumberRegionLayers(model, path=path, imageFormat="png", transparent=TRUE, ...);

  invisible(path);
}, private=TRUE)
