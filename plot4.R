#load entire data from file
data = read.csv2("household_power_consumption.txt", na.strings="?", stringsAsFactors = FALSE)
#filter out only dates for Feb 1 and Feb 2
feb1 = data[data$Date == "1/2/2007", ]
feb2 = data[data$Date == "2/2/2007", ]
febdata = rbind(feb1,feb2)
#clear up to reduce memory consumption
rm(data)
rm(feb1)
rm(feb2)

#format Date column to Date object and combine with time for Posix object
febdata[,"Date"] = as.Date(febdata[,"Date"],format="%d/%m/%Y")
Date_Time = as.POSIXct(paste(febdata$Date,febdata$Time))
#replace Date and Time column with combined Posix
febdata = cbind(Date_Time,febdata[,3:9])

#make sure all other values are numeric
febdata[,2:8] = sapply(febdata[,2:8],as.numeric)

#start plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2), mar=c(5,4,3,1) + 0.1)
with(febdata,{
  plot(Date_Time, Global_active_power, type="l", xlab = "",ylab = "Global Active Power")
  plot(Date_Time,Sub_metering_1,type="l", xlab = "",ylab = "Energy sub metering")
  points(Date_Time,Sub_metering_2, type ="l", col="red") 
  points(Date_Time,Sub_metering_3, type="l", col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1, bty="n")
  plot(Date_Time,Voltage, type="l",xlab="datetime")
  plot(Date_Time,Global_reactive_power, type="l", xlab="datetime")
})

dev.off()