###########################################################################/**
# @RdocClass "AromaCellPositionFile"
# 
# @title "A binary file holding chromosome/position for each cell"
#
# \description{
#   @get "title".
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Arguments passed to constructor of 
#             @see "AromaCellTabularBinaryFile".}
# }
#
# \details{
#   Note that this class does \emph{not} assume a rectangular chip layout.
#   In other words, there is no concept of mapping a \emph{spatial}
#   location on the array to a cell index and vice versa.
#   The reason for this to be able to use this class also for 
#   non-rectangular chip types.
# }
#
# @author
#*/###########################################################################
setConstructorS3("AromaCellPositionFile", function(...) {
  extend(AromaCellTabularBinaryFile(...), "AromaCellPositionFile");
})

setMethodS3("getFilenameExtension", "AromaCellPositionFile", function(static, ...) {
  "acp";
}, static=TRUE)

setMethodS3("getDefaultExtension", "AromaCellPositionFile", function(static, ...) {
  "acp";
}, static=TRUE)


setMethodS3("getExtensionPattern", "AromaCellPositionFile", function(static, ...) {
  "[.](acp)$";
}, static=TRUE, protected=TRUE)


setMethodS3("getColumnNames", "AromaCellPositionFile", function(this, ...) {
  c("chromosome", "position");
})



setMethodS3("byChipType", "AromaCellPositionFile", function(static, chipType, tags=NULL, nbrOfCells=NULL, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'chipType':
  chipType <- Arguments$getCharacter(chipType, length=c(1,1));

  # Argument 'nbrOfCells':
  if (!is.null(nbrOfCells)) {
    nbrOfCells <- Arguments$getInteger(nbrOfCells, range=c(0,Inf));
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Locating ", class(static)[1]);
  pathname <- findByChipType(static, chipType=chipType, tags=tags, 
      firstOnly=TRUE, ...);
  if (is.null(pathname)) {
    ext <- getDefaultExtension(static);
    note <- attr(ext, "note");
    msg <- sprintf("Failed to create %s object. Could not locate an annotation data file for chip type '%s'", class(static)[1], chipType);
    if (is.null(tags)) {
      msg <- sprintf("%s (without requiring any tags)", msg);
    } else {
      msg <- sprintf("%s with tags '%s'", msg, paste(tags, collapse=","));
    }
    msg <- sprintf("%s and with filename extension '%s'", msg, ext);
    if (!is.null(note)) {
      msg <- sprintf("%s (%s)", msg, note);
    }
    msg <- sprintf("%s.", msg);
    throw(msg);
  }

  verbose && cat(verbose, "Located file: ", pathname);
  res <- newInstance(static, pathname);
  verbose && print(verbose, res);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validation?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!is.null(nbrOfCells)) {
    if (nbrOfCells(res) != nbrOfCells) {
      throw("The number of cells in the loaded ", class(static)[1], " does not match the expected number: ", nbrOfCells(res), " != ", nbrOfCells);
    }
  }

  verbose && exit(verbose);

  res;
}, static=TRUE)



setMethodS3("readPositions", "AromaCellPositionFile", function(this, cells=NULL, drop=FALSE, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'cells':
  nbrOfCells <- nbrOfCells(this);
  if (!is.null(cells)) {
    cells <- Arguments$getIndices(cells, max=nbrOfCells);
    nbrOfCells <- length(cells);
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  verbose && enter(verbose, "Reading match scores");

  # Read data
  verbose && enter(verbose, "Reading data frame");
  res <- readDataFrame(this, rows=cells, columns=2, verbose=less(verbose, 5));
  verbose && exit(verbose);

  # Flatten (data frame)
  dim <- dim(res);
  res <- unlist(res, use.names=FALSE);

  verbose && exit(verbose);

  res;
})


setMethodS3("updatePositions", "AromaCellPositionFile", function(this, cells=NULL, scores, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Argument 'cells':
  nbrOfCells <- nbrOfCells(this);
  if (!is.null(cells)) {
    cells <- Arguments$getIndices(cells, max=nbrOfCells);
    nbrOfCells <- length(cells);
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Optimize
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Remove duplicated 'cells'
  keep <- whichVector(!duplicated(cells));
  cells <- cells[keep];
  scores <- scores[keep];
  rm(keep);

  # Order by 'cells'
  srt <- sort(cells, method="quick", index.return=TRUE);
  o <- srt$ix;
  cells <- srt$x;
  rm(srt);
  scores <- scores[o];
  rm(o);

  lastColumn <- nbrOfColumns(this);
  this[cells,lastColumn] <- as.integer(scores);
})


setMethodS3("isMissing", "AromaCellPositionFile", function(this, ...) {
  res <- readPositions(this, ..., positions=1, drop=TRUE);
  res <- (res == 0);
  res;
}, protected=TRUE)


setMethodS3("allocate", "AromaCellPositionFile", function(static, ..., nbrOfCells, platform, chipType, footer=list()) {
  # Argument 'nbrOfCells':
  nbrOfCells <- Arguments$getInteger(nbrOfCells, range=c(1, 1000e6));

  # Argument 'platform':
  platform <- Arguments$getCharacter(platform, length=c(1,1));

  # Argument 'chipType':
  chipType <- Arguments$getCharacter(chipType, length=c(1,1));

  # Argument 'footer':
  if (is.null(footer)) {
  } else if (!is.list(footer)) {
    throw("Argument 'footer' must be NULL or a list: ", class(footer)[1]);
  }

  footer <- c(
    list(
      createdOn=format(Sys.time(), "%Y%m%d %H:%M:%S", usetz=TRUE),
      platform=platform,
      chipType=chipType
    ), 
    footer
  );

  NextMethod("allocate", nbrOfRows=nbrOfCells, types=rep("integer",2), sizes=c(1,4), footer=footer);
}, static=TRUE)



############################################################################
# HISTORY:
# 2009-02-16 [HB]
# Removed argument 'validate' from byChipType() of AromaCellPositionFile.
# 2009-02-10 [HB]
# o Added optional validation of number of cells to byChipType().
# o Static method byChipType() was not declared static.
# 2008-12-09 [MR]
# o Created from AromaCellMatchScoresFile.R.
############################################################################
