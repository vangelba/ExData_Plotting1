library(sqldf)

#you need to have the household_power_consumption.txt file in your working directory for the following to work
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#using sqldf library, performing a query to get the two required dates only
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, stringsAsFactors=FALSE,sep=";")

#outputing to a png of the required size
png(filename="plot1.png", width=480 ,height=480)
#simple histogram in red, setting the main title and the x axis label
hist(data$Global_active_power, col ="red", main ="Global Active Power", xlab="Global Active Power (kilowatts)")
#closing device hence saving the png file
dev.off()