# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Bioconductor related
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
.requireBiocPackage <- function(package, neededBy="aroma.core", ...) {
  # Trick 'R CMD check' to not generate NOTEs.
  requireX <- base::require
  catX <- base::cat

  res <- suppressWarnings({
    requireX(package, character.only=TRUE)
  })

  # Not installed?
  if (!res) {
    if (interactive()) {
      # Trick 'R CMD check' to not generate NOTEs.
      catX("Package '", package, "' is not available or could not be loaded. Will now try to install it from Bioconductor (requires a working internet connection):\n")

      BiocManager::install(package)
      
      # Assert that the package can be successfully loaded
      res <- requireX(package, character.only=TRUE)
      if (!res) {
        throw(sprintf("Package %s could not be loaded. Please install it from Bioconductor, cf. https://www.bioconductor.org/", sQuote(package)))
      }
    } else {
      warning("Package '", package, "' could not be loaded. Without it ", neededBy, " will not work. Please install it from Bioconductor, cf. https://www.bioconductor.org/")
    }
  }
} # .requireBiocPackage()
