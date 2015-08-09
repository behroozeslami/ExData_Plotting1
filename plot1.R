# Generates "plot1.png".

# Reading the full data.

fulldata <- read.table("./household_power_consumption.txt", 
                   header = TRUE, sep = ";", na.strings = "?", nrows = 2075259, 
                   colClasses = c("character","character",rep("numeric",7)))

# Subsetting the data.

data <- fulldata[(fulldata$Date == "1/2/2007" | fulldata$Date == "2/2/2007"), ]

# Generating the plot.

png("plot1.png", width = 480, height = 480)

hist(data$Global_active_power, 
     col = "red", main = "Global Active Power", xlab = "Global Active Power (killowatts)")

dev.off()