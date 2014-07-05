shinyUI(
    fluidPage(
        tags$head(
            tags$link(rel="stylesheet", type="text/css", href="css/application.css"),
            tags$link(rel="stylesheet", type="text/css", href="css/location.css"),
            tags$script(src="js/checkall.js", type="text/javascript"),
            tags$script(src="js/uncheckall.js", type="text/javascript"),
            tags$script(src=paste0("https://maps.googleapis.com/maps/api/js?key=",google_maps_key),
                                   type="text/javascript"),
            tags$script(src="js/location_data.js", type="text/javascript"),
            tags$script(src="js/location.js", type="text/javascript")
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
                        tabPanel("Genres", plotOutput("genres_plot")),
                        tabPanel("By Gender", plotOutput("gender_plot")),
                        tabPanel("By Age Group", plotOutput("age_plot")),
                        tabPanel("By Location", uiOutput("location_ui"))
                )
        ),
        div(id="map", class="span9", style="visibility:hidden")
))

