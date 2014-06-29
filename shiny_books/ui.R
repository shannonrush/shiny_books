library(shiny)

shinyUI(
    fluidPage(
        tags$head(
            includeCSS("www/css/application.css"),
            includeCSS("www/css/map.css"),
            includeScript("www/js/checkall.js"),
            includeScript("www/js/uncheckall.js"),
            includeScript("http://d3js.org/topojson.v1.min.js"),
            includeScript("http://d3js.org/d3.v3.min.js"),
            includeScript("www/js/map.js")
        ),
        titlePanel("Goodreads Analysis"),
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
                        tabPanel("By Age Group",plotOutput("age_plot")),
                        tabPanel("By Location",uiOutput("location_ui"))
                )
            
        ),
        div(id="map", class="hidden")
))