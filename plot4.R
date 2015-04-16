if( !file.exists("exdata_data_household_power_consumption.zip") ) {
    download.file(
        url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        destfile = "exdata_data_household_power_consumption.zip",
        method = "curl"
        )
    }
    

epc.org <- read.csv(
     file = unz(  description = "exdata_data_household_power_consumption.zip"
                ,filename = "household_power_consumption.txt"
                )
    ,header = T
    ,sep = ";"
    ,na.strings = "?"
    ,stringsAsFactors = F
    )
  
epc.org$DTStamp <- strptime( paste(epc.org$Date, epc.org$Time), "%d/%m/%Y %H:%M:%S" )
epc.subs <- epc.org[ (as.Date(epc.org$DTStamp) == as.Date("2007-02-01") | as.Date(epc.org$DTStamp) == as.Date("2007-02-02")), ]


png("plot4.png")
par( mfrow = c(2,2) )
plot( epc.subs$DTStamp, epc.subs$Global_active_power, type = "l", main = "", xlab = "", ylab = "Global Active Power" )
plot( epc.subs$DTStamp, epc.subs$Voltage, type = "l", main = "", xlab = "datetime", ylab = "Voltage" )
plot( epc.subs$DTStamp, epc.subs$Sub_metering_1, type = "l", main = "", xlab = "", ylab = "Energy sub metering" )
points( epc.subs$DTStamp, epc.subs$Sub_metering_2, col = "red", type = "l")
points( epc.subs$DTStamp, epc.subs$Sub_metering_3, col = "blue", type = "l")
legend( x = "topright"
        ,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        ,col = c("black", "red", "blue")
        ,lwd = 1
        ,bty = "n"
        )
plot( epc.subs$DTStamp, epc.subs$Global_reactive_power, type = "l", main = "", xlab = "datetime", ylab = "Global_reactive_power" )
dev.off()


