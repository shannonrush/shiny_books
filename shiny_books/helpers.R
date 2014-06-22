MonthsInRange <- function(daterange) {
    round(as.numeric(as.duration(interval(daterange[1],daterange[2]))) / (3600*24*30))
}

CheckBoxButton <- function(inputId, class, text) {
    tagList(
        tags$button(id = inputId,
                    class = paste(class,"btn"),
                    type = "button",
                    text)
    )
}

ToCaps <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep="", collapse=" ")
}