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
# Read file with specification of NA field and with no factor variable. Then
# change two fields format (otherwise they are in character format). Subset
# dataset
# ------------------------------------------------------------------------------
# Read txt file 
hpc_data <- read.table(file.path(currentPath, inputFile), header = TRUE, 
sep = ";", na.strings="?", stringsAsFactors=FALSE)
# Change Date from character format to Time format
hpc_data <- mutate(hpc_data, Date = as.Date(Date, "%d/%m/%Y"))
# Filter only the required information by Date range. NB: the standard date format
# is yyyy-mm-dd
hpc_data <- filter(hpc_data, (Date >= "2007-02-01") & (Date <= "2007-02-02"))
# Change format Global_active_power da character a numeric
hpc_data <- mutate(hpc_data, Global_active_power = as.numeric(Global_active_power))

# ------------------------------------------------------------------------------
# Plot graph with the desired dimensions
# ------------------------------------------------------------------------------
# Initialize png plot with requirde width and height
png("plot1.png", width=480, height=480)
# Plot the graph
hist(hpc_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()