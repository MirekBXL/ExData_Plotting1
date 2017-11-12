#read data
work <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#convert column Date in date data type
work$Date <- as.Date(work$Date, format = "%d/%m/%Y")


#subset data only for 01-02/2007
d <- subset(work, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#convert to numeric
d$Global_active_power <- as.numeric(d$Global_active_power)
d$Voltage <- as.numeric(d$Voltage)
d$Global_reactive_power <- as.numeric(d$Global_reactive_power)
d$Sub_metering_1 <- as.numeric(d$Sub_metering_1)
d$Sub_metering_2 <- as.numeric(d$Sub_metering_2)
d$Sub_metering_3 <- as.numeric(d$Sub_metering_3)

d$DateTime <- strptime(paste(d$Date, d$Time, sep = " "), "%Y-%m-%d %H:%M:%S")
d$DateTime <- as.POSIXct(d$DateTime)

#remove the original data frame from the memory
rm("work")

#create the plot and save it
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

with(d, plot(Global_active_power ~ DateTime, type="l", xlab = "", ylab = "Global Active Power"))
with(d, plot(Voltage ~ DateTime, type="l", ylab = "Voltage"))

with(d, plot(Sub_metering_1 ~ DateTime, type = "l", xlab = "", ylab = "Energy sub metering"))
with(d, lines(Sub_metering_2 ~ DateTime, type = "l", col = "red"))
with(d, lines(Sub_metering_3 ~ DateTime, type = "l", col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black", "red", "blue"))

with(d, plot(Global_reactive_power ~ DateTime, type="l", xlab = "datetime"))

dev.off()