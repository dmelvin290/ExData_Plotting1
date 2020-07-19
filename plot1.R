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
png("plot1.png")
hist(data$Global_active_power, col = "red", xlab = 
       "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

