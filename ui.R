source("utils/installpackagies.R")
fluidPage(
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