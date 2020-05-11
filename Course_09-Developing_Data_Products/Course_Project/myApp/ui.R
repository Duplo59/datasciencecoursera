# ---------------------------------------------------------------------------------------------------------
# Coursera Developing Data Products Course - Week 4 Assignmet
# ---------------------------------------------------------------------------------------------------------

# Loading libraries
library(shiny)

# Creating some radio buttons in order to let the user choice the data to analyze with a scatter plot
shinyUI(fluidPage(
  titlePanel("A brief analysis about US Arrests in 1973"),
  sidebarLayout(
    sidebarPanel(
#        helpText("Choose what kind of data you want to look at"),
        radioButtons("modelType",
                     label = "Which kind of analysis do you want?",
                     choices =  list("Correlation analysis" = 1,
                                     "Analysis by US State" = 2,
                                     "Murders vs Assaults" = 3,
                                     "Rapes vs Assaults" = 4),
                     selected = 1)
    ),
    mainPanel(
      plotOutput("varPlot")
#    h3("Prova")
#    textOutput("varTitle")
#     h3("Predicted Horsepower from Model 2:")
#      textOutput("pred2")
    )
  )
))
