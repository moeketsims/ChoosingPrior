
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
                 sidebarPanel(width = 2,
                   fluidRow(
                     column(12,
                            SliderUI("hist1"))
                   )
                 ),
                 mainPanel(
                  fluidRow(
                    column(5,
                           plotOutput("distplot1")
                    ),
                    column(2,
                           helpText('
                              $$
                                p(\\theta|data) = \\frac{p(data|\\theta)p(\\theta)}{p(data)}
                              $$'
                           )
                    ),
                    column(5,
                           plotOutput("distplot2")
                    )
                  )
                 )
               )
            )
    )
    
  )
  server <- function(input, output, session){
    data <- SliderServer("hist1")
    
    output$distplot1 <- renderPlot({
      ggplot(data(), aes(x, y))+
        geom_line()+
        labs(x=bquote(~ theta), y = "Density", title = "Beta(a,b)")+
        theme_light()+
        theme(axis.title.x = element_text(size = 20))+
        theme(plot.title = element_text(hjust = 0.5))
    })
    
    output$distplot2 <- renderPlot({
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




