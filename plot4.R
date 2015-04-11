# Specialization : Data Science
# Course : 4 - Exploratory Data Analysis
# From April 6 to May 3
# Instructors : Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD
# Personal data:
# Name : Tabare Perez
# Email: tabare.perez@gmail.com
# City, Country : Montevideo, Uruguay
# 
# This is the project 01 script plot4.R - April 10 - 2015
# 
# Dataset: Electric power consumption
# Data Source : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 
#
# -----------------------------------------------------------------------------------------------------
#

# Read data file and unzip in the current directory:
dataURL  <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFile <- "household_power_consumption.zip"
dataDir  <- "project01"

# If directory doesn't exist then create:
if (!file.exists(dataDir))
{
  dir.create(dataDir)
}

# Set project working directory:
setwd(paste("./", dataDir, sep=""))

# Save default plot window parameters and save to file.
par.defaults <- par(no.readonly=TRUE);
save(par.defaults, file="R.default.par.RData")

# Set plot window parameters:
par(mfrow=c(2,2),width=480, height= 480)

# If file doesn't exist then download: 
if (!file.exists(dataFile))
{
  download.file(dataURL, destfile = dataFile)
}

# Unzip data file:
unzip(dataFile)

# Read data as a data frame:
data <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors = F, na.strings= "?")

# Obtain the subset for processing:
data <- subset(data, (data$Date == "1/2/2007" | data$Date== "2/2/2007"))

# Use library "lubridate" to easy manipulate dates and times:
library(lubridate)

# Add a new column with date/time combination:
data$DateTime <- dmy_hms(paste(data$Date, data$Time))

# Generate the graphs:

# Top left plot:
plot(data$DateTime, data$Global_active_power, type= "l", lwd=1, ylab= "Global Active Power (kilowatts)", xlab="") 
# Top right plot:
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")   
# Bottom left plot (add lines and legends):
plot(data$DateTime, data$Sub_metering_1, type="l", ylab= "Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", col=c("black", "red", "blue")) 
# Bottom right plot:
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Save plot to a png image:
dev.copy(png, "plot4.png")
dev.off()

# Restore plot window parameters
load("R.default.par.RData")
par(par.defaults)
