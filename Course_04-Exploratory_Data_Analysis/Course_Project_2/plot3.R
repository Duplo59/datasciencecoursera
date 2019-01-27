# --------------------------------------------------------------------------------------------------
# C04 (Exploratory Data Analysis) - W04 (Two case studies in exploratory data analysis)
# 
# Programming Assignment
# --------------------------------------------------------------------------------------------------
#
# plot3.R. Question to answer: "Of the four types of sources indicated by the type (point, nonpoint,
#		   onroad, nonroad) variable, which of these four sources have seen decreases in emissions
#		   from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
#		   1999–2008?"
#
# Notes: the script uses a directory named 'Data' under your current working directory where it
#		 downloads the zip file and unzips it. If this directory does not exist, it creates it. 
# --------------------------------------------------------------------------------------------------
# 1) Set variables and load packages
# --------------------------------------------------------------------------------------------------
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
# 3) Read files
# --------------------------------------------------------------------------------------------------
NEI <- readRDS(file.path(workingDirectory, dataDirectory, NEI_File))
SCC <- readRDS(file.path(workingDirectory, dataDirectory, SCC_File))

# --------------------------------------------------------------------------------------------------
# 4) Filters only Baltimore data
# --------------------------------------------------------------------------------------------------
baltimoreData <- NEI[NEI$fips == "24510",]

# --------------------------------------------------------------------------------------------------
# 5) Prepare and plot the graph
# --------------------------------------------------------------------------------------------------
png("plot3.png", width = 480, height = 480, units = "px")		# open graphic device

# first step: initial call to gglplot, dataframe, aesthetics
ggplot_graph <- ggplot(baltimoreData, aes(x = factor(year), y = Emissions, fill=factor(type)))

# second step: graph type and annotation
ggplot_graph <- ggplot_graph +  geom_bar(stat = "identity") +	# choose bar graph
  theme_bw() + 													# use more stark/plain theme
  guides(fill = FALSE) +										# no legend
  facet_grid(.~type, scales = "fixed", space = "fixed") + 		# fixed scale across all facets and all panel with the same size 
  labs(x = "Years", y = "Baltimore PM2.5 Emissions (Tons)") + 	# axis labels
  ggtitle("PM2.5 Emissions by Source Type - Baltimore") +		# global title 
  theme(plot.title = element_text(hjust = 0.5))					# center position of global title

print(ggplot_graph)												# plot graph
  
dev.off()														# close graphic device



