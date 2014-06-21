library(shiny)
library(ggplot2)
library(lubridate)
library(dplyr)
source("helpers.R")
load("data/genre_data.Rdata")

shinyServer(function(input, output) {
    output$plot <- renderPlot({
        validate(need(input$genres > 0, "Please select at least one genre"))
        start <- as.Date(input$daterange[1])
        end <- as.Date(input$daterange[2])
        selected.data <- subset(genre.data, 
                                genre %in% input$genres & dateadded <= end & dateadded >= start)
        if (MonthsInRange(input$daterange) > 12) {
            selected.data$usedates <- selected.data$monthadded
        } else {
            selected.data$usedates <- selected.data$dateadded
        }
        
        by_genre_and_date <- selected.data %.%
            group_by(genre, usedates) %.%
            summarise(counts=n())
        p <- ggplot(by_genre_and_date, aes(x=usedates, y=counts, color=genre, group=genre))
        l <- p + xlab("Date Added")+ylab("Number Added")+ggtitle("Genre Popularity Over Time")
        t <- l + theme(plot.title = element_text(lineheight=40, size=20, face="bold", vjust=1),
                       axis.title = element_text(size=17),
                       axis.text = element_text(size=15))
        print(t + geom_line())
    }, height=600, width=950)  
})