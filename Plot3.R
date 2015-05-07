### Plot3.R

## Set raw data .zip file location 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "household_power_consumption.txt"

## Create dataframe from raw data .zip file
temp <- tempfile()
download.file(fileUrl,temp)
data <- read.table(unz(temp, fileName),header=TRUE,sep=";",na.strings="?",check.names=TRUE)
unlink(temp)

## Parse and combine dates and times and filter
data$Date <- as.POSIXct(paste(data$Date," ",data$Time), format="%d/%m/%Y %H:%M:%S")
data <- subset(data, Date >= "2007-02-01" & Date < "2007-02-03" ,select=-c(Time))

## Plot and save graph
png(filename="plot3.png", width=480, height=480, units="px")
with(data, plot(Date, Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Date, Sub_metering_1, col = "black", type="l"))
with(data, lines(Date, Sub_metering_2, col = "red", type="l"))
with(data, lines(Date, Sub_metering_3, col = "blue", type="l"))
legend("topright", lty = c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()