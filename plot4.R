#------------------------------------------------------------------------------
# THIS R SCRIPT GENERATES PLOT 4 AND SAVES TO FILE IN PNG FORMAT
#------------------------------------------------------------------------------
# Set library and current working directory
library(sqldf)
setwd("C:/Users/catherine/projects/ExData_Plotting1")
#------------------------------------------------------------------------------
# Read section of file from date 1/2/2007 to 2/2/2007
#------------------------------------------------------------------------------
file <- "./household_power_consumption.txt"
pdata <- read.csv.sql(file, sql="select * from file where Date in 
                      ('1/2/2007','2/2/2007')", sep=";", header=TRUE,
                      stringsAsFactors=F, colClasses=c("character","character",
                      "numeric","numeric","numeric","numeric","numeric",
                      "numeric","numeric"))
#------------------------------------------------------------------------------
# Prep data for plotting and parameter settings 
#------------------------------------------------------------------------------
## Remove incomplete observations
pdata <- pdata[complete.cases(pdata),]
## Specify the format of Date field
pdata$Date <- as.Date(pdata$Date, "%d/%m/%Y")
## Combine Date and Time to create DateTime field as POSIXct
pdata$DateTime <- paste(pdata$Date, pdata$Time)
pdata$DateTime <- as.POSIXct(pdata$DateTime)
## Set Margin
#mar_defaults <- par(mar=c(5.1, 4.1, 4.1, 2)) 
#mai_defaults <-par(mai=c(0.8466, 0.6806, 0.0830, 0.3320)
#par(mar=c(5.1, 4.1, 0.5, 2),mai=c(0.75, 0.68, 0.1, 0.2))
par(mar=c(5, 3.9, 0.6, 1.1))
par(mfrow=c(2,2))
#------------------------------------------------------------------------------
# Plot 1 to Plot 4
#------------------------------------------------------------------------------
## Plot 1 - plot of Global Active Power vs DateTime
plot(pdata$DateTime,pdata$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")
## Plot 2 - Plot of Voltage vs DateTime
plot(pdata$DateTime, pdata$Voltage, type="l", xlab="datetime", ylab="Voltage")
## Plot 3 - plot of Energy sub metering vs DataTime
with(pdata, plot(DateTime, Sub_metering_1, type="l", ylim=c(0,38), xlab="",
                 ylab="Energy sub metering"))
points(pdata$DateTime, pdata$Sub_metering_2, type="l", col="red")
points(pdata$DateTime, pdata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"), cex=0.75, bty="n")
## Plot 4 - scatterplot of Global_reactive_power vs DateTime
plot(pdata$DateTime,pdata$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")
#-----------------------------------------------------------------------------
# Save in png format and close device
#----------------------------------------------------------------------------
dev.copy(png, "plot4.png", width=480, height=480)
dev.off()