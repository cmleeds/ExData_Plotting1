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

# create plot2.png
png("plot2.png") # default is 480 x 480
plot(y = dat1$Global_active_power,
     x = dat1$datetime, 
     type = "n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(y = dat1$Global_active_power,
      x = dat1$datetime)
dev.off()

# delete unzipped data 
# this is needed to avoid exceeding git's file size limit
# and also keeping R-scripts funtional if pulled
file.remove("household_power_consumption.txt")
