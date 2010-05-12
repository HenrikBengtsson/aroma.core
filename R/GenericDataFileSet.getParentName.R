setMethodS3("getParentName", "GenericDataFileSet", function(this, ..., tags="*") {
  # Argument 'tags':
  if (!is.null(tags)) {
    tags <- Arguments$getCharacters(tags);
    tags <- unlist(strsplit(tags, split=",", fixed=TRUE), use.names=FALSE);
  }

  path <- getPath(this);
  path <- getParent(path, ...);
  fullname <- basename(path);
  parts <- unlist(strsplit(fullname, split=",", fixed=TRUE), use.names=FALSE);
  name <- parts[1];
  tags[tags == "*"] <- paste(parts[-1], collapse=",");
  tags <- tags[nchar(tags) > 0];
  fullname <- paste(c(name, tags), collapse=",");
  
  fullname;
}, protected=TRUE)



setMethodS3("getParentName", "GenericDataFile", function(this, ..., tags="*") {
  # Argument 'tags':
  if (!is.null(tags)) {
    tags <- Arguments$getCharacters(tags);
    tags <- unlist(strsplit(tags, split=",", fixed=TRUE), use.names=FALSE);
  }

  path <- getPath(this);
  path <- getParent(path, ...);
  fullname <- basename(path);
  parts <- unlist(strsplit(fullname, split=",", fixed=TRUE), use.names=FALSE);
  name <- parts[1];
  tags[tags == "*"] <- paste(parts[-1], collapse=",");
  tags <- tags[nchar(tags) > 0];
  fullname <- paste(c(name, tags), collapse=",");
  
  fullname;
}, protected=TRUE)



############################################################################
# HISTORY:
# 2010-05-12
# o Created.
############################################################################
