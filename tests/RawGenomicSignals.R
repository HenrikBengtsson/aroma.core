library("aroma.core")

# - - - - - - - - - - - - - - - - - - - - - - - - - -
# Simulating copy-number data
# - - - - - - - - - - - - - - - - - - - - - - - - - -
# Number of loci
J <- 1000

mu <- double(J)
mu[200:300] <- mu[200:300] + 1
mu[650:800] <- mu[650:800] - 1
eps <- rnorm(J, sd=1/2)
y <- mu + eps
x <- sort(runif(length(y), max=length(y)))
w <- runif(J)
w[650:800] <- 0.001


# - - - - - - - - - - - - - - - - - - - - - - - - - -
# True and estimated signals
# - - - - - - - - - - - - - - - - - - - - - - - - - -
cnT <- RawCopyNumbers(mu, x, w=w)
print(cnT)

cn <- RawCopyNumbers(y, x, w=w)
print(cn)


# - - - - - - - - - - - - - - - - - - - - - - - - - -
# Extracting regions
# - - - - - - - - - - - - - - - - - - - - - - - - - -
cnR <- extractRegion(cn, region=c(100,700))
print(cnR)

regions <- data.frame(
  chromosome = c(  0,  0),
  start      = c(100,400),
  stop       = c(200,600)
)
cnR <- extractRegions(cn, regions=regions)
print(cnR)


# - - - - - - - - - - - - - - - - - - - - - - - - - -
# Operators
# - - - - - - - - - - - - - - - - - - - - - - - - - -
# Genomic positions are never included, i.e. they are kept.
cnD <- subtractBy(cn, cnT)
print(cnD)

# Subtract only fields, i.e. keep field 'w'.
cnD <- subtractBy(cn, cnT, fields="cn")


# - - - - - - - - - - - - - - - - - - - - - - - - - -
# Plotting
# - - - - - - - - - - - - - - - - - - - - - - - - - -
subplots(2, ncol=1)
plot(cn, ylim=c(-3,3), col="#aaaaaa")
points(cnT, col="red")

plot(cnD, ylim=c(-3,3), col="blue")

