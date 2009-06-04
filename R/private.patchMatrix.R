.patchMatrix <- function(...) {
  # Nothing to do?
  if (compareVersion(as.character(getRversion()), "2.7.0") >= 0)
    return();

  # A more memory efficient matrix() function when 'dimnames' is NULL.
  matrix.patch <- function(data=NA, nrow=1, ncol=1, byrow=FALSE, dimnames=NULL) {
    data <- as.vector(data);
  
    if(missing(nrow)) {
      nrow <- ceiling(length(data)/ncol);
    } else if(missing(ncol)) {
      ncol <- ceiling(length(data)/nrow);
    }
  
    # Trick to avoid extra copy in the case when 'dimnames' is NULL.
    if (is.null(dimnames)) {
      .Internal(matrix(data, nrow, ncol, byrow));
    } else {
      x <- .Internal(matrix(data, nrow, ncol, byrow));
      dimnames(x) <- dimnames;
      x;
    }
  }
  
  # Patch base::matrix()
  reassignInPackage("matrix", "base", matrix.patch);
} # .patchMatrix()


############################################################################
# HISTORY:
# 2008-02-12 [HB]
# o In R v2.7.0, the internal code of matrix() fixes the above problem.
# 2007-07-04 [HB]
# o Created.  This patches matrix() so that it avoid copying if x[1,1] <- 1
#   is applied directly after create a matrix without dimension names.  The
#   modification is according to Luke Tierney's suggestion in a private 
#   email on 2007-07-04.
############################################################################
