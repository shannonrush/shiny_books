library(shiny)

shinyUI(
    fluidPage(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "css/application.css"),
            tags$script(src = "js/checkall.js"),
            tags$script(src = "js/uncheckall.js")
        ),
        titlePanel("Books Analysis"),
        sidebarPanel(
            conditionalPanel("input.plottabs=='Genres'", uiOutput("genres")),
            conditionalPanel("input.plottabs=='By Gender'", uiOutput("gender")),
            conditionalPanel("input.plottabs=='By Age Group'", uiOutput("age")),
            conditionalPanel("input.plottabs=='By Location'", uiOutput("location"))
        ),
        mainPanel(
            width=9, 
            tabsetPanel(type="pills", id="plottabs",
                        tabPanel("Genres",plotOutput("genres_plot")),
                        tabPanel("By Gender",plotOutput("gender_plot")),
                        tabPanel("By Age Group",plotOutput("age_plot"))
                        #tabPanel("By Location",plotOutput("location_plot"))
                )
            
        )
))