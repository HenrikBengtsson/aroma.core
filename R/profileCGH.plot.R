setMethodS3("plot", "profileCGH", function(x, ylim=c(-1,1)*3, units="Mb", Bkp=FALSE, Smoothing="Smoothing", cnLevels=c(1/2,1,3/2), colDAGLAD=NULL, ticksBy=1, ...) {
  .Defunct(msg="plot() for profileCGH in aroma.core is defunct.");
}, private=TRUE, deprecated=TRUE)




############################################################################
# HISTORY:
# 2013-10-16
# o Added a formal .Defunct() to plot() for profileCGH.
# 2007-06-11
# o Called substitute() with non-existing argument 'list'.
# 2007-04-12
# o Updated plot() of profileCGH class to write the text 'n=%d' in the
#   lower-right corner of the graph in black and not lightgray as before.
# 2006-12-20
# o Now it is possible to specify the 'xlim' as well as 'ylim' when plotting
#   GLAD data.  This allows us to zoom in are certain data points for high
#   density data.
# o BUG FIX: The plotProfile() of GLAD does not position the cytobands
#   correctly.  This is because not the same 'xlim' is used for the
#   cytoband panel as the data panel.  Replaced with my own plotProfile2()
#   for now.
# 2006-11-29
# o Added std dev estimation to plot.
# 2006-10-30
# o Created from glad.R script from 2006-08-03.
############################################################################
