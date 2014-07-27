if(!file.exists("./data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data.zip")
  unzip("./data.zip")
}

data1 <- read.table("household_power_consumption.txt",
                    header = TRUE, 
                    sep = ";",
                    nrows = 70000,
                    na.strings = "?")

data <- subset(data1, data1$Date %in% c("1/2/2007", "2/2/2007"))
dtime <- as.POSIXct(strptime(paste(data[,1],data[,2]), "%d/%m/%Y %H:%M:%S"))


par(mfrow = c(2, 2))

with(data, 
  plot(as.numeric(Global_active_power)~dtime,
  ##as.numeric() seems to be necessary here
  type="l",
  xlab="",
  ylab="Global Active Power (kilowatts)"
))

with(data, 
     plot(as.numeric(Voltage)~dtime,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
)

with(data,
{
plot(as.numeric(Sub_metering_1)~dtime,
  ##as.numeric() seems to be necessary here
  type="l",
  xlab="",
  ylab="Energy sub metering"
) 
    
lines(as.numeric(Sub_metering_2)~dtime, col = "red")
    
lines(as.numeric(Sub_metering_3)~dtime, col = "blue")

legend("topright", col=c("black", "red", "blue"),
       cex = 0.3, lty = 1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

with(data, 
     plot(as.numeric(Global_reactive_power)~dtime,
       type = "l",
       xlab = "datetime",
       ylab = "Global_reactive_power")
)

dev.copy(png, file = "plot4.png")
dev.off() 