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
png(filename="plot2.png", width=480 ,height=480)
#line plot (type l), setting the y axis label, and no label for the x axis
plot(date_time,data$Global_active_power,type="l",xlab=NA,ylab="Global Active Power (kilowatts)")
dev.off()