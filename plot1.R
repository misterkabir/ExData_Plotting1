## Download Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
dateDownloaded <- date()

## Read UCI Electricty Data Subset from Feb 1 2007 to Feb 2 2007 (Note: time and date format)
dt <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), header = T, sep = ";", na.strings = "?")
subdt <- dt[as.character(dt$Date) %in% c("1/2/2007", "2/2/2007"),]

## Format Date and Time
subdt$Date <- as.Date(as.character(subdt$Date), "%d/%m/%Y")
subdt <- within(subdt, posix <- paste(Date, Time, sep = ' '))
subdt$posix <- strptime(subdt$posix, "%Y-%m-%d %H:%M:%S")

## Tidy Data
myData <- data.frame(subdt[,10], subdt[,3], subdt[,4], subdt[,5], subdt[,6], subdt[,7], subdt[,8], subdt[,9])
names(myData) <- c("Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Create Plot 1
library(datasets)
par(mfcol = c(1,1))
hist(myData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# Copy to png device
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()