## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0

## Return a numeric vector of correlations

corr <- function(directory, threshold = 0) {
  id = 1:332
  result <- numeric()
  for (i in id) {
    filename <- paste(directory, "/", sprintf("%03d", i), ".csv", sep='')
    file <- read.table(filename, header = T, sep = ",", 
                       col.names = c("Date","sulfate","nitrate","ID"),
                       colClasses = c("Date","numeric","numeric","integer"))
    nobs <- sum(complete.cases(file))
    if (nobs<threshold | nobs==0) 
      next()
    cor <- cor(file$sulfate, file$nitrate, use = "complete.obs")
    result <- append(result, cor)
  }
  result
}