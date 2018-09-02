# ------------------------------------------------------------------------------
#
# plot3.R. Third graph to do
#
# ------------------------------------------------------------------------------
# Set variables and load packages
# ------------------------------------------------------------------------------
library(plyr)
library(dplyr)
# Save working directory
currentPath <- getwd()
# Save input file names
inputFile <- "household_power_consumption.txt"

# ------------------------------------------------------------------------------
# Read file with specification of NA field and with no factor variable. Then
# change one field format (otherwise it is in character format). 
# Add a unique date/time field as a combination of two fields.
# Subset dataset to consider only records belonging to a specific date interval
# ------------------------------------------------------------------------------
# Read txt file 
hpc_data <- read.table(file.path(currentPath, inputFile), header = TRUE, 
sep = ";", na.strings="?", stringsAsFactors=FALSE)
##### Change format Global_active_power da character a numeric
##### hpc_data <- mutate(hpc_data, Global_active_power = as.numeric(Global_active_power))
# Create/add a unique date/time variable
hpc_data <- mutate(hpc_data, dateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))
# Filter only the required information by Date range. NB: the standard date format
# is yyyy-mm-dd
hpc_data <- filter(hpc_data, (dateTime >= "2007-02-01 00:00:00") & (dateTime <= "2007-02-02 23:59:00"))

# ------------------------------------------------------------------------------
# Plot graph with the desired dimensions and the legend
# ------------------------------------------------------------------------------
# Initialize png plot with required width and height
png("plot3.png", width=480, height=480)
# Plot the graph. Type 1 forces a line plot.
with (hpc_data, plot(dateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with (hpc_data, lines(dateTime, Sub_metering_2, type="l", col="red"))
with (hpc_data, lines(dateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
col=c("black", "red", "blue"), lty=c(1,1), lwd=c(1,1))
dev.off()

