library <- function(...) {
  res <- withVisible(base::library(...));
  callHooks("base::library:onLoad");
  value <- res$value;
  if (res$visible) {
    return(value);
  } else {
    return(invisible(value));
  }
} # library()

require <- function(...) {
  res <- withVisible(base::require(...));
  callHooks("base::library:onLoad");
  value <- res$value;
  if (res$visible) {
    return(value);
  } else {
    return(invisible(value));
  }
} # library()
