library(shiny)
library(ggplot2)
library(lubridate)
library(dplyr)
library(Hmisc)
library(RJSONIO)
library(RColorBrewer)

source("helpers/helpers.R")
load("data/genre_data.Rdata")

col <- c(brewer.pal(12, "Paired"),brewer.pal(12,"Set3"))
pal <- colorRampPalette(col)
map.colors <- pal(28)

