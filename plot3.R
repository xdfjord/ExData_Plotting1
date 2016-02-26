#install and load the package dplyr for data frame
install.packages("dplyr")
install.packages("tidyr")
library(dplyr)
library(lubridate)
library(tidyr)

#load the household_power_consumption.txt from my working folder
#in case the file is not in order of year, month and day. 
#load the entire file first and then filter 2007-02-01 to 2007-02-02 subset

#load data
rawdata <- read.table("household_power_consumption.txt",header=T,sep=";",as.is = T)
str(rawdata)
head(rawdata)

testdata <- filter(rawdata,Date=="1/2/2007" | Date=="2/2/2007")

#clean the data
testdata$Global_active_power <- as.numeric(gsub("\\?",NA,testdata$Global_active_power))
testdata$Global_reactive_power <- as.numeric(gsub("\\?",NA,testdata$Global_reactive_power))
testdata$Voltage <- as.numeric(gsub("\\?",NA,testdata$Voltage))
testdata$Global_intensity <- as.numeric(gsub("\\?",NA,testdata$Global_intensity))
testdata$Sub_metering_1 <- as.numeric(gsub("\\?",NA,testdata$Sub_metering_1))
testdata$Sub_metering_2 <- as.numeric(gsub("\\?",NA,testdata$Sub_metering_2))

#merge the columns of Sub_metering 1 to 3
newdata <- gather(testdata,"Sub_metering_Type","Sub_metering_Number",7:9)

newdata$RDate <- strptime(paste(newdata$Date,newdata$Time),"%e/%m/%Y %H:%M:%S")
str(newdata)

#plot the data
par(mfrow=c(1,1))
plot(newdata$RDate,newdata$Sub_metering_Number,type="n",xlab="",ylab="Energr sub metering")
with(subset(newdata,Sub_metering_Type=="Sub_metering_1"),lines(RDate,Sub_metering_Number,col="black"))
with(subset(newdata,Sub_metering_Type=="Sub_metering_2"),lines(RDate,Sub_metering_Number,col="red"))
with(subset(newdata,Sub_metering_Type=="Sub_metering_3"),lines(RDate,Sub_metering_Number,col="blue"))
legend("topright", pch = 151, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


#save the png
dev.copy(width=480,height=480,png, file = "plot3.png")
dev.off()




