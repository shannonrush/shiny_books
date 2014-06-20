library(shiny)
library(ggplot2)
library(lubridate)
library(dplyr)
load("genre_data.Rdata")

shinyServer(function(input, output) {
    output$plot <- renderPlot({
        selected.data <- subset(genre.data, genre %in% input$genres)
        selected.data$dateadded <- floor_date(as.Date(selected.data$dateadded), "month")
        by_genre_and_date <- selected.data %.%
            group_by(genre, dateadded) %.%
            summarise(counts=n())
        p <- ggplot(by_genre_and_date, aes(x=dateadded, y=counts, color=genre, group=genre))
        l <- p + xlab("Date Added")+ylab("Number Added")+ggtitle("Genre Popularity Over Time")
        t <- l + theme(plot.title = element_text(lineheight=40, size=20, face="bold", vjust=1),
                       axis.title = element_text(size=17),
                       axis.text = element_text(size=15))
        print(t + geom_line())
    }, height=600, width=950)

    
})