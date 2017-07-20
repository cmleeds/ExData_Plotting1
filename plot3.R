# clear workspace 
rm(list=ls())

# load libraries
library(data.table)

# unzip files 
unzip("exdata_data_household_power_consumption.zip")

# load data
dat0 <- fread("household_power_consumption.txt",
              na.strings="?")

# format data
str(dat0)

dat1 <- dat0[
  ,date := as.Date(Date,format="%d/%m/%Y")
  ][
    date %in% as.Date(c("2007-02-01","2007-02-02"))
    ][
      ,datetime := strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S")
      ]

str(dat1)

# create plot3.png
png("plot3.png") # default is 480 x 480
plot(x = dat1$datetime,
     y = dat1$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = dat1$datetime,
      y = dat1$Sub_metering_1)
lines(x = dat1$datetime,
      y = dat1$Sub_metering_2,
      col = "red")
lines(x = dat1$datetime,
      y = dat1$Sub_metering_3,
      col = "blue")
legend("topright",
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       col = c("black","red","blue"),
       lwd = 1)
dev.off()

# delete unzipped data 
# this is needed to avoid exceeding git's file size limit
# and also keeping R-scripts funtional if pulled
file.remove("household_power_consumption.txt")
