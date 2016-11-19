## The script is used just to get the data and is used by the plot scripts

getTheData <- function() {
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
    
}