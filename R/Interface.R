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
  res <- setdiff(class(this), "Interface");
  if (length(list(...)) > 0) {
    res <- c(list(res), list(uses(...)));

    # Order interfaces/classes
    names <- sort(unique(unlist(res, use.names=FALSE)));
    idxs <- integer(length(names));
    names(idxs) <- names;
    for (kk in seq(along=res)) {
      for (name in res[[kk]]) {
        idxs[name] <- kk;        
      }
    }
    for (kk in seq(along=res)) {
      keep <- (idxs[res[[kk]]] == kk);
      res[[kk]] <- res[[kk]][keep];
    }
    res <- unlist(res, use.names=FALSE);
  }
  res;
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


setMethodS3("getFields", "Interface", function(...) { NULL })


############################################################################
# HISTORY:
# 2009-07-22
# o Now uses(...) takes multiple Interface classes.
# 2009-06-10
# o Added getFields() to Interface as an ad hoc solutions to avoid
#   print(<Interface>) throwing 'Error in UseMethod("getFields") : no 
#   applicable method for "getFields"'.
# 2008-05-09
# o Added uses() for a character string.
# 2006-09-11
# o Added trial version of an Interface class.
############################################################################
