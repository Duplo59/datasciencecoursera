# ------------------------------------------------------------------------------
#
# plot2.R. Second graph to do
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
# Read data:
# 1) read file with specification of NA field and with no factor variable;
# 2) create a unique datetime field starting from distinct Date and Time
#    field in character format
# 3) subset dataset to consider only records belonging to a specific 
#    date interval
# ------------------------------------------------------------------------------
# Read txt file 
hpc_data <- read.table(file.path(currentPath, inputFile), header = TRUE, 
sep = ";", na.strings="?", stringsAsFactors=FALSE)
# Create/add a unique date/time variable
hpc_data <- mutate(hpc_data, dateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))
# Filter only the required information by Date range. NB: the standard date format
# is yyyy-mm-dd
hpc_data <- filter(hpc_data, (dateTime >= "2007-02-01 00:00:00") & (dateTime <= "2007-02-02 23:59:00"))

# ------------------------------------------------------------------------------
# Dataset manipulation to prepare data for plotting
# ------------------------------------------------------------------------------
# Change format Global_active_power da character a numeric
hpc_data <- mutate(hpc_data, Global_active_power = as.numeric(Global_active_power))

# ------------------------------------------------------------------------------
# Plot graph with the desired dimensions
# ------------------------------------------------------------------------------
# Initialize png plot with required width and height
png("plot2.png", width=480, height=480)
# Plot the graph. Type 1 forces a line plot.
with (hpc_data, plot(dateTime, Global_active_power, type="l", xlab="", 
ylab="Global Active Power (kilowatts)"))
dev.off()

