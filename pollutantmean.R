## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)

pollutantmean <- function(directory, pollutant, id = 1:332) {
  if (!any(c("sulfate", "nitrate")==pollutant)) stop("Pollutant not valid")
  
  df <- data.frame()
  for (i in id) {
    filename <- paste(directory, "/", sprintf("%03d", i), ".csv", sep='')
    file <- read.table(filename, header = T, sep = ",", 
                       col.names = c("Date","sulfate","nitrate","ID"),
                       colClasses = c("Date","numeric","numeric","integer"))
    df <- rbind(df, file)
  }
  # extract the row
  data <- df[[pollutant]]
  # return the mean
  mean(data, na.rm = T)
}
