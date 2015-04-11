# Specialization : Data Science
# Course : 4 - Exploratory Data Analysis
# From April 6 to May 3
# Instructors : Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD
# Personal data:
# Name : Tabare Perez
# Email: tabare.perez@gmail.com
# City, Country : Montevideo, Uruguay
# 
# This is the project 01 script plot3.R - April 10 - 2015
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

# Save default plot window parameters and save to file:
par.defaults <- par(no.readonly=TRUE);
save(par.defaults, file="R.default.par.RData")

# If file doesn't exist then download: 
if (!file.exists(dataFile)){
  download.file(dataURL, destfile = dataFile)
}

# Unzip data file:
unzip(dataFile)

# Read data as a data frame:
data<- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors = F, na.strings= "?")

# Obtain the subset for processing:
data<- subset(data, (data$Date == "1/2/2007" | data$Date== "2/2/2007"))

# Use library "lubridate" to easy manipulate dates and times:
library(lubridate)

# Add a new column with date/time combination:
data$DateTime <- dmy_hms(paste(data$Date, data$Time))

# Generate plot3: Week days in Spanish. I do not know how to change that. Sorry!!
plot(data$DateTime, data$Sub_metering_1, type="l", ylab= "Energy sub metering", xlab="")
# Add plots and legend:
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

# Save plot to a png image:
dev.copy(png, "plot3.png")
dev.off()
