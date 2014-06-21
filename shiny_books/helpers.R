MonthsInRange <- function(daterange) {
    round(as.numeric(as.duration(interval(daterange[1],daterange[2]))) / (3600*24*30))
}