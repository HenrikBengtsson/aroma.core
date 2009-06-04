###########################################################################/**
# @RdocClass Interface
#
# @title "The Interface class"
#
# \description{
#  @classhierarchy
#
#  This class represents a special set of classes whose purpose is to
#  provide methods (but not fields) shared by multiple different classes.
# }
# 
# @synopsis
#
# \arguments{
#   \item{core}{The core value.}
#   \item{...}{Not used.}
# }
#
# \section{Methods}{
#  @allmethods "public"
# }
#
# @author
# @keyword internal
#*/###########################################################################
setConstructorS3("Interface", function(core=NA, ...) {
  this <- core;
  class(this) <- "Interface";
  this;
}, private=TRUE)


setMethodS3("extend", "Interface", function(this, ...className, ...) {
  class(this) <- unique(c(...className, class(this)));
  this;
})


setMethodS3("uses", "Interface", function(this, ...) {
  setdiff(class(this), "Interface");
})

setMethodS3("uses", "character", function(className, ...) {
  clazz <- Class$forName(className);
  obj <- newInstance(clazz);
  uses(obj, ...);
})


setMethodS3("as.character", "Interface", function(x, ...) {
  # To please R CMD check
  this <- x;

  # Check if there are class "after" this one
  pos <- which("Interface" == class(this));
  isLast <- (pos == length(class(this)));
  if (isLast) {
    s <- paste(class(this), collapse=", ");
  } else {
    s <- NextMethod("as.character", this, ...);
  }
  s;
}, private=TRUE)


setMethodS3("print", "Interface", function(x, ...) {
  # To please R CMD check
  this <- x;

  print(as.character(this), ...);
})


############################################################################
# HISTORY:
# 2008-05-09
# o Added uses() for a character string.
# 2006-09-11
# o Added trial version of an Interface class.
############################################################################
