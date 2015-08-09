# Generates "plot4.png".

# Reading the full data.

fulldata <- read.table("./household_power_consumption.txt", 
                       header = TRUE, sep = ";", na.strings = "?", nrows = 2075259, 
                       colClasses = c("character","character",rep("numeric",7)))

# Subsetting the data.

data <- fulldata[(fulldata$Date == "1/2/2007" | fulldata$Date == "2/2/2007"), ]

# Combining dates and times in the data to generate an array of date_time strings.

date_time_str <- paste(data$Date, data$Time)

# Converting date_time strings to date_time objects of POSIXlt class.

date_time <- strptime(date_time_str, "%d/%m/%Y %H:%M:%S")

# Setting the origin of time.

zero_date_time <- date_time[1]

# x_data: the x coordinates of the data to be plotted 
#(the time difference between each date_time and zero_date_time in units of hours). 

x_data <- as.numeric(difftime(date_time, zero_date_time, units = "hours"))

# Generating the plots.

png("plot4.png", width = 480, height = 480)

# creating four panels and setting the margins.

par(mfrow = c(2,2), mar = c(5,5,1,1))

# Top-left panel:

plot(x_data, data$Global_active_power, type = "l", xaxt="n", xlab = "", ylab = "Global Active Power")

axis(side = 1L, at = c(0, 24, 48), labels = c("Thu", "Fri", "Sat"))

# Top-right panel:

plot(x_data, data$Voltage, type = "l", xaxt="n", xlab = "datetime", ylab = "Voltage")

axis(side = 1L, at = c(0, 24, 48), labels = c("Thu", "Fri", "Sat"))

# Bottom-left panel:

plot(x_data, data$Sub_metering_1, type = "l", xaxt="n", xlab = "", ylab = "Energy sub metering")

lines(x_data, data$Sub_metering_2, col = "red")

lines(x_data, data$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1,
       col = c("black", "red", "blue"))

axis(side = 1L, at = c(0, 24, 48), labels = c("Thu", "Fri", "Sat"))

# Bottom-right panel:

plot(x_data, data$Global_reactive_power, type = "l", xaxt="n", xlab = "datetime", ylab = "Global_reactive_power")

axis(side = 1L, at = c(0, 24, 48), labels = c("Thu", "Fri", "Sat"))

dev.off()


