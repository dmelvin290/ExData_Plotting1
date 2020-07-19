library(lubridate)
library(dplyr)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data$Date <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y%H:%M:%S")
#data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#data$Time <- strptime(data$Time, format = "%H:%M:%S")
data <- filter(data, Date < "2007-02-03")
data <- filter(data, Date > "2007-02-01")
data[ ,3:8] <- lapply(data[ ,3:8], as.numeric)
par(mfcol = c(2,2))
plot(data$Date, data$Global_active_power, type = "o", pch = 26, xlab = "", 
     ylab = "Global Active Power (kilowatts)")
with(data, {
  plot(Date, Sub_metering_1,type = "o", pch = 26, ylab = "Energy sub metering")
  lines(Date, Sub_metering_2,type = "o", pch = 26, col = "red")
  lines(Date, Sub_metering_3,type = "o", pch = 26, col = "blue")
})
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
            "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
plot(data$Date, data$Voltage, type = "o", pch = 26, xlab = "datetime", 
     ylab = "Voltage")
plot(data$Date, data$Global_reactive_power, type = "o", pch = 26, xlab = "datetime", 
     ylab = "Global_reactive_power")
