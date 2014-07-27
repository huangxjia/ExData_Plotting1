if(!file.exists("./data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data.zip")
  unzip("./data.zip")
}

##transform

dfData <- read.table("household_power_consumption.txt", 
                     header = TRUE, sep = ";", nrows=70000,
                     na.strings = "?")

##the "?" value will influence the graph in an unknown way, and na.strings
##get this problem solved!

dfData2 <- subset(dfData, dfData$Date %in% c("1/2/2007", "2/2/2007"))
x <- as.numeric((dfData2$Global_active_power))
hist(x, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
