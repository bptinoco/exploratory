## Plot One
## Brendan P Tinoco

## remove all the things
  rm(list = ls())

## load dplyr
  library(dplyr)
  
## download the tasty data
  url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = url,
                  destfile = "exdata_plotting1.zip"); time.downloaded = Sys.time()
  
## load the data into R
  classes = c(rep("character", 2), rep("numeric", 7))
    data.1 = read.table(file = "household_power_consumption.txt",
                      sep = ";", header = TRUE)

## loop to make the variables numeric
  for(i in 3:dim(data.1)[2]) {
    data.1[,i] = as.numeric(data.1[,i])
  }

## convert to date
  data.1$Date = as.Date(data.1$X.Date,
                        format = "%d/%m/%Y")
            
## paste the first two columns together to make a date time variable    
  data.1$date.time.char = paste(data.1[,1], data.1[,2])
    
## create the date time list
  date.time = strptime(data.1$date.time,
                       format = "%d/%m/%Y %H:%M:%S")
  
## add it to the data frame
  date.time = as.POSIXct(date.time)
  data.1 = cbind(data.1, date.time)
  rm(date.time)
  
## subset the data to only 2007-02-01 and 2007-02-02
  small = data.1 %>%
    filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## remove the massive data
  rm(data.1)
  
## now create plot one
    hist(small$Global_active_power,
        main = "Global Active Power",
        col = "red",
        xlab = "Global Active Power (kilowatts)")
    
    dev.copy(png, file = "plot1.png")
    dev.off()
    