#set the working directory
setwd("~/R/Exploratory Analysis")     
# read in the first column(Date) of data
rawdata<-read.table(file="household_power_consumption.txt", sep=";",header=TRUE,colClasses=c(NA,"NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL"))
# find the index of the Dates(1/2/2007 and 2/2/2007)
rindex<-which(rawdata=="1/2/2007" | rawdata=="2/2/2007")
# read in the select data with the date range we need
selectdata<-read.table(file="household_power_consumption.txt", sep=";",header=TRUE)[rindex,]
# convert Date and Time 
selectdata$Date<-as.Date(selectdata$Date, "%d/%m/%Y")
selectdata$DateTime<-paste(selectdata$Date,selectdata$Time,sep=" ")
selectdata$DateTime<-strptime(selectdata$DateTime,"%Y-%m-%d %H:%M:%S") 

# convert the rest columns into numeric type
selectdata[,3:9]<-as.numeric(sapply(selectdata[,3:9],as.character))

#draw the line graph and save into png file
png("plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2),mar=c(5,4,4,2))
with(selectdata,{hist(selectdata[,3],col="red",breaks=12,xlab="Global Active Power(kilowatts)",main="Global Active Power")
                 
                 plot(selectdata$DateTime,selectdata$Voltage,type="l",xlab="datetime",ylab="Voltage") 
                 
                 with(selectdata, {plot(selectdata[,10],selectdata[,7],type="l",xlab="",ylab="Energy sub metering")
                 lines(selectdata[,10],selectdata[,8],col="red")
                 lines(selectdata[,10],selectdata[,9],col="blue")
                 legend("topright",lty=1,col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=1,bty="n")}) 
                 
                 plot(selectdata$DateTime,selectdata$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
                 })

dev.off()
