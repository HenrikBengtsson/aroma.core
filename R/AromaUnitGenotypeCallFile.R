###########################################################################/**
# @RdocClass AromaUnitGenotypeCallFile
#
# @title "The AromaUnitGenotypeCallFile class"
#
# \description{
#  @classhierarchy
#
#  An AromaUnitGenotypeCallFile is a @see "AromaUnitTabularBinaryFile".
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "AromaUnitTabularBinaryFile".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#*/########################################################################### 
setConstructorS3("AromaUnitGenotypeCallFile", function(...) {
  extend(AromaUnitCallFile(...), "AromaUnitGenotypeCallFile"
  );
})


setMethodS3("allocate", "AromaUnitGenotypeCallFile", function(static, ..., types=c("integer", "integer")) { 
  allocate.AromaUnitCallFile(static, ..., types=types);
}, static=TRUE)


setMethodS3("isHomozygote", "AromaUnitGenotypeCallFile", function(this, ..., drop=FALSE) {
  calls <- extractCalls(this, ..., drop=FALSE);

  res <- rep(TRUE, length=nrow(calls));
  for (cc in seq(length=ncol(calls))) {
    res <- res & (calls[,cc,1] == 0);
  }
  rm(calls);

  # Drop singleton dimensions?
  if (drop) {
    res <- drop(res);
  }

  res;
})


setMethodS3("isHeterozygote", "AromaUnitGenotypeCallFile", function(this, ..., drop=FALSE) {
  calls <- extractCalls(this, ..., drop=FALSE);

  res <- rep(TRUE, length=nrow(calls));
  calls0 <- calls[,1,1,drop=FALSE];
  for (cc in 2:ncol(calls)) {
    res <- res & (calls[,cc,1] == calls0);
  }
  rm(calls, calls0);

  # Drop singleton dimensions?
  if (drop) {
    res <- drop(res);
  }

  res;
})


setMethodS3("extractGenotypeMatrix", "AromaUnitGenotypeCallFile", function(this, ..., emptyValue=c("", "-", "--"), noCallValue="NC", naValue=c(NA, "NA"), encoding=c("generic", "oligo"), drop=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'emptyValue':
  emptyValue <- match.arg(emptyValue);
  emptyValue <- Arguments$getCharacter(emptyValue, length=c(1,1));

  # Argument 'noCallValue':
  noCallValue <- match.arg(noCallValue);
  noCallValue <- Arguments$getCharacter(noCallValue, length=c(1,1));

  # Argument 'naValue':
  naValue <- naValue[1];
  naValue <- Arguments$getVector(naValue);

  # Argument 'encoding':
  encoding <- match.arg(encoding);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  verbose && enter(verbose, "Extracting genotypes calls");
  verbose && cat(verbose, "Fullname: ", getFullName(this));

  calls <- extractCalls(this, ..., drop=FALSE);
  dim <- dim(calls);
  dim <- dim[-length(dim)];
  dim(calls) <- dim;
  verbose && str(verbose, calls);

  verbose && enter(verbose, "Translating (C_A,C_B) to {NA,NC,<emptyValue>,A,B,AA,AB,BB,AAA,AAB,...}");
  hdr <- readHeader(this)$dataHeader;
  nbrOfBits <- 8*hdr$sizes[1];
  maxValue <- as.integer(2^nbrOfBits-3);

  res <- matrix(naValue, nrow=nrow(calls), ncol=1);

  # Genotypes
  isGenotype <- (calls >= 0 & calls <= maxValue);
  verbose && cat(verbose, "isGenotype:")
  verbose && str(verbose, isGenotype)
;
  idxs <- whichVector(isGenotype[,1] & isGenotype[,2]);
  rm(isGenotype);
  if (length(idxs) > 0) {
    verbose && cat(verbose, "Genotypes identified: ", length(idxs));

    # Number of A:s and B:s
    resT <- character(length(idxs));
    for (jj in 1:2) {
      allele <- c("A", "B")[jj];
      callsJJ <- calls[idxs,jj];
      uCalls <- sort(unique(callsJJ));
      for (uu in seq(along=uCalls)) {
        count <- uCalls[uu];
        callsUU <- paste(rep(allele, times=count), collapse="");
        idxsUU <- whichVector(callsJJ == count);
        resT[idxsUU] <- paste(resT[idxsUU], callsUU, sep="");
      } # for (uu ...)
      rm(callsJJ, idxsUU, uCalls);
    } # for (jj ...)

    # Homozygote deletion, i.e. (C_A,C_B) = (0,0)
    resT[(resT == "")] <- emptyValue;

    res[idxs] <- resT;
    rm(resT);
  }

  # NoCall:s
  valueOnFile <- as.integer(maxValue+1);
  idxs <- whichVector(calls[,1] == valueOnFile);
  if (length(idxs) > 0) {
     verbose && cat(verbose, "NoCalls identified: ", length(idxs));
     res[idxs] <- noCallValue;
  }

  # The remaining are "NA":s
  idxs <- whichVector(is.na(res));
  if (length(idxs) > 0) {
    verbose && cat(verbose, "Missing calls identified: ", length(idxs));
    res[idxs] <- naValue;
  }

  verbose && exit(verbose);

  if (encoding != "generic") {
    verbose && enter(verbose, "Encodes genotypes");
    verbose && cat(verbose, "Map: ", encoding);
    if (encoding == "oligo") {
      calls <- integer(length(res));
      # Genotype map according to 'oligo'
      calls[res == "AA"] <- as.integer(1);
      calls[res == "AB"] <- as.integer(2);
      calls[res == "BB"] <- as.integer(3);
      calls[res == "NC"] <- as.integer(0);
      dim(calls) <- dim(res);
      res <- calls;
      rm(calls);
    }
    verbose && exit(verbose);
  }

  if (drop) {
    res <- res[,1];
  }

  verbose && exit(verbose);

  res;
})


