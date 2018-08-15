rankhospital <- function(state = NULL, outcome = NULL, num = "best") {

## ---------------------------------------------------------------------------
## Read outcome data
## ---------------------------------------------------------------------------
WholeFile <- read.csv("outcome-of-care-measures.csv")
	   
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

if (toupper(num) == "BEST") {}
else
	if (toupper(num) == "WORST") {}
	else
		if (is.numeric(num)) {}
		else
			{stop('Warning! - Invalid input!') }

## Trasformo in maiuscolo lo stato, e la malattia fornite in input
## ed inizializzo alcune variabili
InputState <- toupper(state)
InputOutcome <- toupper(outcome)
if (!is.numeric(num)) {InputNum <- toupper(num)}
else {InputNum <- num}
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

## Cambio il formato della colonna di interesse in numerico
## La classe della colonna è di tipo factor
WholeFile[, ColIdx] <- suppressWarnings(as.numeric(levels(WholeFile[, ColIdx])[WholeFile[, ColIdx]]))

## Imposto a carattere anche la colonna degli stati (che è una factor anch'essa)
WholeFile[, 2] <- as.character(WholeFile[, 2])
				
## ---------------------------------------------------------------------------
## Return hospital name in that state with the given rank
## 30-day death rate
## ---------------------------------------------------------------------------

# Prendo in cosiderazione solo i record dello stato di interesse
ChoosenData <- subset(WholeFile, toupper(State) == InputState)

## Ora ho un file con i soli dati dello stato di interesse.
## Con l'espresssione as.numeric converto tutto in un dato numerico
## Il suppressWarnings serve per togliere la segnalazione di coercion
## eseguita dall'as.numeric. Si formano degli NA che tolgo con la successiva
## istruzione
ColumnDataTemp <- suppressWarnings(as.numeric(ChoosenData[,ColIdx]))
ChoosenDataOK <- ChoosenData[!(is.na(ColumnDataTemp)), ]

## Ordino la base dati per malattia e per ospedale
OrderedData <- ChoosenDataOK[order(ChoosenDataOK[, ColIdx], ChoosenDataOK[, 2]), ]

## Individuo i rank
if(InputNum == "BEST") {RankNo = 1}
else
	if(InputNum == "WORST") {RankNo = nrow(OrderedData)}
	else
		{RankNo = InputNum}

##class(RankNo)	
return(OrderedData[RankNo, 2])







}
