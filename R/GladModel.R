###########################################################################/**
# @RdocClass GladModel
#
# @title "The GladModel class"
#
# \description{
#  @classhierarchy
#
#  This class represents the Gain and Loss Analysis of DNA regions
#  (GLAD) model [1].
#  This class can model chip-effect estimates obtained from multiple
#  chip types, and not all samples have to be available on all chip types.
# }
#
# @synopsis
#
# \arguments{
#   \item{cesTuple}{A @see "CopyNumberDataSetTuple".}
#   \item{...}{Arguments passed to the constructor of
#              @see "CopyNumberSegmentationModel".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# \details{
#   Data from multiple chip types are combined "as is".  This is based
#   on the assumption that the relative chip effect estimates are
#   non-biased (or at the equally biased across chip types).
#   Note that in GLAD there is no way to down weight certain data points,
#   which is why we can control for differences in variance across
#   chip types.
# }
#
# \section{Benchmarking}{
#   In high-density copy numbers analysis, the most time consuming step
#   is fitting the GLAD model.  The complexity of the model grows
#   more than linearly (squared? exponentially?) with the number of data
#   points in the chromosome and sample being fitted.  This is why it
#   take much more than twice the time to fit two chip types together
#   than separately.
# }
#
# @author
#
# \seealso{
#  @see "CopyNumberSegmentationModel".
# }
#
# \references{
#  [1] Hupe P et al. \emph{Analysis of array CGH data: from signal ratio to
#      gain and loss of DNA regions}. Bioinformatics, 2004, 20, 3413-3422.\cr
# }
#*/###########################################################################
setConstructorS3("GladModel", function(cesTuple=NULL, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Load required packages
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!is.null(cesTuple)) {
    requireWithMemory("GLAD") || throw("Package not loaded: GLAD")
  }

  extend(CopyNumberSegmentationModel(cesTuple=cesTuple, ...), "GladModel")
})

setMethodS3("getFitFunction", "GladModel", function(this, ...) {
  segmentByGLAD
}, protected=TRUE)


setMethodS3("writeRegions", "GladModel", function(this, arrays=NULL, format=c("xls", "wig"), digits=3, ..., oneFile=TRUE, skip=TRUE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'arrays':
  arrays <- indexOf(this, arrays)

  # Argument 'format':
  format <- match.arg(format)

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  }


  # Setup
  fullname <- getFullName(this)
  arrayNames <- getNames(this)

  path <- getPath(this)
  path <- Arguments$getWritablePath(path)

  if (oneFile) {
    filename <- sprintf("%s,regions.%s", fullname, format)
    pathname <- filePath(path, filename)
    pathname <- Arguments$getWritablePathname(pathname)
    if (!skip && isFile(pathname)) {
      file.remove(pathname)
    }
  }

  res <- list()
  for (aa in seq_along(arrays)) {
    array <- arrays[aa]
    name <- arrayNames[array]
    verbose && enter(verbose, sprintf("Array #%d ('%s') of %d",
                                               aa, name, length(arrays)))
    df <- getRegions(this, arrays=array, ..., verbose=less(verbose))[[1]]
    names(df) <- gsub("(Smoothing|mean)", "log2", names(df))
    verbose && str(verbose, df)

    if (nrow(df) > 0) {
      if (identical(format, "xls")) {
        # Append column with sample names
        df <- cbind(sample=name, df)
      } else if (identical(format, "wig")) {
        # Write a four column WIG/BED table
        df <- df[,c("Chromosome", "start", "stop", "log2")]

        # In the UCSC Genome Browser, the maximum length of one element
        # is 10,000,000 bases.  Chop up long regions in shorter contigs.
        verbose && enter(verbose, sprintf("Chopping up too long segment"))
        MAX.LENGTH = 10e6-1
        start <- df[,"start"]
        stop <- df[,"stop"]
        len <- stop-start
        tooLong <- which(len > MAX.LENGTH)
        if (length(tooLong) > 0) {
          dfXtra <- NULL
          for (rr in tooLong) {
            x0 <- start[rr]
            while (x0 < stop[rr]) {
              x1 <- min(x0 + MAX.LENGTH, stop[rr])
              df1 <- df[rr,]
              df1[,"start"] <- x0
              df1[,"stop"] <- x1
              dfXtra <- rbind(dfXtra, df1)
              x0 <- x1+1
            }
          }
          df <- df[-tooLong,]
          df <- rbind(df, dfXtra)
          # Not needed anymore
          dfXtra <- NULL
          row.names(df) <- seq_len(nrow(df))
        }
        verbose && exit(verbose)
        # Make sure the items are ordered correctly
        chrIdx <- as.integer(df[,"Chromosome"])
        o <- order(chrIdx, df[,"start"])
        df <- df[o,]

        # All chromosomes should have prefix 'chr'.
        chrIdx <- as.integer(df[,"Chromosome"])
        ## df[chrIdx == 23,"Chromosome"] <- "X" ## REMOVED 2007-03-15
        df[,"Chromosome"] <- paste("chr", df[,"Chromosome"], sep="")
      }

      # Apply digits
      for (cc in seq_len(ncol(df))) {
        value <- df[,cc]
        if (is.double(value)) {
          df[,cc] <- round(value, digits=digits)
        }
      }
    } # if (nrow(df) > 0)

    if (!oneFile) {
      savename <- name
      filename <- sprintf("%s,regions.%s", savename, format)
      pathname <- filePath(path, filename)
      if (!oneFile && !skip && isFile(pathname))
        file.remove(pathname)
    }

    # Writing to file
    verbose && cat(verbose, "Pathname: ", pathname)
    if (identical(format, "xls")) {
      col.names <- (array == arrays[1])
      suppressWarnings({
        write.table(df, file=pathname, sep="\t", col.names=col.names, row.names=FALSE, quote=FALSE, append=oneFile)
      })
    } else if (identical(format, "wig")) {
      # Write track control
      trackAttr <- c(type="wiggle_0")
      trackAttr <- c(trackAttr, name=sprintf("\"%s\"", name))
      trackAttr <- c(trackAttr, group="\"GLAD regions\"")
      trackAttr <- c(trackAttr, priority=array)
      trackAttr <- c(trackAttr, graphType="bar")
      trackAttr <- c(trackAttr, visibility="full")
      trackAttr <- c(trackAttr, maxHeightPixels="128:96:64")
      trackAttr <- c(trackAttr, yLineOnOff="on")
# HARD WIRED FOR NOW.  TO DO /hb 2006-11-27
col <- c("117,112,179", "231,41,138")
ylim <- c(-1,1)
      if (!is.null(col)) {
        trackAttr <- c(trackAttr, color=col[1], altColor=col[2])
      }
      if (!is.null(ylim)) {
        trackAttr <- c(trackAttr, autoScale="off",
              viewLimits=sprintf("%.2f:%.2f ", ylim[1], ylim[2]))
      }
      trackAttr <- paste(names(trackAttr), trackAttr, sep="=")
      trackAttr <- paste(trackAttr, collapse=" ")
      trackAttr <- paste("track ", trackAttr, "\n", sep="")
      verbose && str(verbose, trackAttr)
      cat(file=pathname, trackAttr, append=oneFile)

      # Write data
      verbose && str(verbose, df)
      write.table(df, file=pathname, sep="\t", col.names=FALSE, row.names=FALSE, quote=FALSE, append=TRUE)
    }
    verbose && exit(verbose)
    res[[array]] <- df
  }

  invisible(pathname)
})
