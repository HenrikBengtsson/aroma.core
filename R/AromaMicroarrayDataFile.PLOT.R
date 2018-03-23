setMethodS3("stextSize", "AromaMicroarrayDataFile", function(this, side=1, fmtstr="n=%d", size, pos=1, cex=0.7, col="darkgray", ...) {
  stext(side=side, line=-1, text=sprintf(fmtstr, round(size)), pos=pos, cex=cex, col=col, ...);
}, private=TRUE)



setMethodS3("stextLabel", "AromaMicroarrayDataFile", function(this, side=3, fmtstr="%s", label=getName(this), pos=0, cex=0.7, col="black", ...) {
  stext(side=side, text=sprintf(fmtstr, label), pos=pos, cex=cex, col=col, ...);
}, private=TRUE)



setMethodS3("stextLabels", "AromaMicroarrayDataFile", function(this, others=NULL, side=3, fmtstr="%d) %s. ", pos=0, cex=0.7, col="black", ...) {
  # Build list of AromaMicroarrayDataFile objects
  if (!is.list(others))
    others <- list(others);
  objects <- c(list(this), others);

  # Build text labels
  text <- vector("list", length(objects));
  for (kk in seq_along(objects)) {
    object <- objects[[kk]];
    if (is.null(object))
      next;
    value <- getName(object);
    str <- NULL;
    tryCatch({ str <- sprintf(fmtstr, value) }, error=function(ex){});
    if (is.null(str))
      str <- sprintf(fmtstr, kk, value);
    text[[kk]] <- str;
  }

  # Combine the into one
  text <- unlist(text, use.names=FALSE);
  text <- paste(text, collapse="");

  # Display it
  stext(side=side, text=text, pos=pos, cex=cex, col=col, ...);
}, private=TRUE)
