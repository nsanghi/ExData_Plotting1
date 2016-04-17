# Script for reading and plotting Plot 3

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
png("plot3.png")

plot(data$DateTime, data$Sub_metering_1,  
     type="l", ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_2,  
      type="l", co="red")
lines(data$DateTime, data$Sub_metering_3,  
      type="l", co="blue")
legend("topright", col = c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1))

dev.off()
