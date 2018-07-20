# Write a function that reads a directory full of files and reports the number 
# of completely observed cases in each data file. The function should return 
# a data frame where the first column is the name of the file and the second
# column is the number of complete cases.
# Mi posiziono sulla directory contenente i files da elaborare
# e salvo in una variabile la directory di lavoro
#
source("complete.R")

corr <- function (directory, threshold = 0) {
# Definisco ed inizializzo le variabili da usare
Correlation <- vector()

# Mi posiziono sulla directory contenente i files da elaborare
# e salvo in una variabile la directory di lavoro
WorkDirectory <- paste(file.path(getwd(), directory), "/", sep = "")

# Richiamo la funzione 'complete' che mi restituisce il num. del file (id)
# ed il numero di righe not null (complete.cases function) presenti
# in ciascun file. 
TotalData <- complete(directory)

# Quindi filtro per tenere conto della soglia che è 
# stato passata con la chiamata della funzione (threshold). In pratica si 
# vuole calcolare la correlazione solo per quei file che soddisfano una 
# soglia minima di righe complete. 
# Avrò quindi un elenco di ids e nobs ovvero di file che soddisfano
# il requisito di nd. di righe not null > della soglia indicata
# nella chiamata della funzione
FilteredFileNumber <- TotalData$id[TotalData$nobs > threshold]

# Creo i percorsi fisici per leggere i file di interesse:
FileList <- list.files(WorkDirectory)

# Inizio un ciclo for per elaborare i file individuati e calcolo la relativa
# covarianza
for (i in FilteredFileNumber) {
	CurrentFile <- paste(WorkDirectory, FileList[i], sep="")
	CurrentFileData <- read.csv(CurrentFile)
	Correlation <- c(Correlation, cor(CurrentFileData$sulfate, CurrentFileData$nitrate, use="complete.obs"))
}
# Ritorno il dato calcolato
Correlation
}

