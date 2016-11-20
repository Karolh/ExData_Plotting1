## Plot 1 - Showing Global Active Power in a Histogram

library(dplyr)
library(lubridate)

source("get_the_data.R")

generatePlot1 <- function() {
    hpc <- getTheData()
    ## Convert the first column to dates
    hpc[,1] <- dmy(hpc$Date)
    
    ## Filter down the data set to only be between dates 2007-02-01 and 2007-02-02
    hpc <- filter(hpc, Date >= ymd(" 2007-02-01") & Date <= ymd("2007-02-02"))
    
    ## Start the plot
    ## Draw the histogram
    hist(hpc$Global_active_power, col = "red", main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
    
    ## Copy the histogram to png
    ## Create the png in current directory as per the requirement
    dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
    ## This outputs the date to the png file
    dev.off()
}