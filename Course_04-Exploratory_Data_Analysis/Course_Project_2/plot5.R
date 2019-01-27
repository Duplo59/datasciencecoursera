# --------------------------------------------------------------------------------------------------
# C04 (Exploratory Data Analysis) - W04 (Two case studies in exploratory data analysis)
# 
# Programming Assignment
# --------------------------------------------------------------------------------------------------
#
# plot5.R. Question to answer: "How have emissions from motor vehicle sources changed from 1999–2008
#		   in Baltimore City?"
#
# Notes: the script uses a directory named 'Data' under your current working directory where it
#		 downloads the zip file and unzips it. If this directory does not exist, it creates it. 
# --------------------------------------------------------------------------------------------------
# 1) Set variables and load packages
# --------------------------------------------------------------------------------------------------
library(data.table)
library(ggplot2)
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
# 3) Read files and transform them in data.table
# --------------------------------------------------------------------------------------------------
NEI <- readRDS(file.path(workingDirectory, dataDirectory, NEI_File))
SCC <- readRDS(file.path(workingDirectory, dataDirectory, SCC_File))
NEI <- data.table(NEI)
SCC <- data.table(SCC)

# --------------------------------------------------------------------------------------------------
# 4) Extract rows from SCC related to the question. NB: also here it is not clear how to single out 
#	 "emissions from motor vehicle sources" ... 
# --------------------------------------------------------------------------------------------------
# find a logical vector about SCC rows to be considered
SCCrowsgroup <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case = TRUE)
# extract SCC codes to be considered 
SCCcodes <- SCC[SCCrowsgroup, SCC]	
# extract NEI rows with SCC codes to be considered
finalNEI <- NEI[NEI[,SCC] %in% SCCcodes]

# --------------------------------------------------------------------------------------------------
# 4) Filters only Baltimore data
# --------------------------------------------------------------------------------------------------
baltimoreData <- finalNEI[finalNEI$fips == "24510",]

# --------------------------------------------------------------------------------------------------
# 5) Prepare and plot the graph
# --------------------------------------------------------------------------------------------------
png("plot5.png", width = 480, height = 480, units = "px")						# open graphic device

# first step: initial call to gglplot, dataframe, aesthetics
ggplot_graph <- ggplot(baltimoreData, aes(x = factor(year), y = Emissions))

# second step: graph type and annotation
ggplot_graph <- ggplot_graph + 
	geom_bar(stat = "identity",  fill = "green")	+							# choose bar graph
	theme_bw() + 																# use more stark/plain theme
	guides(fill = FALSE) +														# no legend
	labs(x = "Years", y = "Baltimore PM2.5 Emissions (Tons)") + 				# axis labels
	ggtitle("Motor Vehicle Sources Emissions By Years - Baltimore") +			# global title 
	theme(plot.title = element_text(hjust = 0.5))								# center position of title

print(ggplot_graph)																# plot graph
  
dev.off()																		# close graphic device



