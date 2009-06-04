getCommonPrefix <- function(strs, suffix=FALSE, ...) {
  # Split strings into character vectors
  nchars <- sapply(strs, FUN=nchar);
  chars <- strsplit(strs, split="");

  # Asked for the suffix?
  if (suffix) {
    chars <- base::lapply(chars, FUN=rev);
  }

  # Put the characters into a matrix
  data <- matrix(NA, nrow=length(chars), ncol=max(nchars));
  for (kk in seq(along=chars)) {
    cc <- seq(length=nchars[kk]);
    data[kk,cc] <- chars[[kk]];
  }

  # Find first column with different characters
  count <- 0;
  for (cc in seq(length=ncol(data))) {
    uchars <- unique(data[,cc]);
    if (length(uchars) > 1)
      break;
    count <- cc;
  }

  # The common prefix as a character vector
  prefix <- chars[[1]][seq(length=count)];

  # Asked for the suffix?
  if (suffix) {
    prefix <- rev(prefix);
  }
 
  # The common prefix as a character string
  prefix <- paste(prefix, collapse="");

  prefix;
} # getCommonPrefix()


splitByCommonTails <- function(strs, ...) {
  names <- names(strs);

  prefix <- getCommonPrefix(strs);
  suffix <- getCommonPrefix(strs, suffix=TRUE);

  # Cut out the prefix
  body <- substring(strs, nchar(prefix)+1);

  # Cut out the suffix
  body <- substring(body, 1, nchar(body)-nchar(suffix));

  # Special case
  if (all(body == "")) {
    suffix <- "";
  }

  strs <- base::lapply(body, FUN=function(s) {
    c(prefix, s, suffix);
  })

  strs <- unlist(strs, use.names=FALSE);
  strs <- matrix(strs, ncol=3, byrow=TRUE);
  colnames(strs) <- c("prefix", "body", "suffix");
  rownames(strs) <- names;

  strs;
} # splitByCommonTails()

mergeByCommonTails <- function(strs, collapse="", ...) {
  if (is.null(strs))
    return(NULL);

  strs <- splitByCommonTails(strs);
  prefix <- strs[1,"prefix"]; 
  suffix <- strs[1,"suffix"]; 
  body <- strs[,"body"];

  # Collapse non-empty bodies
  body <- paste(body[nchar(body) > 0], collapse=collapse);

  str <- paste(prefix, body, suffix, sep="");
  str;
} # mergeByCommonTails()


##############################################################################
# HISTORY:
# 2006-12-15
# o Created (since stringTree() is broken and this is good enough).
##############################################################################
