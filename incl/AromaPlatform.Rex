library("aroma.affymetrix")
platform <- AromaPlatform$byName("Affymetrix")
print(platform)
stopifnot(getName(platform) == "Affymetrix")
