.patchSerialize <- function(...) {
  serialize2 <- function(object, connection, ...) {
    if (is.null(connection)) {
      # It is faster to serialize to a temporary file and read it back
      pathname <- tempfile();
      con <- file(pathname, open="wb");
      on.exit({
        if (!is.null(con))
          close(con);
        if (file.exists(pathname))
          file.remove(pathname);
      });
      serializeOrg(object, connection=con, ...);
      close(con);
      con <- NULL;
      fileSize <- file.info(pathname)$size;
      readBin(pathname, what=raw(), n=fileSize);
    } else {
      serializeOrg(object, connection=connection, ...);
    }
  } # serialize2()

  if ((.Platform$OS.type %in% "windows") && (getRversion() < "2.12.0")) {
    serializeOrg <- base::serialize;
    if (is.null(attr(serializeOrg, "oldValue"))) {
      assignInNamespace("serializeOrg", serializeOrg, ns="base", 
                                                envir=baseenv());
    }
    reassignInPackage("serialize", "base", serialize2);
  }
} # .patchSerialize()

############################################################################
# HISTORY:
# 2011-01-30
# o The slow performance of serialize() on Windows was fixed in 
#   R v2.11.1 patched on July 20, 2010.
# 2008-07-24
# o Added patch for slow base::serialize() on Windows.
# o Created.
############################################################################
