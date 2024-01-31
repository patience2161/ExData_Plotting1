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

#Create Plot 2
data$Global_active_power <- as.numeric(data$Global_active_power)
plot(data$Global_active_power, type = "l", xaxt="n",
     xlab = "", ylab = "Global Active Power (kilowatts")
axis(1, at = c(0, 1400, 2800), labels = c("Thr", "Fri", "Sat"))

# Save plot as .png file
png(file = "plot2.png", width = 480, height = 480)
plot(data$Global_active_power, type = "l", xaxt="n",
     xlab = "", ylab = "Global Active Power (kilowatts)")
axis(1, at = c(0, 1400, 2800), labels = c("Thr", "Fri", "Sat"))
dev.off()
