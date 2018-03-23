setMethodS3("drawExtraAnnotations", "default", function(fit, ...) {
  rawCNs <- extractRawCopyNumbers(fit);
  sd <- estimateStandardDeviation(rawCNs);
  text <- substitute(hat(sigma)[Delta]==sd, list(sd=sprintf("%.3g", sd)));
  stext(text=text, side=3, pos=0.5, line=-2); 
}, protected=TRUE);


setMethodS3("drawExtraAnnotations", "profileCGH", function(fit, ...) {
  sdEst <- fit$SigmaC$Value;
  if (!is.null(sdEst)) {
    text <- substitute(hat(sigma)==x, list(x=sprintf("%.3g", sdEst)));
    stext(text=text, side=3, pos=0.5, line=-2);
  }
}, protected=TRUE);
