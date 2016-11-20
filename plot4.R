## Plot 4 - Grid of 4 Graphs
## 2 of the Graphs were already generated so reusing those - plot2 and plot3
## For the other 2 - the 1st is voltage over time 
## and 2nd is Global Reactive Power over time 

library(dplyr)
library(tidyr)
library(lubridate)

source("get_the_data.R")
source("plot2.R")
source("plot3.R")

generateDateTimeVoltagePlot <- function(hpc) {
    ## And plot it
    plot(hpc$time_stamp, 
         hpc$Voltage,
         type = "l", 
         xlab = "datetime", 
         ylab = "Voltage")
}

generateDateTimeGlobalReactivePower <- function(hpc){

    plot(hpc$time_stamp, 
         hpc$Global_reactive_power,
         type = "l", 
         xlab = "datetime", 
         ylab = "Global_reactive_power")
}

generatePlot4 <- function(toPng = TRUE) {
    
    ## First get the data
    hpc <- getTheData()
    
    ## Merging Date and Time columns together 
    hpc <- mutate(hpc, time_stamp = dmy_hms(paste(hpc$Date, hpc$Time)))
    
    ## Filter down the data set to only be between dates 2007-02-01 and 2007-02-02
    hpc <- filter(hpc, time_stamp >= ymd_hms("2007-02-01 00:00:00") & 
                      time_stamp <= ymd_hms("2007-02-02 23:59:59"))
    
    
    ## First set up the layout
    par(mfcol = c(2,2))
    ## Generate the plot but not to png
    generatePlot2(FALSE)
    ## Don't generate a png file and no border around the legend
    generatePlot3(FALSE, "n")
    
    ##
    generateDateTimeVoltagePlot(hpc)
    
    ## 
    generateDateTimeGlobalReactivePower(hpc)
    
    if (toPng){
        dev.copy(png, file = "plot4.png")
        dev.off()
    }
    
    
}