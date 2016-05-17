#load data
#grab class of each variable
init <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", nrow=100, sep = ";", header = TRUE)
top <- sapply(init,class)
#read in full dataset with class
data <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
                   comment.char = "",colClasses = top, header = TRUE, na.strings = "?", sep = ";")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#use filter function from dplyr package to subset data
library(dplyr)
subdata <- filter(data, Date >= "2007-02-01" & Date <= "2007-02-02")
#set up date and time necessary for some graphs
dateandtime <- strptime(paste(as.Date(subdata$Date), subdata$Time), format = "%Y-%m-%d %H:%M:%S")


#make Plot 3
png("plot3.png", width = 480,height = 480)
plot(dateandtime,subdata$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering")
lines(dateandtime,subdata$Sub_metering_2, col="Red")
lines(dateandtime,subdata$Sub_metering_3, col="Blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()