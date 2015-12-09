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

#start plot1
png(filename = "plot1.png", width = 480, height = 480)
hist(febdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()