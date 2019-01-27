# --------------------------------------------------------------------------------------------------
# C04 (Exploratory Data Analysis) - W04 (Two case studies in exploratory data analysis)
# 
# Programming Assignment
# --------------------------------------------------------------------------------------------------
#
# plot2.R. Question to answer: "Have total emissions from PM2.5 decreased in the Baltimore City, 
# 		   Maryland (fips == "24510") from 1999 to 2008?"
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
# 4) Filters only Baltimore data
# --------------------------------------------------------------------------------------------------
baltimoreData <- NEI[NEI$fips == "24510",]

# --------------------------------------------------------------------------------------------------
# 5) Compute emissions by year for Baltimore 
# --------------------------------------------------------------------------------------------------
baltimoreEmissionsByYear <- aggregate(Emissions ~ year, data = baltimoreData, FUN = sum)

# --------------------------------------------------------------------------------------------------
# 6) Prepare and plot the graph
# --------------------------------------------------------------------------------------------------
png("plot2.png", width = 480, height = 480, units = "px")				# open graphic device

with(baltimoreEmissionsByYear, 									# choose dataframe
	barplot(Emissions, 											# choose graph type + y variable
	names.arg = year,											# x variable
	xlab="Years",												# x axis labels
	ylab="Baltimore PM2.5 Emissions (Tons)",					# y axis labels
	main="PM2.5 Emissions By Years - Baltimore"))				# graph title

dev.off()														# close graphic device



