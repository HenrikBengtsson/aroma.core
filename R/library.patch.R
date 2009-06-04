library <- function(...) {
  res <- base::library(...);
  callHooks("base::library:onLoad");
  invisible(res);
} # library()

require <- function(...) {
  res <- base::require(...);
  callHooks("base::library:onLoad");
  invisible(res);
} # library()


############################################################################
# HISTORY:
# 2007-03-06
# o Added onLoad hooks to library() and require().
# o Created.
############################################################################

