library(dplyr)

#Download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "temp.zip")
unzip("temp.zip")

#Create dataframe
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#bring the date and times together in one variable
data$Date <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y%H:%M:%S")

#select the time frame
data <- filter(data, Date < "2007-02-03")
data <- filter(data, Date > "2007-02-01")
data[ ,3:8] <- lapply(data[ ,3:8], as.numeric)

#Make the plot
png("Plot3.png")
with(data, {
  plot(Date, Sub_metering_1,type = "o", pch = 26, xlab="",ylab = "Energy sub metering")
  lines(Date, Sub_metering_2,type = "o", pch = 26, col = "red")
  lines(Date, Sub_metering_3,type = "o", pch = 26, col = "blue")
})
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
            "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()
