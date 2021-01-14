library(shiny)
library(ggplot2)
library(dplyr)
HistoramUI <- function(id){
  tagList(
    sidebarLayout(
      sidebarPanel(
        column(12,
          chooseSliderSkin("Flat", color = "#112446"),
          sliderInput(NS(id, "a"), "Select: a", min = 0, max = 10, value = 1, step = 1),
          sliderInput(NS(id, "b"), "Select: b", min = 0, max = 10, value = 1, step = 1)
        )
      ),
      mainPanel(
        column(6,
               plotOutput(NS(id, "distplot"))
               )
      )

    )
  )
}
HistoramServer <- function(id){
  moduleServer(id,
               function(input, output, session){
                 data <- reactive({
                   x <- seq(0,1,length=200)
                   y <- dbeta(x, input$a, input$b)
                   df <- data.frame(x=x, y=y)
                   df
                 })
                 output$distplot <- renderPlot({
                   data() %>% ggplot(aes(x, y))+
                     geom_line()+
                     labs(x="theta", y = "Density", title = paste0("Beta(",input$a,",",input$b,")"))+
                     theme_light()+
                     theme(plot.title = element_text(hjust = 0.5))
                   })
               }
               )
}
