#----------------------------------------------------------------
# THIS R SCRIPT GENERATES PLOT 2 AND SAVES TO FILE IN PNG FORMAT
#----------------------------------------------------------------
# Set library and path
library(sqldf)
setwd("C:/Users/catherine/projects/ExData_Plotting1")
#------------------------------------------------------
# Read section of file from date 1/2/2007 to 2/2/2007
#------------------------------------------------------
file <- "./household_power_consumption.txt"
pdata <- read.csv.sql(file, sql="select * from file where Date in 
                      ('1/2/2007','2/2/2007')", sep=";", header=TRUE,
                      stringsAsFactors=F, colClasses=c("character","character",
                      "numeric","numeric","numeric","numeric","numeric",
                      "numeric","numeric"))
#---------------------------------------------------------
# Plot 2 - Scatterplot of Global_active_power vs DateTime
#---------------------------------------------------------
## Remove incomplete observations
pdata <- pdata[complete.cases(pdata),]
## Specify the format of Date field
pdata$Date <- as.Date(pdata$Date, "%d/%m/%Y")
## Combine Date and Time to create DateTime field as POSIXct
pdata$DateTime <- paste(pdata$Date, pdata$Time)
pdata$DateTime <- as.POSIXct(pdata$DateTime)
## Scatterplot
plot(pdata$DateTime,pdata$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
#--------------------------------------------------------
# Save file and close device
#--------------------------------------------------------
dev.copy(png, "plot2.png",width=480, height=480)
dev.off()
