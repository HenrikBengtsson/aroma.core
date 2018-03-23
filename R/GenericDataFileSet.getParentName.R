setMethodS3("getParentName", "GenericDataFileSet", function(this, ..., tags="*") {
  # Argument 'tags':
  tags <- Arguments$getTags(tags, collapse=NULL);

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
  tags <- Arguments$getTags(tags, collapse=NULL);

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
