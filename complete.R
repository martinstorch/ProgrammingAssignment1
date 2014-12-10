## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return a data frame of the form:
## id nobs
## 1  117
## 2  1041
## ...
## where 'id' is the monitor ID number and 'nobs' is the
## number of complete cases
complete <- function(directory, id = 1:332) {
  df <- data.frame()
  for (i in id) {
    filename <- paste(directory, "/", sprintf("%03d", i), ".csv", sep='')
    file <- read.table(filename, header = T, sep = ",", 
                       col.names = c("Date","sulfate","nitrate","ID"),
                       colClasses = c("Date","numeric","numeric","integer"))
    nobs <- sum(complete.cases(file))
    df <- rbind(df, data.frame(id=i, nobs=nobs))
  }
  df
}