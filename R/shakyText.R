# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Local functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
setMethodS3("shakyText", "default", function(x, y, labels, col=NULL, bgcol="white", adj=c(0.5,0.5), jitter=c(0.1,0.1), ...) {
  for (dx in seq(from=-jitter[1], to=+jitter[1], length.out=9)) {
    for (dy in seq(from=-jitter[2], to=+jitter[2], length.out=9)) {
      text(x, y, labels, col=bgcol, adj=adj+c(dx,dy), ...)
    }
  }
  text(x, y, labels, col=col, adj=adj, ...)
}) # shakyText()
