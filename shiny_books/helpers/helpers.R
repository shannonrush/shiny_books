source("helpers/ui_helpers.R")
source("helpers/string_helpers.R")
source("helpers/plot_helpers.R")

MonthsInRange <- function(daterange) {
    round(as.numeric(as.duration(interval(daterange[1],daterange[2]))) / (3600*24*30))
}

UseDates <- function(data, dates) {
    if (MonthsInRange(dates) > 12) {
        data$monthadded
    } else {
        data$dateadded
    } 
}

GetDates <- function(inputdates) {
    if (length(inputdates)==0) {
        as.Date(c("2006-10-02", "2014-02-05"))
    } else {
        as.Date(inputdates)
    }
}








