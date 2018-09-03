# ------------------------------------------------------------------------------
#
# plot1.R. First graph to do
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
# 2) change Date field format from character to date;
# 3) subset dataset to consider only records belonging to a specific 
#    date interval
# ------------------------------------------------------------------------------
# Read txt file 
hpc_data <- read.table(file.path(currentPath, inputFile), header = TRUE, 
sep = ";", na.strings="?", stringsAsFactors=FALSE)
# Change Date from Character format to Date format
hpc_data <- mutate(hpc_data, Date = as.Date(Date, "%d/%m/%Y"))
# Filter only the required information by Date range. NB: the standard date format
# is yyyy-mm-dd
hpc_data <- filter(hpc_data, (Date >= "2007-02-01") & (Date <= "2007-02-02"))

# ------------------------------------------------------------------------------
# Dataset manipulation to prepare data for plotting
# ------------------------------------------------------------------------------
# Change Global_active_power format from Character to Numeric
hpc_data <- mutate(hpc_data, Global_active_power = as.numeric(Global_active_power))

# ------------------------------------------------------------------------------
# Plot graph with the desired dimensions
# ------------------------------------------------------------------------------
# Initialize png plot with requirde width and height
png("plot1.png", width=480, height=480)
# Plot the graph
with (hpc_data, hist(Global_active_power, col="red", main="Global Active Power", 
xlab="Global Active Power (kilowatts)"))
dev.off()
