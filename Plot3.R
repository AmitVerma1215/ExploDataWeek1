library(dplyr)
library(lubridate)
library(data.table)

getwd()

setwd("...../Exploratory Data Analysis")

#download the data in working directory

fileUrl <- "https://archive.ics.uci.edu//ml//machine-learning-databases//00235//household_power_consumption.zip"

download.file(fileUrl, destfile = file.path(getwd(), "data.zip"))

#unzip the file

unzip("data.zip")

#read the data in R

consume_power <- fread("....../Exploratory Data Analysis/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

str(consume_power)

#subset the data based on date

MCP <- rbind(consume_power[consume_power$Date == "1/2/2007",], consume_power[consume_power$Date == "2/2/2017",])

MCP$Date <- as.Date(MCP$Date, "%d/%m/%Y")

MCP <- cbind(MCP, "DateTime" = as.POSIXct(paste(MCP$Date, MCP$Time)))

#plotting the 3rd graph

png("Plot3.png", width = 480, height = 480)

with(MCP, plot(Sub_metering_1, DateTime, type = "l", xlab = "", ylab = "Energy Sub Metering"))

lines(MCP$Sub_metering_2 ~ MCP$DateTime, col = "red")
lines(MCP$Sub_metering_3 ~ MCP$DateTime, col = "blue")
legend("topright", lty = 1, lwd = 3, col = c("black", "red", "blue"), legend = c("sub_metering_1", 
                                                                                 "sub_metering_2", "sub_metering_3"))
dev.off()