setMethodS3("extractGenotypes", "AromaUnitGenotypeCallFile", function(this, ...) {
  extractGenotypeMatrix(this, ...);
})



setMethodS3("updateGenotypes", "AromaUnitGenotypeCallFile", function(this, units=NULL, calls, ..., encoding=c("generic", "oligo"), verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'units':
  if (is.null(units)) {
    nbrOfUnits <- nbrOfUnits(this);
    units <- 1:nbrOfUnits;
  } else {
    nbrOfUnits <- nbrOfUnits(this);
    units <- Arguments$getIndices(units, range=c(1,nbrOfUnits));
    nbrOfUnits <- length(units);
  }

  # Argument 'encoding':
  encoding <- match.arg(encoding);

  # Argument 'calls':
  if (encoding == "generic") {
  } else if (encoding == "oligo") {
    # Translate oligo encoded genotypes to generic ones
    if (is.numeric(calls)) {
      calls2 <- character(length(calls));
      # Genotype map according to 'oligo'
      calls2[calls == 1] <- "AA";
      calls2[calls == 2] <- "AB";
      calls2[calls == 3] <- "BB";
      calls2[calls == 0] <- "NC";
      calls <- calls2;
      rm(calls2);
    }
  }

  # Validate generic encoded genotypes
  calls[is.na(calls)] <- "NA";
  calls <- Arguments$getCharacters(calls, length=nbrOfUnits, asGString=FALSE);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }



  verbose && enter(verbose, "Updating genotype calls");
  verbose && cat(verbose, "Fullname: ", getFullName(this));

  verbose && enter(verbose, "Validating calls");
  pattern <- "^(|[-]+|NA|NC|[AB]+)$";
  unknown <- calls[(regexpr(pattern, calls) == -1)];
  verbose && str(verbose, unknown);
  if (length(unknown) > 0) {
    unknown <- unique(unknown);
    unknown <- sort(unknown);
    unknown <- head(unknown);
    throw("Argument 'calls' contains unknown genotypes: ", 
                                        paste(unknown, collapse=", "));
  }
  rm(unknown);
  verbose && exit(verbose);

  verbose && enter(verbose, "Translating {NA,NC,(|-),A,B,AA,AB,BB,AAA,AAB,...} to (C_A,C_B)");
  naValue <- as.character(NA);
  values <- matrix(naValue, nrow=nbrOfUnits, ncol=2);

  # NoCalls
  pattern <- "^NC$";
  idxs <- grep(pattern, calls);
  if (length(idxs) > 0) {
    verbose && cat(verbose, "NoCalls identified: ", length(idxs));
    hdr <- readHeader(this)$dataHeader;
    nbrOfBits <- 8*hdr$sizes[1];
    valueOnFile <- as.integer(2^nbrOfBits-2);
    values[idxs,] <- valueOnFile;
  }

  # Missing calls
  pattern <- "^NA$";
  idxs <- grep(pattern, calls);
  if (length(idxs) > 0) {
    verbose && cat(verbose, "Missing calls identified: ", length(idxs));
    hdr <- readHeader(this)$dataHeader;
    nbrOfBits <- 8*hdr$sizes[1];
    valueOnFile <- as.integer(2^nbrOfBits-1);  # NA
    values[idxs,] <- valueOnFile;
  }

  # Homozygote deletion, i.e. (C_A,C_B) = (0,0)
  pattern <- "^(|[-]+)$";
  idxs <- grep(pattern, calls);
  if (length(idxs) > 0) {
    verbose && cat(verbose, "Homozygote deletions identified: ", length(idxs));
    values[idxs,] <- as.integer(0);
  }

  # Genotypes {A, B, AA, AB, BB, AAA, AAB, ...}
  pattern <- "^[AB]+$";
  idxs <- grep(pattern, calls);
  if (length(idxs) > 0) {
    verbose && cat(verbose, "Genotypes identified: ", length(idxs));
    callsT <- strsplit(calls[idxs], split="", fixed=TRUE);

    # Count number of A:s and B:s
    counts <- lapply(callsT, FUN=function(s) {
      c(sum(s == "A"), sum(s == "B"));
    });
    rm(callsT);
    counts <- unlist(counts, use.names=FALSE);
    counts <- matrix(counts, ncol=2, byrow=TRUE);

    for (cc in 1:2) {
      values[idxs,cc] <- counts[,cc];
    }
    rm(counts);
  }
  rm(idxs);
  verbose && exit(verbose);

  verbose && enter(verbose, "Storing (C_A,C_B)");
  verbose && str(verbose, values);
  for (cc in 1:2) {
    this[units,cc] <- values[,cc];
  }
  rm(values);
  verbose && exit(verbose);

  verbose && exit(verbose);

  invisible(this);
})


############################################################################
# HISTORY:#
# 2009-01-12
# Added isHomozygote() and isHeterozygote().
# 2009-01-10
# o Added argument 'encoding' to extract-/updateGenotypes() with support
#   for oligo nucleotides {1,2,3}.
# o Now extract-/updateGenotypes() encodes NA=missing value, NC=no call, 
#   ''='-'='--'=(0,0), 'A'=(1,0), ..., 'AABBA'=(3,2), ...
# 2009-01-04
# o Now inherits from AromaUnitCallFile.
# 2008-12-08
# o Recreated.  Now only with columns (genotypeCall, confidenceScore).
# o Added findUnitsTodo() and extractCalls().
# 2008-12-05
# o Created.
############################################################################
