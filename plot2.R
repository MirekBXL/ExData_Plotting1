#read data
work <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#convert column Date in date data type
work$Date <- as.Date(work$Date, format = "%d/%m/%Y")


#subset data only for 01-02/2007
d <- subset(work, subset = (Date >= "2007-02-01" & Date < "2007-02-03"))

#convert to numeric
d$Global_active_power <- as.numeric(d$Global_active_power)
d$DateTime <- strptime(paste(d$Date, d$Time, sep = " "), "%Y-%m-%d %H:%M:%S")
d$DateTime <- as.POSIXct(d$DateTime)

#remove the original data frame from the memory
rm("work")

#create the plot and save it
png("plot2.png", width = 480, height = 480, units = "px")
with(d, plot(Global_active_power ~ DateTime, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()