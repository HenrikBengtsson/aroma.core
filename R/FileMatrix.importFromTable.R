setMethodS3("importFromTable", "FileMatrix", function(static, filename, path=NULL, srcPathname, colClasses=NULL, header=TRUE, sep="\t", skip=0, nrows=-1, col.names=NULL, ..., ram=NULL, verbose=FALSE) {
  throw("Static method importFromTable() for FileMatrix is deprecated.");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'filename' and 'path':
  pathname <- Arguments$getWritablePathname(filename, path, mustNotExist=TRUE);

  # Argument 'srcPathname':
  srcPathname <- Arguments$getReadablePathname(srcPathname, mustExist=TRUE);

  # Argument 'colClasses':
  if (!is.null(colClasses)) {
    colClasses <- Arguments$getCharacters(colClasses);
  }

  # Argument 'ram':
  ram <- getRam(aromaSettings, ram);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Importing data from text file/connection");
  verbose && cat(verbose, "Destination pathname: ", pathname);
  verbose && cat(verbose, "Source pathname: ", srcPathname);

  # Try to open connection
  con <- file(srcPathname, open="r");
  on.exit(close(con));

  # Skip rows
  if (skip > 0) {
    line <- readLines(con, n=skip);
  }

  # Read header
  if (header) {
    line <- readLines(con, n=1);
    if (is.null(col.names)) {
      col.names <- strsplit(line, split=sep)[[1]];
    }
  }

  # Number of column to be read
  if (is.null(colClasses)) {
    ncol <- length(col.names);
  } else {
    keep <- (colClasses != "NULL");
    ncol <- sum(keep);
    col.names <- col.names[keep];
    verbose && cat(verbose, "Number of data columns (to be read): ", ncol);
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Number of rows to be read
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (nrows == -1) {
    verbose && enter(verbose, "Counting the number of data rows in file");
    # Count the number of rows available
    dataOffset <- seek(con, rw="read");
    nrows <- 0;
    nrowsPerChunk <- 1e4;
    count <- 0;
    while (TRUE) {
      dummy <- readLines(con, n=nrowsPerChunk, warn=TRUE);
      if (length(dummy) == 0)
        break;
      nrows <- nrows + length(dummy);
      if (count %% 10 == 0)
        verbose && cat(verbose, nrows);
      count <- count + 1;
    };
    nrows <- as.integer(nrows);
    rm(dummy);
    seek(con, where=dataOffset, rw="read");
    verbose && exit(verbose);
  }
  verbose && cat(verbose, "Number of data rows: ", nrows);


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Allocating FileMatrix
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Allocating ", class(static)[1]);
  nrow <- nrows;
  colnames <- col.names;
  res <- newInstance(static, pathname, nrow=nrow, ncol=ncol, 
                                                       colnames=col.names);
  verbose && print(verbose, res);
  verbose && exit(verbose);


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Import data in chunks
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  bytesPerChunk <- ram * 25e6;
  bytesPerRow <- ncol * res$bytesPerCell;
  rowsPerChunk <- floor(bytesPerChunk / bytesPerRow);
  nbrOfChunks <- ceiling(nrows / rowsPerChunk);

  verbose && cat(verbose, "Rows per chunk: ", rowsPerChunk);
  nrowsLeft <- nrows;
  lastRow <- 0;
  count <- 1;
  while (nrowsLeft > 0) {
    verbose && enter(verbose, sprintf("Chunk #%d of %d", count, nbrOfChunks));
    if (nrowsLeft < rowsPerChunk) {
      nrowsToRead <- nrowsLeft;
    } else {
      nrowsToRead <- rowsPerChunk;
    }
    data <- read.table(file=con, colClasses=colClasses, sep=sep, 
                                   header=FALSE, nrows=nrowsToRead, ...);
    data <- as.matrix(data);
    verbose && str(verbose, data);

    # Garbage collect
    gc <- gc();
    verbose && print(verbose, gc);

    # Rows to be updated
    nr <- nrow(data);
    if (nr == 0) {
      throw("Internal error");
    }

    rows <- lastRow + seq_len(nr);
    verbose && printf(verbose, "Rows [%d]:\n", nr);
    verbose && str(verbose, rows);

    # Store data
    res[rows,] <- data;
    rm(data);

    # Garbage collect
    gc <- gc();
    verbose && print(verbose, gc);

    lastRow <- lastRow + nr;
    nrowsLeft <- nrowsLeft - nr;

    count <- count + 1;
    verbose && exit(verbose);
  } # while (nrowsLeft > 0)

  verbose && exit(verbose);

  res;
}, static=TRUE)

############################################################################
# HISTORY:
# 2011-02-18
# o CLEANUP: Deprecated static method importFromTable() for FileMatrix.
# 2008-05-21
# o BUG FIX: Argument 'verbose' was never passed to Arguments$getVerbose().
# 2007-04-01
# o TO DO: Make more generic (bullet proof) before moving into R.huge.
# o Created.
############################################################################
