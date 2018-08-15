best <- function(state = NULL, outcome = NULL) {
## ---------------------------------------------------------------------------
## Read outcome data 
## ---------------------------------------------------------------------------
WholeFile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
       
## ---------------------------------------------------------------------------
## Check that state and outcome are valid
## ---------------------------------------------------------------------------
## Verifico se le due variabili in input sono presenti
if (is.null(state)) {
stop('Warning! - State is null!')
} 

if (is.null(outcome)) {
stop('Warning! - Outcome is null!')
}

## Trasformo in maiuscolo lo stato e la malattia fornite in input
## ed inizializzo alcune variabili
InputState <- toupper(state)
InputOutcome <- toupper(outcome)
OutcomeVector <- c("HEART ATTACK", "HEART FAILURE", "PNEUMONIA")


## Verifico se lo stato passato alla funzione esiste nel dataframe
if (!InputState %in% unique(WholeFile$State)) {
stop('invalid state')
}

## Verifico se la malattia passata alla funzione esiste nel dataframe
if (!InputOutcome %in% OutcomeVector) {
stop('invalid outcome')
}

## Identifico la colonna di interesse in relazione alla patologia passata
## alla funzione
ColIdx <-	if (InputOutcome == toupper("heart attack")) {11}
			else 
				if (InputOutcome == toupper("heart failure")) {17}
				else {23}

##WholeFile[, colNumber] <- suppressWarnings(as.numeric(levels(WholeFile[, colNumber])[WholeFile[, colNumber]]))
				
## ---------------------------------------------------------------------------
## Return hospital name in that state with lowest 30-day death
## rate
## ---------------------------------------------------------------------------
# Prendo in cosiderazione solo i record dello stato di interesse
ChoosenData <- subset(WholeFile, toupper(State) == InputState)
## Ora ho un file con i soli dati dello stato di interesse.
## Con l'espresssione as.numeric converto tutto in un dato numerico
## Il suppressWarnings serve per togliere la segnalazione di coercion
## eseguita dall'as.numeric. Si formano degli NA che tolgo con la successiva
## istruzione. NB: la colonna dei dati estratti è alfanumerica alla fine!
ColumnDataTemp <- suppressWarnings(as.numeric(ChoosenData[,ColIdx]))
ChoosenDataOK <- ChoosenData[!(is.na(ColumnDataTemp)), ]
## Individuo tutti i valori validi della malattia richiesta
## Alla fine ColumnsDataOK è e deve essere numerico
ColumnsDataOK <- as.numeric(ChoosenDataOK[, ColIdx])
## Individuo ora le righe corrispondenti al valore minimo della malattia
RowsNumber <- which(ColumnsDataOK == min(ColumnsDataOK))
#à Individuo l'ospedale cui corrisponde il valore minimo
HospitalName <- ChoosenDataOK[RowsNumber, 2]
OrderedHospitalName <- sort(HospitalName)

return(OrderedHospitalName)



 }