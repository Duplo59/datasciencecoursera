# Part 1
# Write a function named 'pollutantmean' that calculates the mean of a 
# pollutant (sulfate or nitrate) across a specified list of monitors.
# The function 'pollutantmean' takes three arguments: 'directory', 'pollutant',
# and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that 
# monitors' particulate matter data from the directory specified in the 
# 'directory' argument and returns the mean of the pollutant across all
# of the monitors, ignoring any missing values coded as NA. 
#
pollutantmean <- function (directory, pollutant, id = 1:332) {

# Definisco ed inizializzo le variabili da usare
TotalPollutionData <- NA

# Mi posiziono sulla directory contenente i files da elaborare
# e salvo in una variabile la directory di lavoro
WorkDirectory <- paste(file.path(getwd(), directory), "/", sep = "")

# Salvo in una variabile l'elenco dei files da elaborare
FileList <- list.files(WorkDirectory)

# Inizio un ciclo for per elaborare i file passati nella chiamata
# ed accumulo i dati in un vettore riga per riga
for (i in id) {
	CurrentFile <- paste(WorkDirectory, FileList[i], sep="")
	CurrentPollutionData <- read.csv(CurrentFile)
	TotalPollutionData <- rbind(TotalPollutionData, CurrentPollutionData)
	}

# Tolgo i valori nulli presenti nel vettore relativamente al pollutant passato come parametro
NotNullTotalPollutionData <- TotalPollutionData[!is.na(TotalPollutionData[, pollutant]), pollutant]

# Faccio la media sul pollutant desiderato
mean(NotNullTotalPollutionData)
	
}

