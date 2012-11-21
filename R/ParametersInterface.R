###########################################################################/**
# @RdocClass ParametersInterface
#
# @title "The ParametersInterface class interface"
#
# \description{
#  @classhierarchy
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# @author
#*/########################################################################### 
setConstructorS3("ParametersInterface", function(...) {
  extend(Interface(), "ParametersInterface");
})


###########################################################################/**
# @RdocMethod getParameters
#
# @title "Gets a list of parameters"
#
# \description{
#  @get "title" associated with the object.
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Not used.}
# }
#
# \value{
#  Returns a named @list.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getParameters", "ParametersInterface", function(this, ...) {
  list();
})


###########################################################################/**
# @RdocMethod getParametersAsString
#
# @title "Gets the parameters as character"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Arguments passed to @seemethod "getParameters".}
#  \item{collapse}{(optional) A @character string used to collapse the
#    individual parameter strings.}
# }
#
# \value{
#  Returns a @character @vector.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getParametersAsString", "ParametersInterface", function(this, ..., collapse=NULL) {
  params <- getParameters(this, ...);

  # Coerce to character strings
  params <- trim(capture.output(str(params)))[-1];
  params <- gsub("^[$][ ]*", "", params);
  params <- gsub(" [ ]*", " ", params);
  params <- gsub("[ ]*:", ":", params);

  # Collapse?
  if (!is.null(collapse)) {
    params <- paste(params, collapse=collapse);
  }

  params;
})


############################################################################
# HISTORY:
# 2012-11-20
# o Added Rdoc comments.
# o Created.
############################################################################
