library("aroma.cn");
verbose <- Arguments$getVerbose(-8, timestamp=TRUE);

dataSet <- "GSE20939";
tags <- "ACC,-XY,BPN,-XY,RMA,FLN,-XY";
chipTypes <- c("Mapping250K_Nsp", "Mapping250K_Sty");
fit <- doCBS(dataSet, tags=tags, chipTypes=chipTypes, verbose=verbose);
print(fit);
