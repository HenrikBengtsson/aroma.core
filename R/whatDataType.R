setMethodS3("whatDataType", "default", function(type, ...) {
  if (type == "byte") {
    what <- "integer";
    size <- 1;
  } else if (type == "short") {
    what <- "integer";
    size <- 2;
  } else if (type == "integer") {
    what <- "integer";
    size <- 4;
  } else if (type == "long") {
    what <- "integer";
    size <- 8;
  } else if (type == "float") {
    what <- "double";
    size <- 4;
  } else if (type == "double") {
    what <- "double";
    size <- 8;
  } else if (type == "logical") {
    what <- "integer";
    size <- 1;
  } else if (type == "raw") {
    what <- "raw";
    size <- 1;
  } else {
    what <- NA;
    size <- NA;
  }

  list(what=what, size=size);
}, private=TRUE)
