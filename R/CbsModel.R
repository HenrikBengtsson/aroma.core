###########################################################################/**
# @RdocClass CbsModel
#
# @title "The CbsModel class"
#
# \description{
#  @classhierarchy
#
#  This class represents the Circular Binary Segmentation (CBS) model [1].
# }
#
# @synopsis
#
# \arguments{
#   \item{cesTuple}{A @see "CopyNumberDataSetTuple".}
#   \item{...}{Arguments passed to the constructor of
#              @see "CopyNumberSegmentationModel".}
#   \item{seed}{An (optional) @integer that if specified will (temporarily)
#     set the random seed each time before calling the segmentation method.
#     For more information, see @see "segmentByCBS".}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# @author
#
# \seealso{
#  @see "CopyNumberSegmentationModel".
# }
#
# \references{
#  [1] Olshen, A. B., Venkatraman, E. S., Lucito, R., Wigler, M.
#      \emph{Circular binary segmentation for the analysis of array-based
#      DNA copy number data. Biostatistics 5: 557-572, 2004.}\cr
#  [2] Venkatraman, E. S. & Olshen, A. B.
#      \emph{A faster circular binary segmentation algorithm for the
#      analysis of array CGH data}. Bioinformatics, 2007.\cr
# }
#*/###########################################################################
setConstructorS3("CbsModel", function(cesTuple=NULL, ..., seed=NULL) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Load required packages
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!is.null(cesTuple)) {
    # Early error, iff package is not available
    requireNamespace("DNAcopy") || throw("Package not loaded: DNAcopy")
  }

  # Argument 'seed':
  if (!is.null(seed)) {
    seed <- Arguments$getInteger(seed)
  }

  extend(CopyNumberSegmentationModel(cesTuple=cesTuple, ...), "CbsModel",
    .seed = seed
  )
})

setMethodS3("getRandomSeed", "CbsModel", function(this, ...) {
  this$.seed
}, protected=TRUE)

setMethodS3("setRandomSeed", "CbsModel", function(this, seed, ...) {
  # Argument 'seed':
  if (!is.null(seed)) {
    seed <- Arguments$getInteger(seed)
  }

  this$.seed <- seed
  invisible(this)
}, protected=TRUE)


setMethodS3("getFitFunction", "CbsModel", function(this, ...) {
  defaultSeed <- getRandomSeed(this)
  fitFcn <- function(..., seed=defaultSeed) {
    segmentByCBS(..., seed=seed)
  }
  fitFcn
}, protected=TRUE)
