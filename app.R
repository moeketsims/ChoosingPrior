

DistplotApp <- function(){
  source("utils/modules_script.R")
  library(shiny)
  library(ggplot2)
  library(dplyr)
  library(shinyWidgets)
  require(graphics)
  
  ui <- fluidPage(
    
    includeCSS("www/styles.css"),
    #img(src='www/BYS.PNG', align = "right"),
    withMathJax(),
    titlePanel(tags$i(
      h1(strong("Probabilistic Machine Learning: Assuming Prior of Parameters"), 
         style = "font-family: 'times'; font-size: 25px; text-align: center")
    )),
    align = "center",
    navbarPage(
      theme = "https://stackpath.bootstrapcdn.com/bootswatch/3.4.1/flatly/bootstrap.min.css",
      title = 'Choosing a Priors',
      tabPanel('Beta Prior',
               HistoramUI("hist1")),
       tabPanel('Dirichlet Prior',
                h1("To be added")),
      tabPanel('Gaussian Prior',
               h1("To be added")
               )
    ),
    
  )
  server <- function(input, output, session){
    HistoramServer("hist1")
  }
  shinyApp(ui, server)
}
DistplotApp()
