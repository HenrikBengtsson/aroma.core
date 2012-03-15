library("aroma.core")

stateFcn <- function(data, ...) {
  if (!is.element("x", colnames(data))) {
    throw("Cannot infer 'state'; data column 'x' is missing: ",
          hpaste(colnames(data)))
  }
  x <- data$x
  states <- rep("neutral", time=length(x))
  states[200 <=x & x <= 300] <- "loss"
  states[650 <=x & x <= 800] <- "gain"
  states
}

# Number of loci
J <- 1000

eps <- rnorm(J, sd=1/2)
mu <- double(J)
x <- 1:J

levels <- c("neutral"=0, "loss"=-1, "gain"=+1)

cn <- RichDataFrame(eps, x=x)

# Add "on the fly" column 'state'
cn$state <- stateFcn

# Add 'y'
cn$y <- 0.8*levels[cn$state] + cn$eps

print(head(cn))

cn <- setColumnNamesMap(cn, y="TCN");

print(head(cn))

cat("y:\n")
str(cn$y)

cat("TCN:\n")
str(cn$TCN)

cn$y <- 0
print(head(cn))

cn$TCN <- 0.8*levels[cn$state] + cn$eps
print(head(cn))


# Subsetting "before" or "after" as.data.frame()
rows <- c(1,1,2)
data <- as.data.frame(cn)
dataSa <- data[rows,]

cnSb <- cn[rows,]
dataSb <- as.data.frame(cnSb)

# Sanity check
stopifnot(all.equal(dataSb, dataSa))

