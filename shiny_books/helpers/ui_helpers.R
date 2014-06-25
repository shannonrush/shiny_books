CheckBoxButton <- function(inputId, class, text) {
    tagList(
        tags$button(id = inputId,
                    class = paste(class,"btn"),
                    type = "button",
                    text)
    )
}
