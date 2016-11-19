## Plot 1 - Showing Global Active Power in a Histogram

library(dplyr)
library(lubridate)


## Get the data first
if (!dir.exists("data")){
    ## Create the data directory
    dir.create("data")
}

if (!file.exists("data/household_power_consumption.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile = "data/household_power_consumption.zip", method = "curl")
}

if (!dir.exists("data/hpc")){
    ## Extract the data
    unzip("data/household_power_consumption.zip", exdir = "data/hpc")
}

# hpc <- read.csv("data/hpc/household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
hpc <- read.csv("data/hpc/household_power_consumption.txt", sep = ";", 
                stringsAsFactors = FALSE, as.is = TRUE, na.strings = c('?', 'NA', ""))

## Convert the first column to dates
hpc[,1] <- dmy(hpc$Date)

## Filter down the data set to only be between dates 2007-02-01 and 2007-02-02
hpc <- filter(hpc, Date >= ymd(" 2007-02-01") & Date <= ymd("2007-02-02"))

## Start the plot
## Create the png in current directory as per the requirement
png("plot1.png", width = 480, height = 480, units = "px")
## Draw the histogram
hist(hpc$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
## This outputs the date to the png file
dev.off()