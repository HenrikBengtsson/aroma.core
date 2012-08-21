# Allows conflicts. For more information, see library() and
# conflicts() in [R] base.
# .conflicts.OK <- TRUE

# WORKAROUND: In order for the package to work with the most recent
# version of R devel, which automatically add namespaces to packages
# who do not have one, we explicitly have specify the following.
# /HB 2011-07-27
##cat <- R.utils::cat;
##getOption <- R.utils::getOption;
##lapply <- R.utils::lapply;
append <- R.filesets::append;
sapply <- R.filesets::sapply;

##.First.lib <- function(libname, pkgname) {
.onAttach <- function(libname, pkgname) {
  pkg <- AromaCore(pkgname);
  assign(pkgname, pkg, pos=getPosition(pkg));

  # Setup package
  .setupAromaCore(pkg);

  packageStartupMessage(getName(pkg), " v", getVersion(pkg), " (", 
    getDate(pkg), ") successfully loaded. See ?", pkgname, " for help.");
}
