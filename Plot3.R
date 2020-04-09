#Exploratory Data Analysis, Course Project No.1
#Plot No.3

#load package libraries
library(dplyr)

#download data
if(!file.exists("./DataSets")){dir.create("./DataSets")}
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL,destfile="./DataSets/Data.zip", method="curl")

#Unzip Files
unzip(zipfile="./DataSets/Data.zip",exdir="./DataSets")

#View list of the file(s)
DataFiles <-list.files("./DataSets", recursive=TRUE)
DataFiles

#We will use the "household_power_consumption.txt" file
hpsdatafile <- file.path("./DataSets", "household_power_consumption.txt")
hpsdata <- read.table(hpsdatafile, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec =".")
hpsdata <- tbl_df(hpsdata) 
hpsdata

## Create column in table with date and time merged together
TimeDate <- strptime(paste(hpsdata$Date, hpsdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
hpsdata <- cbind(hpsdata, TimeDate)
hpsdata

#Change class of each column into the correct class
hpsdata$Date <- as.Date(hpsdata$Date, format="%d/%m/%Y")
hpsdata$Time <- format(hpsdata$Time, format="%H:%M:%S")
hpsdata$Global_active_power <- as.numeric(hpsdata$Global_active_power)
hpsdata$Global_reactive_power <- as.numeric(hpsdata$Global_reactive_power)
hpsdata$Voltage <- as.numeric(hpsdata$Voltage)
hpsdata$Global_intensity <- as.numeric(hpsdata$Global_intensity)
hpsdata$Sub_metering_1 <- as.numeric(hpsdata$Sub_metering_1)
hpsdata$Sub_metering_2 <- as.numeric(hpsdata$Sub_metering_2)
hpsdata$Sub_metering_3 <- as.numeric(hpsdata$Sub_metering_3)
hpsdata

## subset data from 2007-02-01 and 2007-02-02
hpsdatasubset <- subset(hpsdata, Date == "2007-02-01" | Date =="2007-02-02")

#Plot
#Plot on computer screen to confirm plot is as desired
with(hpsdatasubset, 
     plot(TimeDate, Sub_metering_1, type = "l", ylab = "Energy sub metering",
          xlab = ""))
lines(hpsdatasubset$TimeDate, hpsdatasubset$Sub_metering_2, type = "l", col = "red")
lines(hpsdatasubset$TimeDate, hpsdatasubset$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2, col = c("black", "red", "blue"))

#Create and plot on PNG file
png(filename = "plot3.png", height = 480, width = 480)
with(hpsdatasubset, 
     plot(TimeDate, Sub_metering_1, type = "l", ylab = "Energy sub metering",
          xlab = ""))
lines(hpsdatasubset$TimeDate, hpsdatasubset$Sub_metering_2, type = "l", col = "red")
lines(hpsdatasubset$TimeDate, hpsdatasubset$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2, col = c("black", "red", "blue"))
dev.off()
