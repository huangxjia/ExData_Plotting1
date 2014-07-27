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

par(mfrow = c(1,1))
par(cex = 0.75)
dtime <- as.POSIXct(strptime(paste(data[,1],data[,2]), "%d/%m/%Y %H:%M:%S"))

plot(
  as.numeric(data$Global_active_power)~dtime,
##as.numeric() seems to be necessary here
  type="l",
  xlab="",
  ylab="Global Active Power (kilowatts)"
)

dev.copy(png, file = "plot2.png")
dev.off() 