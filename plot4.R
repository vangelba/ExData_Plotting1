library(sqldf)

#you need to have the household_power_consumption.txt file in your working directory for the following to work
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#using sqldf library, performing a query to get the two required dates only
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, stringsAsFactors=FALSE,sep=";")

#creating a date_time variable which is a POSIXlt by first concatenating the two strings,
# and then parsing them using strptime
date_time=paste(data[["Date"]],data[["Time"]],sep=" ")
date_time=strptime(date_time, "%d/%m/%Y %H:%M:%S")
data[["date_time"]]=date_time

#outputing to a png of the required size
png(filename="plot4.png", width=480 ,height=480)

#creating a 2 by 2 matrix plot, with standard margins. the plots are added left to right, top to bottom
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))
#adding a 1st line plot to the matrix
with(data, plot(date_time, Global_active_power, type="l", xlab=NA, ylab="Global Active Power"))
#adding a 2nd line plot to the matrix
with(data, plot(date_time, Voltage, type="l", xlab="datetime", ylab="Voltage"))
#adding a 3rd line plot to the matrix
with(data, plot(date_time, Sub_metering_1, type = "l", xlab=NA, ylab="Energy sub metering"))
#superposing another line plot to this 3rd plot by calling lines
with(data, lines(date_time, Sub_metering_2, type = "l", col="red"))
#superposing another line plot to this 3rd plot by calling lines
with(data, lines(date_time, Sub_metering_3, type = "l", col="blue"))
#setting the legend to this 3rd plot, using bty="n" in order to remove the legend box
legend("topright", bty="n", lwd=c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#adding a 4th and final plot to the matrix, using type "o" in order to have both lines and points
with(data, plot(date_time, Global_reactive_power, type="o", cex=0.1, xlab="datetime", ylab="Global_reactive_power"))
dev.off()
