#Data Science Specialization - Exploratory Data Analysis - Assignment 1 - Plot 1
#Author: Simone - 10/Jan/2015

#Dataset: Electric power consumption [20Mb]
#Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

# set local directory    
setwd("D:/Coursera/Johns Hopkins University/04.Exploratory Data Analysis/Proj01")

#install.packages("lubridate")
#install.packages("sqldf")
library(lubridate)
library(sqldf)

### read the file filtering out the dates
fileName <-"household_power_consumption.txt"

filtData <- read.csv.sql(  fileName
                        , sql = "select * from file where Date in ('1/2/2007','2/2/2007')"
                        , sep = ';', header = TRUE
                        ) 

filtData$DateTime <- dmy_hms(paste(filtData$Date, filtData$Time))
filtData$Date <- as.Date(filtData$Date, format = "%d/%m/%Y" )

## plot 1: generate the histogram into a png file 
png("plot1.png", height=480, width=480, bg="white")

hist(filtData$Global_active_power, col = "red", main = "Global Active Power" 
     , xlab = "Global Active Power (kilowatts)")

dev.off()

## end of plot1.R file ---------------------------------------------------------------------
