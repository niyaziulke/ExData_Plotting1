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

# Draw the plot to png.
png("plot1.png",width = 480, height = 480)
hist(extractedTable$Global_active_power,col = "red",xlab="Global Active Power (kilowatts)",main = "Global Active Power")
dev.off()