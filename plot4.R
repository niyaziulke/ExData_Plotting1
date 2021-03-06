library(sqldf)

# Url of data
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataZip <- "data.zip"
dataFile <-"household_power_consumption.txt"
# If it is needed, download and unzip the file.
if(!file.exists(dataFile)){
  download.file(url=dataUrl,destfile = dataZip)
  unzip(dataZip)
}

# Read only relevant data.
extractedTable <- read.csv.sql(file=dataFile,"SELECT * FROM file WHERE Date in ('1/2/2007','2/2/2007') ",sep=";" )
closeAllConnections()

# Concatenate date and time, then evaluate it.
dateTime <- paste(extractedTable[,1] ,extractedTable[,2])
dateTime <- strptime(dateTime , format="%d/%m/%Y %X")

# Draw the plot to png.

png("plot4.png",height = 480,width = 480,)

# Adjust the environment.
par(mfrow=c(2,2))

plot(dateTime,extractedTable$Global_active_power,type="l",ylab="Global Active Power",xlab="")
plot(dateTime,extractedTable$Voltage,type="l",ylab="Voltage",xlab="datatime")
plot(dateTime,extractedTable$Sub_metering_1,type = "n",ylab="Energy sub metering" ,xlab="") 
lines(dateTime,extractedTable$Sub_metering_1,type = "l",col="black")
lines(dateTime,extractedTable$Sub_metering_2,type="l", col="red")
lines(dateTime,extractedTable$Sub_metering_3,type="l", col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col = c("black","red","blue"),bty="n",cex=0.75)
plot(dateTime,extractedTable$Global_reactive_power,type="l",xlab="",ylab="Global_reactive_power")
dev.off()