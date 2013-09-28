# WORKAROUND: In order for the package to work with the most recent
append <- R.filesets::append;


.onLoad <- function(libname, pkgname) {
  ns <- getNamespace(pkgname);
  pkg <- AromaCore(pkgname);
  assign(pkgname, pkg, envir=ns);
} # .onLoad()


.onAttach <- function(libname, pkgname) {
  pkg <- get(pkgname, envir=getNamespace(pkgname));

  # Setup package
  .setupAromaCore(pkg);

  startupMessage(pkg);
}
