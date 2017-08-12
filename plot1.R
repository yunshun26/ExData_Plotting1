#------------------------------------------------------------------------------
# THIS R SCRIPT GENERATES PLOT 1 AND SAVES TO FILE IN PNG FORMAT
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
# Plot 1: Histogram
#------------------------------------------------------------------------------
## Remove incomplete observations
pdata <- pdata[complete.cases(pdata),]
#mar_defaults <- par(mar=c(5.1, 4.1, 4.1, 2))
par(mar=c(5.1, 4.1, 2.1, 2))
hist(pdata$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
##Save file in png format and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

