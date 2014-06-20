library(shiny)
library(ggplot2)
load("genre_data.Rdata")

shinyUI(
    fluidPage(
        titlePanel("Books Analysis"),
        sidebarPanel(
            checkboxGroupInput("genres", "Genres:", sort(unique(genre.data$genre)), selected=sort(unique(genre.data$genre)))
        ),
        mainPanel(
            width=9,
            plotOutput("plot")
        )
))