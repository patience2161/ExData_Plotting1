library(lubridate)

# Estimate memory of data in MB
round(nrow(
  read.csv2("household_power_consumption.txt", 
            header = TRUE, sep = ";"))*ncol(
              read.csv2("household_power_consumption.txt", 
                        header = TRUE, sep = ";"))*8/2^{20},2)
# Estimate memory of data in GB
round(nrow(
  read.csv2("household_power_consumption.txt", 
            header = TRUE, sep = ";"))*ncol(
              read.csv2("household_power_consumption.txt", 
                        header = TRUE, sep = ";"))*8/2^{20}/1024, 2)

# Load data
data <- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";")
# Subset data from February 1 to February 2
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Convert Date column to date class
data$Date <- dmy(data$Date)

# Convert Time column to time class
data$Time <- strptime(data$Time, "%H:%M:%S")
data$Time <- format(data$Time, "%H:%M:%S")
data$DT <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

#turn on device to save plot 4 as a .png file
png(file = "plot4.png", width = 480, height = 480)

#create a grid for the plots (2 rows, 2 plots in each row)
par(mfrow = c(2, 2))
#top left plot
plot(data$Global_active_power, type = "l", xaxt="n",
     xlab = "", ylab = "Global Active Power")
axis(1, at = c(0, 1400, 2800), labels = c("Thr", "Fri", "Sat"))

#top right plot
plot(data$Voltage, type = "l", xaxt="n",
     xlab = "datetime", ylab = "Voltage")
axis(1, at = c(0, 1400, 2800), labels = c("Thr", "Fri", "Sat"))

#bottom left plot
plot(data$Sub_metering_1, type = "l", xaxt="n", xlab = "",
     ylab = "Energy sub metering")
axis(1, at = c(0, 1435, 2870), labels = c("Thr", "Fri", "Sat"))
lines(data$Sub_metering_2, type = "l", xaxt="n", col = "red")
lines(data$Sub_metering_3, type = "l", xaxt="n", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), lty = 1, bty="n")

#bottom right plot
plot(data$Global_reactive_power, type = "l", xaxt="n",
     xlab = "datetime", ylab = "Global_reactive_power")
axis(1, at = c(0, 1400, 2800), labels = c("Thr", "Fri", "Sat"))

#turn device off
dev.off()
