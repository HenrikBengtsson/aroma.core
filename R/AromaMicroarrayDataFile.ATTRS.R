setMethodS3("setAttributeXY", "AromaMicroarrayDataFile", function(this, value, ...) {
  # Argument 'value':
  if (is.null(value)) {
    # Nothing todo?
    return();
  }

  pattern <- "^(X*)(Y*)$";
  if (regexpr(pattern, value) == -1) {
    throw("The value of argument 'value' is unrecognized: ", value);
  }

  # Parse and count
  n23 <- gsub(pattern, "\\1", value);
  n24 <- gsub(pattern, "\\2", value);
  n23 <- nchar(n23);
  n24 <- nchar(n24);
  setAttributes(this, n23=n23, n24=n24);
}, protected=TRUE)

setMethodS3("getAttributeXY", "AromaMicroarrayDataFile", function(this, ...) {
  n23 <- getAttribute(this, "n23", 0);
  n24 <- getAttribute(this, "n24", 0);
  xyTag <- paste(c(rep("X", n23), rep("Y", n24)), collapse="");
  xyTag;
}, protected=TRUE)

setMethodS3("hasAttributeXY", "AromaMicroarrayDataFile", function(this, values, ...) {
   xyTag <- getAttributeXY(this);
   (xyTag %in% values);
}, protected=TRUE)


setMethodS3("setAttributesByTags", "AromaMicroarrayDataFile", function(this, tags=getTags(this), ...) {
  # Split tags
  tags <- Arguments$getTags(tags, collapse=NULL);

  newAttrs <- NextMethod("setAttributesByTags", tags=tags);

  # Parse XY, XX, XXX etc tags
  values <- grep("^X*Y*$", tags, value=TRUE);
  if (length(values) > 0) {
    newAttrs <- c(newAttrs, setAttributeXY(this, values));
  }

  # Parse tri<chromosome> tags
  values <- grep("^tri([1-9]|[0-9][0-9]|X|Y)$", tags, value=TRUE);
  if (length(values) > 0) {
    values <- gsub("^tri", "", values);
    chromosomes <- Arguments$getChromosomes(values);
    keys <- sprintf("n%02d", chromosomes);
    newAttrs <- c(newAttrs, lapply(keys, FUN=function(key) {
      setAttribute(this, key, 3);
    }));
  }

  # Return nothing
  invisible(newAttrs);
}, protected=TRUE)




setMethodS3("getPloidy", "AromaMicroarrayDataFile", function(this, chromosome, defaultValue=NA, ...) {
  # Argument 'chromosome':
  chromosome <- Arguments$getChromosome(chromosome);

  key <- sprintf("n%02d", chromosome);
  value <- getAttribute(this, key, defaultValue=defaultValue);
  value;
}, protected=TRUE)
