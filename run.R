library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)
library(graphics)
library(purrr)
library(DT)
library(shinydashboard)
port <- Sys.getenv('PORT')
shiny::runApp(
  appDir = getwd(),
  host = '0.0.0.0',
  port = as.numeric(port)
)
