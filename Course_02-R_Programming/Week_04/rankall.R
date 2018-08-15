rankall <- function(outcome = NULL, num = "best") {

## ---------------------------------------------------------------------------
## Read outcome data
## ---------------------------------------------------------------------------
WholeFile <- read.csv("outcome-of-care-measures.csv")
	   
## ---------------------------------------------------------------------------
## Check that state and outcome are valid
## ---------------------------------------------------------------------------
## Verifico se è presente la variabile in input

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
InputOutcome <- toupper(outcome)
if (!is.numeric(num)) {InputNum <- toupper(num)}
else {InputNum <- num}
OutcomeVector <- c("HEART ATTACK", "HEART FAILURE", "PNEUMONIA")
TotalRank <- vector()

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
## Return a data frame with the hospital names and the
## (abbreviated) state name
## ---------------------------------------------------------------------------
## Faccio il ranking per singolo stato ed accodo tutto in un vettore
StatesList <- levels(factor(WholeFile[, 7]))

for(i in 1:length(StatesList)) {
        
## faccio il subset dei dati per ciascun stato
	FileByState <- subset(WholeFile, State == StatesList[i])
        
## re-select data based on requested input 'outcome' and clean it from all 'na' values;
ChoosenColumns <- suppressWarnings(as.numeric(FileByState[,ColIdx]))
FileByState <- FileByState[!(is.na(ChoosenColumns)), ]	
        
## Ordinamento per ill rate
HospitalRankByState <- FileByState[order(FileByState[, ColIdx], FileByState[, 2]), ]
        
if(InputNum == toupper("best")) 
	{numRank = 1}
else if(InputNum == toupper("worst")) 
		{numRank = nrow(HospitalRankByState)}
     else{numRank = InputNum}
          
HospitalsRanked <- HospitalRankByState[numRank, 2]
      
## Aggiungo i dati al vettore
      
TotalRank <- append(TotalRank, c(HospitalsRanked, StatesList[i]))
      }
  
## Trasformo il tutto in un dataframe

TotalRank <- as.data.frame(matrix(TotalRank, length(StatesList), 2, byrow = TRUE))
colnames(TotalRank) <- c("hospital", "state")
rownames(TotalRank) <- StatesList
  
    #8.3. return AllStatesHospitalRanking:

return(TotalRank)


  








}
