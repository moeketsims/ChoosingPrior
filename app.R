
DistplotApp <- function(){
  source("utils/modules_script.R")
  library(shiny)
  library(ggplot2)
  library(dplyr)
  library(shinyWidgets)
  require(graphics)
  
  ui <- fluidPage(
    includeCSS("www/styles.css"),
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
               sidebarLayout(
                 sidebarPanel(
                   SliderUI("hist1")
                 ),
                 mainPanel(
                   plotOutput("distplot")
                 )
               )
            )
    )
    
  )
  server <- function(input, output, session){
    data <- SliderServer("hist1")
    
    output$distplot <- renderPlot({
      ggplot(data(), aes(x, y))+
        geom_line()+
        labs(x=bquote(~ theta), y = "Density", title = "Beta(a,b)")+
        theme_light()+
        theme(axis.title.x = element_text(size = 20))+
        theme(plot.title = element_text(hjust = 0.5))
    })
  }
  shinyApp(ui, server)
}

DistplotApp()




