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


png("plot2.png")
plot( epc.subs$DTStamp, epc.subs$Global_active_power, type = "l", main = "", xlab = "", ylab = "Global Active Power (kilowatts)" )
dev.off()


