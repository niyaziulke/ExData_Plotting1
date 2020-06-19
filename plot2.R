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

png("plot2.png",width = 480, height = 480)
plot(dateTime,extractedTable$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()