#-----------------------------------------------------------------------------
#THIS R SCRIPT GENERATES PLOT 3 AND SAVES TO FILE IN PNG FORMAT
#-----------------------------------------------------------------------------
## Set library and current working directory
library(sqldf)
setwd("C:/Users/catherine/projects/ExData_Plotting1")
## Read portion of data file from Date 1/2/2007 to 2/2/2007.
file="./household_power_consumption.txt"
pdata <- read.csv.sql(file, sql="select * from file where Date in ('1/2/2007',
         '2/2/2007')", sep=";", header=TRUE, stringsAsFactors=F, colClasses=
          c("character","character","numeric","numeric","numeric",
          "numeric","numeric","numeric","numeric"))
#------------------------------------------------------------------------------
# Plot 3 - Scatterplots of Energy sub metering vs DateTime
#------------------------------------------------------------------------------
## Remove incomplete observations
pdata <- pdata[complete.cases(pdata),]
## Combine Date and Time fields
pdata$Date <- as.Date(pdata$Date,"%d/%m/%Y")
pdata$DateTime <- paste(pdata$Date, pdata$Time)
pdata$DateTime <- as.POSIXct(pdata$DateTime)
## Sub_metering_1 plot
with(pdata, plot(DateTime, Sub_metering_1, type="l", ylim=c(0,38), xlab="",
                 ylab="Energy sub metering"))
## Sub_metering_2 plot
points(pdata$DateTime, pdata$Sub_metering_2, type="l", col="red")
## Sub_metering_3 plot
points(pdata$DateTime, pdata$Sub_metering_3, type="l", col="blue")
## Legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"))
#-----------------------------------------------------------------------------
# Save file in png format and close dev
#-----------------------------------------------------------------------------
dev.copy(png, "plot3.png", width=480, height=480)
dev.off()


