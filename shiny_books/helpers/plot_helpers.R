GenrePlot <- function(data) {
    p <- ggplot(data, aes(x=usedates, y=counts, color=genre, group=genre))
    l <- p + xlab("Date Added")+ylab("Number Added")+ggtitle("Genre Popularity Over Time")
    t <- l + DefaultTheme()
    t + geom_line()
}

GenderPlot <- function(data, genre) {
    p <- ggplot(data, aes(x=usedates, y=counts, color=gender, group=gender)) 
    title <- paste(ToCaps(genre),"Popularity By Gender")
    l <- p + xlab("Date Added")+ylab("Number Added")+ggtitle(title)
    t <- l + DefaultTheme()
    s <- t + scale_colour_discrete(name = "",
                                   labels=c("Not Specified","Female","Male"))
    s + geom_line()
}

AgePlot <- function(data, genre) {
    p <- ggplot(data, aes(x=usedates, y=counts, color=binnedages, group=binnedages))
    title <- paste(ToCaps(genre),"Popularity By Age Group")
    l <- p + xlab("Date Added")+ylab("Number Added")+ggtitle(title)
    t <- l + DefaultTheme()
    s <- t + scale_colour_discrete(name = "",
                                   labels=c("Under 20","21-30","31-40","41-50","51-60",
                                            "61-70","71-80","81-90","Over 90"))
    s + geom_line()
}

DefaultTheme <- function() {
    theme(plot.title = element_text(lineheight=40, size=20, face="bold", vjust=1),
          axis.title = element_text(size=17),
          axis.text = element_text(size=15))
}