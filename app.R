
DistplotApp <- function(){
  library(shiny)
  library(ggplot2)
  library(dplyr)
  library(shinyWidgets)
  require(graphics)
  library(purrr)
  library(DT)
  library(shinydashboard)
  
  ui <- fluidPage(
    includeCSS("www/styles.css"),
    withMathJax(),
    useShinydashboard(),
    titlePanel(tags$i(
      h1(strong("Probabilistic Machine Learning"), 
         style = "font-family: 'times'; font-size: 25px; text-align: center")
    )),
    align = "center",
    navbarPage(
      theme = "https://stackpath.bootstrapcdn.com/bootswatch/3.4.1/flatly/bootstrap.min.css",
      title = 'Probabilistic Programming',
      tabPanel('Beta-Bernoulli Model',
               sidebarLayout(
                 sidebarPanel(width = 2,
                   fluidRow(
                     column(12,
                            fluidRow(
                              box(width = 12, title = "Bernoulli",background = "olive",
                                  numericInputIcon("sample_size", label = "Enter Sample Size:",
                                                   value = 100, icon = list("n"), min = 0, step = 5),
                                  numericInputIcon("p", label = "Enter Parameter:",
                                                   value = 0.5, icon = list("prob"), 
                                                   min = 0, max = 1, step = 0.1),
                              )
                            )
                   ),
                   fluidRow(
                     box(width=12, title = "Prior: Beta(a,b)",background = "olive",
                         chooseSliderSkin("Nice"),
                         sliderInput("a", "Select: a", min = 0, max = 10, value = 1),
                         sliderInput("b", "Select: b", min = 0, max = 10, value = 1)
                     )
                   )
                   )
                 ),
                 mainPanel(
                    column(3,
                           fluidRow(
                             tableOutput('table')
                           )
                           ),
                    column(9,
                           fluidRow(
                             column(5,
                                   plotOutput("distplot1", width =340, height = 340)
                             ),
                             column(2),
                             column(5,
                                    plotOutput("distplot2", width =340, height = 340)
                                    
                             )
                           )
                        ),
                    column(width = 12,
                      fluidRow(
                        column(width = 9,align="centre",
                               textOutput("inference")
                               ),
                        column(3,align="right",
                               actionBttn("sim","Inference Button!")
                               ),
                      )
                    )
                 )
               )
            )
    )
    
  )
  server <- function(input, output, session){
    
    df_bernuolli <- reactive({
      df <- data.frame(Simulated = as.numeric(rbernoulli(input$sample_size, input$p)))
      return(df)
    })
    
    output$table <- renderTable(head(df_bernuolli(),11))
    
    beta_density <- reactive({
      x <- seq(0,1,length=200)
      y <- dbeta(x, input$a, input$b)
      df <- data.frame(x=x, y=y)
      return(df)
    })
    
    output$distplot1 <- renderPlot({
      ggplot(beta_density(), aes(x, y))+
        geom_line()+
        labs(x=bquote(~ theta), y = "Density", title = "Encoding Our Belief:Prior")+
        theme_light()+
        theme(axis.title.x = element_text(size = 20))+
        theme(plot.title = element_text(hjust = 0.5))
    })
    
    
    daf <- reactive({
      
      n1 <- length(which(df_bernuolli()==1))
      n0 <- nrow(df_bernuolli()) - n1
      
      x <- seq(0,1,length=200)
      y <- dbeta(x, input$a + n1, input$b+n0)
      beta_mode <- (input$a + n1 - 1)/(input$a + n1 + input$b+n0 - 2)
      beta_var <- ((input$a+n1)*(input$b+n0))/(((input$a+n1)+(input$b+n0))^2 * ((input$a+n1) + (input$b+n0) -1))
      df <- data.frame(x=x, y=y)
      
      return(list(df,round(beta_mode,3),round(beta_var,3)))
    })
    
     observeEvent(input$sim,{
       output$inference <- renderText(paste0("Parameter estimation is ",daf()[[2]]))
    }
                 )
    
    output$distplot2 <- renderPlot({
      ggplot(daf()[[1]], aes(x, y))+
        geom_line()+
        labs(x=bquote(~ theta), y = "Density", title = "Posterior")+
        geom_vline(xintercept=daf()[[2]], size=1.5, color="red")+
        geom_text(aes(x=daf()[[2]]+0.09, label=paste0("Mean:",daf()[[2]]), y=10))+
        theme_light()+
        theme(axis.title.x = element_text(size = 20))+
        theme(plot.title = element_text(hjust = 0.5))
    })
    
    
  }
  shinyApp(ui, server)
}

DistplotApp()




