#install and load the package dplyr for data frame
install.packages("dplyr")
library(dplyr)
library(lubridate)

#load the household_power_consumption.txt from my working folder
#in case the file is not in order of year, month and day. load the entire file first and then filter 2007-02-01 to 2007-02-02 subset
#test first
rawdata <- read.table("household_power_consumption.txt",header=T,sep=";",nrow=10)
str(rawdata)

#load data
rawdata <- read.table("household_power_consumption.txt",header=T,sep=";",as.is = T)
str(rawdata)
head(rawdata)

testdata <- filter(rawdata,Date=="1/2/2007" | Date=="2/2/2007")
testdata
str(testdata)

#clean the data
unique(testdata$Date)
unique(testdata$Time)
testdata$testDate <- as.Date(strptime(paste(testdata$Date,testdata$Time),"%e/%m/%Y %H:%M:%S"))

unique(testdata$Global_active_power)
grep("\\?",testdata$Global_active_power)
testdata$Global_active_power <- as.numeric(gsub("\\?",NA,testdata$Global_active_power))

unique(testdata$Global_reactive_power)
grep("\\?",testdata$Global_reactive_power)
testdata$Global_reactive_power <- as.numeric(gsub("\\?",NA,testdata$Global_reactive_power))

unique(testdata$Voltage)
grep("\\?",testdata$Voltage)
testdata$Voltage <- as.numeric(gsub("\\?",NA,testdata$Voltage))

unique(testdata$Global_intensity)
grep("\\?",testdata$Global_intensity)
testdata$Global_intensity <- as.numeric(gsub("\\?",NA,testdata$Global_intensity))

unique(testdata$Sub_metering_1)
grep("\\?",testdata$Sub_metering_1)
testdata$Sub_metering_1 <- as.numeric(gsub("\\?",NA,testdata$Sub_metering_1))

unique(testdata$Sub_metering_2)
grep("\\?",testdata$Sub_metering_2)
testdata$Sub_metering_2 <- as.numeric(gsub("\\?",NA,testdata$Sub_metering_2))

#plot the data
par(mfrow=c(1,1))
hist(testdata$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")

#save the png
dev.copy(width=480,height=480,png, file = "plot1.png")
dev.off()

