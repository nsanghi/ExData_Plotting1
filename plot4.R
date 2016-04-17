# Script for reading and plotting Plot 4

#read data file from same directory as the R script
data <- read.table("household_power_consumption.txt", as.is=TRUE, header=TRUE, sep=";", 
                    quote="", dec=".", na.strings = "?")

#merge date and time columns to a single column of type DateTime class
data$DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
#convert Date and Time columns to appropriate format
#we could also drop these columns if required
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(data$Time, format="%H:%M:%S")

data <- subset(data, DateTime >= as.POSIXlt("2007-02-01") & DateTime < as.POSIXlt("2007-02-03") )

#plot a histogram of Global Active Power values
png("plot4.png")

par(mfrow=c(2,2))

# plot row=1, col=1
plot(data$DateTime, data$Global_active_power,  
     type="l", ylab="Global Active Power", xlab="")

# plot row=1, col=2
plot(data$DateTime, data$Voltage,  
     type="l", ylab="Voltage", xlab="datetime")

# plot row=2, col=1
plot(data$DateTime, data$Sub_metering_1,  
     type="l", ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_2,  
      type="l", co="red")
lines(data$DateTime, data$Sub_metering_3,  
      type="l", co="blue")
legend("topright", col = c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n", lty=c(1,1,1))

# plot row=2, col=2
plot(data$DateTime, data$Global_reactive_power,  
     type="l", ylab="Global Reactive Power", xlab="datetime")


dev.off()
