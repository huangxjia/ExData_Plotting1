if(!file.exists("./data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data.zip")
  unzip("./data.zip")
}

data1 <- read.table("household_power_consumption.txt",
                    header = TRUE, 
                    sep = ";",
                    nrows = 70000,
                    na.strings = "?")

##na.strings = "?". Good. Solve the problem.

data <- subset(data1, data1$Date %in% c("1/2/2007", "2/2/2007"))
dtime <- as.POSIXct(strptime(paste(data[,1],data[,2]), "%d/%m/%Y %H:%M:%S"))

plot(
  as.numeric(data$Sub_metering_1)~dtime,
  ##as.numeric() seems to be necessary here
  type="l",
  xlab="",
  ylab="Energy sub metering"
)
lines(as.numeric(data$Sub_metering_2)~dtime, 
      col = "red")
lines(as.numeric(data$Sub_metering_3)~dtime, 
      col = "blue")

legend("topright", col=c("black", "red", "blue"),
       cex = 0.75, lty = "solid",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off() 