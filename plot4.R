#Data Science Specialization - Exploratory Data Analysis - Assignment 1 - Plot 4
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


### plot 4
plot_colors <- c("black", "red", "blue")
plot_cols <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
png(filename="plot4.png", height=480, width=480, bg="white")

####### 4 graps arranged in 2 rows and 2 cols
par(mfrow=c(2,2))

###add graph 1 of 4
plot(filtData$DateTime, filtData$Global_active_power, type="l"
     , xlab=""
     , ylab="Global Active Power"
)

###add graph 2 of 4
plot( filtData$DateTime, filtData$Voltage, type="l"
      , xlab = "datetime"
      , ylab = "Voltage"
)

###add graph 3 of 4  
plot( filtData$DateTime, filtData$Sub_metering_1, type="l"
      , col = plot_colors[1]
      , xlab=""
      , ylab="Energy sub metering"
)
lines( filtData$DateTime, filtData$Sub_metering_2, type="l", col = plot_colors[2] )
lines( filtData$DateTime, filtData$Sub_metering_3, type="l", col = plot_colors[3] )
legend( "topright"
        , plot_cols
        , cex=0.8
        , col=plot_colors 
        , lwd=1
        , bg="transparent"
)

###add graph 4 of 4
plot( filtData$DateTime, filtData$Global_reactive_power, type="l"
      , xlab = "datetime"
      , ylab = "Global_reactive_power"
)

dev.off()



## end of plot4.R file ---------------------------------------------------------------------