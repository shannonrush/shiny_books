library(shiny)
library(ggplot2)
library(lubridate)
library(dplyr)
library(Hmisc)
source("helpers.R")
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
        if (length(input$genredates)==0) {
            dates <- c("2006-10-02", "2014-02-05")
            genres <- c("science fiction", "fantasy", "horror")
        } else {
            dates <- input$genredates
            genres <- input$genres
        }
        start <- as.Date(dates[1])
        end <- as.Date(dates[2])
        validate(need(genres > 0, "Please select at least one genre"))
        selected.data <- subset(genre.data, 
                                genre %in% genres & dateadded <= end & dateadded >= start)
        if (MonthsInRange(dates) > 12) {
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
        t + geom_line()
    }, height=600, width=950)
    
    output$gender_plot <- renderPlot({
        ## This is to compensate for renderPlot being called before renderUI is finished
        if (length(input$genderdates)==0) {
            genderdates <- c("2006-10-02", "2014-02-05")
            gendergenre <- "adventure"
        } else {
            genderdates <- input$genderdates
            gendergenre <- input$gendergenre
        }
        start <- as.Date(genderdates[1])
        end <- as.Date(genderdates[2])
        selected.data <- subset(genre.data, 
                                genre == gendergenre & dateadded <= end & dateadded >= start)
        if (MonthsInRange(genderdates) > 12) {
            selected.data$usedates <- selected.data$monthadded
        } else {
            selected.data$usedates <- selected.data$dateadded
        }
        gender.data <- selected.data %.%
            group_by(gender, usedates) %.%
            summarise(counts=n())
        p <- ggplot(gender.data, aes(x=usedates, y=counts, color=gender, group=gender)) 
        title <- paste(ToCaps(gendergenre),"Popularity By Gender")
        l <- p + xlab("Date Added")+ylab("Number Added")+ggtitle(title)
        t <- l + theme(plot.title = element_text(lineheight=40, size=20, face="bold", vjust=1),
                       axis.title = element_text(size=17),
                       axis.text = element_text(size=15))
        s <- t + scale_colour_discrete(name = "",
                                       labels=c("Not Specified","Female","Male"))
        s + geom_line()
    }, height=600, width=950)
})