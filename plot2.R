## Plot 2 - Showing Global Active Power over 2 days 

library(dplyr)
library(lubridate)

source("get_the_data.R")

## Create Plot 2 - defaults to creating a png called plot2.png
generatePlot2 <- function(toPng = TRUE) {
    hpc <- getTheData()
    
    ## Merging Date and Time columns together 
    hpc <- mutate(hpc, time_stamp = dmy_hms(paste(hpc$Date, hpc$Time)))
    
    ## Filter down the data set to only be between dates 2007-02-01 and 2007-02-02
    hpc <- filter(hpc, time_stamp >= ymd_hms("2007-02-01 00:00:00") & 
                      time_stamp <= ymd_hms("2007-02-02 23:59:59"))
    ## Adding a day column - may be not...
    plot(hpc$time_stamp, 
         hpc$Global_active_power,
         type = "l", 
         xlab = "", 
         ylab = "Global Active Power (kilowatts)")
    
    if (toPng){
        dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
        dev.off()
    }
}


