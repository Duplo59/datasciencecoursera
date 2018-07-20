# Write a function that reads a directory full of files and reports the number 
# of completely observed cases in each data file. The function should return 
# a data frame where the first column is the name of the file and the second
# column is the number of complete cases.
# Mi posiziono sulla directory contenente i files da elaborare
# e salvo in una variabile la directory di lavoro
#
complete <- function (directory, id = 1:332) {
# Definisco ed inizializzo le variabili da usare
FileNumber <- vector()
CompleteCasesNumber <- vector()

# Mi posiziono sulla directory contenente i files da elaborare
# e salvo in una variabile la directory di lavoro
WorkDirectory <- paste(file.path(getwd(), directory), "/", sep = "")

# Salvo in una variabile l'elenco dei files da elaborare
FileList <- list.files(WorkDirectory)

# Inizio un ciclo for per elaborare i file passati nella chiamata
# ed accumulo i dati in un vettore
for (i in id) {
	CurrentFile <- paste(WorkDirectory, FileList[i], sep="")
	CurrentPollutionData <- read.csv(CurrentFile)

# Scarico in vettori il file ed il numero di oggetti senza null (complete cases)
# accumulando le info
FileNumber <- c(FileNumber, i)
CompleteCasesNumber <- c(CompleteCasesNumber, sum(complete.cases(CurrentPollutionData)))
}

# Creo il data frame finale
data.frame(id = FileNumber, nobs = CompleteCasesNumber)
}
