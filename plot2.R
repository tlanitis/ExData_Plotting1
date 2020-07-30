##Load libraries
library(dplyr)
library(lubridate)

## Download file and create file
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp<-tempfile() # create a temporary file
download.file(fileUrl,temp) #download file into temporary location
fullData<-read.table(unz(temp,"household_power_consumption.txt"),sep=";",header=TRUE)

## Filter data based on date and change class where relevant
fullData$DateForm<-dmy(fullData$Date) #create new variable for date in date format
finData<-filter(fullData, DateForm<="2007-02-02" & DateForm>="2007-02-01")
finData$Global_active_power<-as.numeric(finData$Global_active_power)
finData$DateTime<-dmy_hms(paste(finData$Date,finData$Time,sep=" "))

##Create plot 1
png("plot1.png",width=480,height=480)
hist(finData$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)") # Plot 1
dev.off()

##Create plot 2
png("plot2.png",width=480,height=480)
plot(finData$DateTime,finData$Global_active_power,xlab="",ylab="Global Active power (kilowatts)", type="l")
dev.off()

##Create plot 3
png("plot3.png",width=480,height=480)
plot(finData$DateTime,finData$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
points(finData$DateTime,finData$Sub_metering_2,type="l",col="red")
points(finData$DateTime,finData$Sub_metering_3,type="l",col="blue")
dev.off()


##Create plot 4
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2),mar=c(4,4,2,1))
plot(finData$DateTime,finData$Global_active_power,xlab="",ylab="Global Active power", type="l")
plot(finData$DateTime,finData$Voltage,type="l",ylab="Voltage",xlab="datetime")
plot(finData$DateTime,finData$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
points(finData$DateTime,finData$Sub_metering_2,type="l",col="red")
points(finData$DateTime,finData$Sub_metering_3,type="l",col="blue")
plot(finData$DateTime,finData$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()
