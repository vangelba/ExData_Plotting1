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
png(filename="plot3.png", width=480 ,height=480)
#plotting a line graph, setting a y axis label, but none for the x axis
with(data, plot(date_time, Sub_metering_1, type = "l", xlab=NA, ylab="Energy sub metering"))
#adding another one calling lines directly of red color
with(data, lines(date_time, Sub_metering_2, type = "l", col="red"))
#adding another one calling lines directly of blue color
with(data, lines(date_time, Sub_metering_3, type = "l", col="blue"))
#adding a legend on the top right corner, setting the 3 labels and corresponding colors
legend("topright", lwd=c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()