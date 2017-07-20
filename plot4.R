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

# create plot4.png

# top left
png("plot4.png") # default is 480 x 480

par(mfrow = c(2, 2))
plot(y = dat1$Global_active_power,
     x = dat1$datetime, 
     type = "n",
     xlab = "",
     ylab = "Global Active Power")
lines(y = dat1$Global_active_power,
      x = dat1$datetime)

# top right
plot(y = dat1$Voltage,
     x = dat1$datetime, 
     type = "n",
     xlab = "datetime",
     ylab = "Voltage")
lines(y = dat1$Voltage,
      x = dat1$datetime)

# bottom left
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
       bty = "n",
       cex = 0.75,
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       col = c("black","red","blue"),
       lwd = 1)

# bottom right
plot(y = dat1$Global_reactive_power,
     x = dat1$datetime, 
     type = "n",
     xlab = "datetime",
     ylab = "Global_reactive_power")
lines(y = dat1$Global_reactive_power,
      x = dat1$datetime)

dev.off()

# delete unzipped data 
# this is needed to avoid exceeding git's file size limit
# and also keeping R-scripts funtional if pulled
file.remove("household_power_consumption.txt")
