library(shiny)
library(ggplot2)
library(lubridate)
library(dplyr)
library(Hmisc)
source("helpers/helpers.R")
load("data/genre_data.Rdata")

shinyServer(function(input, output) {
    output$genres <- renderUI({
        list(dateRangeInput('genredates',
                       label = 'Select Dates To Analyze:',
                       start = "2006-10-02", end = "2014-02-05"),
         CheckBoxButton("CheckAllBtn", "checkall", "Check All"),
         CheckBoxButton("UnCheckAllBtn", "uncheckall", "Uncheck All"),
         checkboxGroupInput("genres", "Genres:", 
                            sort(unique(genre.data$genre)), 
                            selected=c("science fiction","fantasy","horror")))
    })
    
    output$gender <- renderUI({
        list(dateRangeInput('genderdates',
                            label = 'Select Dates To Analyze:',
                            start = "2006-10-02", end = "2014-02-05"),
             radioButtons("gendergenre", 
                          choices=sort(unique(genre.data$genre)), 
                          label="")
             )
    })
    
    output$genres_plot <- renderPlot({
        ## This is to compensate for renderPlot being called before renderUI is finished
        dates <- GetDates(input$genredates)
        if (length(input$genredates)==0) {
            genres <- c("science fiction", "fantasy", "horror")
        } else {
            genres <- input$genres
        }
        start <- as.Date(dates[1])
        end <- as.Date(dates[2])
        validate(need(genres > 0, "Please select at least one genre"))
        selected.data <- subset(genre.data, 
                                genre %in% genres & dateadded <= end & dateadded >= start)
        selected.data$usedates <- UseDates(selected.data, dates) 
        by_genre_and_date <- selected.data %.%
            group_by(genre, usedates) %.%
            summarise(counts=n())
        GenrePlot(by_genre_and_date)
    }, height=600, width=950)
    
    output$gender_plot <- renderPlot({
        ## This is to compensate for renderPlot being called before renderUI is finished
        genderdates <- GetDates(input$genderdates)
        if (length(input$genderdates)==0) {
            gendergenre <- "adventure"
        } else {
            gendergenre <- input$gendergenre
        }
        start <- as.Date(genderdates[1])
        end <- as.Date(genderdates[2])
        selected.data <- subset(genre.data, 
                                genre == gendergenre & dateadded <= end & dateadded >= start)
        selected.data$usedates <- UseDates(selected.data, genderdates)
        gender.data <- selected.data %.%
            group_by(gender, usedates) %.%
            summarise(counts=n())
        GenderPlot(gender.data, gendergenre)
    }, height=600, width=950)
})