#install and load the package dplyr for data frame
install.packages("dplyr")
library(dplyr)
library(lubridate)

#load the household_power_consumption.txt from my working folder
#in case the file is not in order of year, month and day. 
#load the entire file first and then filter 2007-02-01 to 2007-02-02 subset

#load data
rawdata <- read.table("household_power_consumption.txt",header=T,sep=";",as.is = T)
str(rawdata)
head(rawdata)

testdata <- filter(rawdata,Date=="1/2/2007" | Date=="2/2/2007")
testdata
str(testdata)

#clean the data
testdata$RDate <- strptime(paste(testdata$Date,testdata$Time),"%e/%m/%Y %H:%M:%S")
testdata$Global_active_power <- as.numeric(gsub("\\?",NA,testdata$Global_active_power))
testdata$Global_reactive_power <- as.numeric(gsub("\\?",NA,testdata$Global_reactive_power))
testdata$Voltage <- as.numeric(gsub("\\?",NA,testdata$Voltage))
testdata$Global_intensity <- as.numeric(gsub("\\?",NA,testdata$Global_intensity))
testdata$Sub_metering_1 <- as.numeric(gsub("\\?",NA,testdata$Sub_metering_1))
testdata$Sub_metering_2 <- as.numeric(gsub("\\?",NA,testdata$Sub_metering_2))

#plot the data
par(mfrow=c(1,1))
plot(testdata$RDate,testdata$Global_active_power,type="l",xlab="",ylab="Global Active Power (killowatts)")

#save the png
dev.copy(width=480,height=480,png, file = "plot2.png")
dev.off()

