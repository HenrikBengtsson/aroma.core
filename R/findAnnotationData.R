###########################################################################/**
# @RdocDefault findAnnotationData
#
# @title "Locates an annotation data file"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{name}{A @character string.}
#   \item{tags}{Optional @character string.}
#   \item{pattern}{A filename pattern to search for.}
#   \item{private}{If @FALSE, files and directories starting 
#     with a periods are ignored.}
#   \item{...}{Arguments passed to @see "affxparser::findFiles".}
#   \item{firstOnly}{If @TRUE, only the first matching pathname is returned.}
#   \item{paths}{A @character @vector of paths to search.
#     If @NULL, default paths are used.}
#   \item{set}{A @character string specifying what type of annotation 
#     to search for.}
#   \item{verbose}{A @logical or @see "R.utils::Verbose".}
# }
#
# \value{
#   Returns @NULL, one or several matching pathnames.
# }
#
# @author
#
# @keyword internal
#*/###########################################################################
setMethodS3("findAnnotationData", "default", function(name, tags=NULL, set, pattern=NULL, private=FALSE, ..., firstOnly=TRUE, paths=NULL, verbose=FALSE) {
  # Needs affxparser::findFiles()

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'name':
  name <- Arguments$getCharacter(name, length=c(1,1));

  # Argument 'set':
  set <- Arguments$getCharacter(set, length=c(1,1));

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Main
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  fullname <- paste(c(name, tags), collapse=",");
  if (is.null(pattern)) {
    pattern <- fullname;
  }

  name <- gsub("[,].*", "", fullname);

  verbose && enter(verbose, "Searching for annotation data file(s)");

  verbose && cat(verbose, "Name: ", name);
  verbose && cat(verbose, "Tags: ", paste(tags, collapse=", "));
  verbose && cat(verbose, "Set: ", set);
  verbose && cat(verbose, "Filename pattern: ", pattern);
  verbose && cat(verbose, "Paths (from argument): ", paste(paths, collapse=", "));

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get search paths
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  paths0 <- paths;

  if (is.null(paths)) {
    paths <- "annotationData";
    verbose && cat(verbose, "Paths (default): ", paste(paths, collapse=", "));
  } else {
    # Split path strings by semicolons.
    paths <- unlist(strsplit(paths, split=";"));
    verbose && cat(verbose, "Paths (updated): ", paste(paths, collapse=", "));
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Search in annotationData/<set>/<genome>/
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Expand any file system links
  paths <- file.path(paths, set, name);
  paths <- sapply(paths, FUN=filePath, expandLinks="any");

  verbose && cat(verbose, "Paths (final): ", paste(paths, collapse=", "));

  # Search recursively for all files
  args <- list(...);
  args$pattern <- pattern;
  args$allFiles <- private;
  args$paths <- paths;
  args$recursive <- TRUE;
  args$firstOnly <- FALSE;
  verbose && cat(verbose, "Arguments to findFiles:");
  verbose && str(verbose, args);
  localFindFiles <- function(...) {
    affxparser::findFiles(...);
  }
  pathnames <- do.call("localFindFiles", args=args);

  # No files found?
  if (length(pathnames) == 0) {
    verbose && exit(verbose);
    return(NULL);
  }

  # AD HOC: Clean out files in "private" directories
  if (!private) {
    isInPrivateDirectory <- function(pathname) {
      pathname <- strsplit(pathname, split="[/\\\\]")[[1]];
      pathname <- pathname[!(pathname %in% c(".", ".."))];
      any(regexpr("^[.]", pathname) != -1);
    }

    excl <- sapply(pathnames, FUN=isInPrivateDirectory);
    pathnames <- pathnames[!excl];

    # No files remaining?
    if (length(pathnames) == 0) {
      verbose && exit(verbose);
      return(NULL);
    }
  }

  # Order located pathnames in increasing length of the fullnames
  # This is an AD HOC solution for selecting GenomeWideSNP_6 before
  # GenomeWideSNP_6,Full.
  # (a) Get filenames
  filenames <- basename(pathnames);
  # (b) Get fullnames by dropping filename extension
  fullnames <- gsub("[.][^.]*$", "", filenames);
  # (c) Order by length of fullnames
  o <- order(nchar(fullnames));
  pathnames <- pathnames[o];

  # Keep first match?
  if (firstOnly && length(pathnames) > 1) {
    pathnames <- pathnames[1];
  }

  verbose && cat(verbose, "Located pathname(s):");
  verbose && print(verbose, pathnames);

  verbose && exit(verbose);

  pathnames;
}, protected=TRUE)  # findAnnotationData()

############################################################################
# HISTORY:
# 2009-02-10
# o Now findAnnotationData() always returns pathnames ordered by the length
#   of their fullnames. Before this was only done if 'firstOnly=TRUE'.
# 2008-05-21
# o Updated findAnnotationData() to only "import" affxparser.
# 2008-05-18
# o BUG FIX: findAnnotationDataByChipType(chipType="GenomeWideSNP_6", 
#   pattern="^GenomeWideSNP_6.*[.]ugp$") would find file 
#   'GenomeWideSNP_6,Full,na24.ugp' before 'GenomeWideSNP_6,na24.ugp'.
#   Now we return the one with the shortest full name.
# 2008-05-10
# o BUG FIX: When searching with 'firstOnly=FALSE', findAnnotationData() 
#   was identifying files that are in "private" directory.  This is how
#   affxparser::findFiles() works.  Such files are now filtered out.
# 2008-05-09
# o Removed the option to specify the annotation data path by the option
#   'aroma.affymetrix.settings'.
# 2008-02-14
# o Added argument 'private=TRUE' to findAnnotationData().
# 2007-09-15
# o Created from findAnnotationDataByChipType.R.
############################################################################
