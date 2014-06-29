CheckBoxButton <- function(inputId, class, name, text) {
    tagList(
        tags$button(id = inputId,
                    class = paste(class,"btn"),
                    type = "button",
                    name = name,
                    text)
    )
}
