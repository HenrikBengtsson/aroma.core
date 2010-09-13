setMethodS3("swapXY", "density", function(object, ...) {
  d <- object;
  d$x <- object$y;
  d$y <- object$x;
  d;
}) # swapXY()


# For some reason I cannot override lines() here
setMethodS3("draw", "density", function(object, side=1, height=0.2, offset=0, scale=c("absolute", "relative"), xpd=TRUE, ...) {
  # To please R CMD check
#  object <- x;

  # Argument 'side':
  side <- Arguments$getIndex(side, range=c(1,4));

  # Argument 'height':
  height <- Arguments$getDouble(height);

  # Argument 'offset':
  offset <- Arguments$getDouble(offset);

  # Argument 'scale':
  scale <- match.arg(scale);

  # Argument 'xpd':
  xpd <- Arguments$getLogical(xpd);


  par <- par("usr");
  dx <- diff(par[1:2]);
  dy <- diff(par[3:4]);
##  printf("(dx,dy)=(%f,%f)\n", dx,dy);

  # New 'density' object
  d <- object;

  # Rescale d$y to [0,1]
  maxY <- max(d$y, na.rm=TRUE);
  d$y <- d$y / maxY;
##    printf("range(d$y)=(%f,%f)\n", min(d$y),max(d$y));

  # Relative height and offset?
  if (scale == "relative") {
    if (side == 1 || side == 3) {
      height <- height * dy;
      offset <- offset * dy;
    } else if (side == 2 || side == 4) {
      height <- height * dx;
      offset <- offset * dx;
    }
  }  

  # Rescale d$y to [0,height]
  d$y <- d$y * height;
##    printf("range(d$y)=(%f,%f)\n", min(d$y),max(d$y));

  # Offset
  d$y <- d$y + offset;
  
  # Direction, and (x,y) swap?
  if (side == 1) {
    d$y <- par[3] + d$y;
  } else if (side == 2) {
    d$y <- par[1] + d$y;
    d <- swapXY(d);
  } else if (side == 3) {
    d$y <- par[4] - d$y;
  } else if (side == 4) {
    d$y <- par[2] - d$y;
    d <- swapXY(d);
  }

  lines(d, xpd=xpd, ...);

  invisible(d);
}) # draw()


###########################################################################
# HISTORY:
# 2010-09-12
# o Added swapXY() and draw() for objects of class 'density'.
# o Created.
########################################################################### 