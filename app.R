source("utils/modules_script.R")
library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)
DistplotApp <- function(){
  ui <- fluidPage(
    headerPanel(h1("Probabilistic Machine Learning Models", align = "center")),
    titlePanel("Beta(a,b)"),
    HistoramUI("hist1")
  )
  server <- function(input, output, session){
    HistoramServer("hist1")
  }
  shinyApp(ui, server)
}
DistplotApp()
