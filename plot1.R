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

