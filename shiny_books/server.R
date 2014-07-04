sorted.genres <- sort(unique(genre.data$genre))

shinyServer(function(input, output) {
    # Side Panel
    output$genres <- renderUI({
        list(dateRangeInput('genredates',
                       label = 'Select Dates To Analyze:',
                       start = "2006-10-02", end = "2014-02-05"),
         CheckBoxButton("CheckAllBtn", "checkall", "genres", "Check All"),
         CheckBoxButton("UnCheckAllBtn", "uncheckall", "genres", "Uncheck All"),
         checkboxGroupInput("genres", "Genres:", 
                            sorted.genres, 
                            selected=c("science fiction","fantasy","horror")))
    })
    
    output$gender <- renderUI({
        list(dateRangeInput('genderdates',
                            label = 'Select Dates To Analyze:',
                            start = "2006-10-02", end = "2014-02-05"),
             radioButtons("gendergenre", 
                          choices=sorted.genres, 
                          label="")
             )
    })
    
    output$age <- renderUI({
        list(dateRangeInput('agedates',
                            label = 'Select Dates To Analyze:',
                            start = "2006-10-02", end = "2014-02-05"),
             radioButtons("agegenre", choices=sorted.genres, label="")
        )
    })
    
    output$location <- renderUI({
        checkboxGroupInput("locgenres", "Genres:", sorted.genres)
    })
    
    # Main Panel
    output$genres_plot <- renderPlot({
        ## This is to compensate for renderPlot being called before renderUI is finished
        dates <- GetDates(input$genredates)
        genres <- if (length(input$genredates)==0) c("science fiction", "fantasy", "horror") else input$genres
        validate(need(genres > 0, "Please select at least one genre"))
        selected.data <- subset(genre.data, 
                                genre %in% genres & dateadded <= dates[2] & dateadded >= dates[1])
        selected.data$usedates <- UseDates(selected.data, dates) 
        by_genre_and_date <- selected.data %.%
            group_by(genre, usedates) %.%
            summarise(counts=n())
        GenrePlot(by_genre_and_date, genres)
    }, height=600, width=950)
    
    output$gender_plot <- renderPlot({
        ## This is to compensate for renderPlot being called before renderUI is finished
        genderdates <- GetDates(input$genderdates)
        gendergenre <- if (length(input$genderdates)==0) "adventure" else input$gendergenre
        selected.data <- subset(genre.data, 
                                genre == gendergenre & dateadded <= genderdates[2] & dateadded >= genderdates[1])
        selected.data$usedates <- UseDates(selected.data, genderdates)
        gender.data <- selected.data %.%
            group_by(gender, usedates) %.%
            summarise(counts=n())
        GenderPlot(gender.data, gendergenre)
    }, height=600, width=950)
    
    output$age_plot <- renderPlot({
        ## This is to compensate for renderPlot being called before renderUI is finished
        agedates <- GetDates(input$agedates)
        agegenre <- if (length(input$agedates)==0) "adventure" else input$agegenre
        selected.data <- subset(genre.data, 
                                genre == agegenre & dateadded <= agedates[2] & dateadded >= agedates[1])
        selected.data$usedates <- UseDates(selected.data, agedates)
        selected.data$binnedages <- cut(selected.data$age,breaks=c(0,20,30,40,50,60,70,80,90,110))
        age.data <- selected.data %.%
            group_by(binnedages, usedates) %.%
            summarise(counts=n())
        AgePlot(age.data, agegenre)
    }, height=600, width=950)
    
    output$location_ui <- renderUI({
        
    })
})