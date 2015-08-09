#set the working directory
setwd("~/R/Exploratory Analysis")     
# read in the first column(Date) of data
rawdata<-read.table(file="household_power_consumption.txt", sep=";",header=TRUE,colClasses=c(NA,"NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL"))
# find the index of  the Dates(1/2/2007 and 2/2/2007)
rindex<-which(rawdata=="1/2/2007" | rawdata=="2/2/2007")
# read in the select data with the date range we want 
selectdata<-read.table(file="household_power_consumption.txt", sep=";",header=TRUE)[rindex,]
# convert Date and Time 
selectdata$Date<-as.Date(selectdata$Date, "%d/%m/%Y")
selectdata$DateTime<-paste(selectdata$Date,selectdata$Time,sep=" ")
selectdata$DateTime<-strptime(selectdata$DateTime,"%Y-%m-%d %H:%M:%S") 

# convert the rest columns into numeric type
selectdata[,3:9]<-as.numeric(sapply(selectdata[,3:9],as.character)) 

# draw the histogram and save into png file.
png("plot1.png", width = 480, height = 480, units = "px")
hist(selectdata[,3],col="red",breaks=12,xlab="Global Active Power(kilowatts)",main="Global Active Power")
dev.off()