## Plot 3 - Energy Sub Metering over Time

library(dplyr)
library(tidyr)
library(lubridate)

source("get_the_data.R")

## Create Plot 3 - defaults to creating a png file called plot3.png
generatePlot3 <- function(toPng = TRUE, legendBorder = "o") {
    hpc <- getTheData()
    
    ## Merging Date and Time columns together 
    hpc <- mutate(hpc, time_stamp = dmy_hms(paste(hpc$Date, hpc$Time)))
    
    ## Filter down the data set to only be between dates 2007-02-01 and 2007-02-02
    hpc <- filter(hpc, time_stamp >= ymd_hms("2007-02-01 00:00:00") & 
                      time_stamp <= ymd_hms("2007-02-02 23:59:59"))
    
    ## Combining the metering data into 2 columns - metering & watts
    combined_hpc <- gather(hpc, metering, watts, -c((1:6), 10), na.rm = TRUE)
    
    ## Subset the data
    sub_m1 <- subset(combined_hpc, metering == "Sub_metering_1")
    sub_m2 <- subset(combined_hpc, metering == "Sub_metering_2")
    sub_m3 <- subset(combined_hpc, metering == "Sub_metering_3")

    ## Start the plotting
    plot(combined_hpc$time_stamp, combined_hpc$watts, type = "n", xlab = "", 
         ylab = "Energy sub metering")
    
    ## Add the points for each subset of data
    points(sub_m1$time_stamp, sub_m1$watts, col = "black", type = "l")
    points(sub_m2$time_stamp, sub_m2$watts, col = "red", type = "l")
    points(sub_m3$time_stamp, sub_m3$watts, col = "blue", type = "l")
    
    ## Apply the legend
    legend("topright", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty = 1,
           bty = legendBorder)
    
    if (toPng){
        ## Finally create the png file
        dev.copy(png, file = "plot3.png")
        dev.off()
    }
}