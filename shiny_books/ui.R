library(shiny)
library(ggplot2)
load("genre_data.Rdata")

shinyUI(
    fluidPage(
        titlePanel("Books Analysis"),
        sidebarPanel(
            dateRangeInput('daterange',
                           label = 'Select Dates To Analyze:',
                           start = "2006-10-02", end = "2014-02-05"),
            checkboxGroupInput("genres", "Genres:", 
                               sort(unique(genre.data$genre)), 
                               selected=sort(unique(genre.data$genre)))
        ),
        
        mainPanel(
            width=9,
            plotOutput("plot")
        )
))