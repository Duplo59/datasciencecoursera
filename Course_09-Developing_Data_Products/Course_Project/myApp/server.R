# ---------------------------------------------------------------------------------------------------------
# Coursera Developing Data Products Course - Week 4 Assignmet
# ---------------------------------------------------------------------------------------------------------
# Loading libraries
library(shiny)
library(ggplot2)
library(reshape)
library(GGally)

# Loading dataset and arranging dataset
df <- as.data.frame(USArrests)
df_State <- df
df_State$State <- rownames(df_State)
df_State <- melt(data = df_State, id.vars = "State", measure.vars = c("Murder", "Assault", "Rape"))
colnames(df_State)[2] <- "Crime"
colnames(df_State)[3] <- "Number"

# Based on the choice done by the user, a scatter plot with a regression line is displayed
shinyServer(function(input, output) {

    reactive({input$modelType

    })

    observe({
        if (input$modelType == 1) {
            output$varPlot <- renderPlot({ggpairs(df, lower = list(continuous = "smooth"), title = "Some insights abouts correlations") +
                    theme_bw() + theme(plot.title = element_text(hjust = 0.5)) +
                    theme(plot.title = element_text(color="black", size=16, face="bold.italic"))
                    })
        } else if (input$modelType == 2) {
            output$varPlot <- renderPlot({ggplot(df_State, aes(x = State, y = Number)) +
                geom_bar(stat="identity", aes(fill = Crime), color="black", size = 0.1) +
                #scale_color_gradient(low = "blue", high = "red") +
                ggtitle("US Arrests Data - 1973 - Crime by US State") +
                theme_bw() + theme(plot.title = element_text(hjust = 0.5)) +
                theme(plot.title = element_text(color="black", size=16, face="bold.italic"),
                      axis.title.x = element_text(color="black", size=14, face="bold"),
                      axis.title.y = element_text(color="black", size=14, face="bold")) +
                theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                xlab("Us State") + ylab("Number of crimes")
            })
        } else if (input$modelType == 3) {
            output$varPlot <- renderPlot({ggplot(df, aes(x = Assault, y = Murder, size = UrbanPop, color = UrbanPop)) +
                    geom_point() + geom_smooth(method=lm) + geom_density_2d() + stat_ellipse() +
                    scale_color_gradient(low = "blue", high = "red") +
                    ggtitle("US Arrests Data - 1973 - Murder vs Assault") +
                    theme_bw() + theme(plot.title = element_text(hjust = 0.5)) +
                    theme(plot.title = element_text(color="black", size=16, face="bold.italic"),
                        axis.title.x = element_text(color="black", size=14, face="bold"),
                        axis.title.y = element_text(color="black", size=14, face="bold")) +
                    xlab("Assault (per 100,000 residents)") + ylab("Murder (per 100,000 residents)")
                    })
        } else {
            output$varPlot <- renderPlot({ggplot(df, aes(x = Assault, y = Rape, size = UrbanPop, color = UrbanPop)) +
                    geom_point() + geom_smooth(method=lm) + geom_density_2d() + stat_ellipse() +
                    scale_color_gradient(low = "green", high = "red") +
                    ggtitle("US Arrests Data - 1973 - Rape vs Assault")  +
                    theme_bw() + theme(plot.title = element_text(hjust = 0.5)) +
                    theme(plot.title = element_text(color="black", size=16, face="bold.italic"),
                        axis.title.x = element_text(color="black", size=14, face="bold"),
                        axis.title.y = element_text(color="black", size=14, face="bold")) +
                    xlab("Rape (per 100,000 residents)") + ylab("Assault (per 100,000 residents)")
                    })
        }
    })
})
