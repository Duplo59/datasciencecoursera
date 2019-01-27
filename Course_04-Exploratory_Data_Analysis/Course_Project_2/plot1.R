# --------------------------------------------------------------------------------------------------
# C04 (Exploratory Data Analysis) - W04 (Two case studies in exploratory data analysis)
# 
# Programming Assignment
# --------------------------------------------------------------------------------------------------
#
# plot1.R. Question to answer: "Have total emissions from PM2.5 decreased in the United States from
# 		   1999 to 2008?"
#
# Notes: the script uses a directory named 'Data' under your current working directory where it
#		 downloads the zip file and unzips it. If this directory does not exist, it creates it. 
# --------------------------------------------------------------------------------------------------
# 1) Set variables and load packages
# --------------------------------------------------------------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipDataFile <- "exdata%2Fdata%2FNEI_data.zip"
dataDirectory <- "Data"
workingDirectory <- getwd()
NEI_File <- "summarySCC_PM25.rds"
SCC_File <- "Source_Classification_Code.rds"

# --------------------------------------------------------------------------------------------------
# 2) Delete existing files and data directory. Then download and unzip the file
## --------------------------------------------------------------------------------------------------
if (!file.exists(file.path(workingDirectory, dataDirectory))) {
	dir.create(file.path(workingDirectory, dataDirectory))}

download.file(fileUrl,									
	file.path(workingDirectory, dataDirectory, zipDataFile),			 
	method="curl")
setwd(file.path(workingDirectory, dataDirectory))	
unzip(zipDataFile)					
file.remove(zipDataFile)
setwd(workingDirectory)

# --------------------------------------------------------------------------------------------------
# 3) Read files
# --------------------------------------------------------------------------------------------------
NEI <- readRDS(file.path(workingDirectory, dataDirectory, NEI_File))
SCC <- readRDS(file.path(workingDirectory, dataDirectory, SCC_File))

# --------------------------------------------------------------------------------------------------
# 4) Compute total emissions by year 
# --------------------------------------------------------------------------------------------------
totalEmissionsByYear <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

# --------------------------------------------------------------------------------------------------
# 5) Prepare and plot the graph
# --------------------------------------------------------------------------------------------------
png("plot1.png", width = 480, height = 480, units = "px")		# open graphic device

with(totalEmissionsByYear, 										# choose dataframe
	barplot(Emissions / 10^6, 									# choose graph type + y variable
	names.arg = year,											# x variable
	xlab = "Years",												# x axis labels
	ylab = "Total PM2.5 Emissions (millions of Tons)",			# y axis labels
	main = "PM2.5 Emissions By Years - All US States"))			# graph title

dev.off()														# close graphic device



