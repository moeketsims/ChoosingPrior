library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)
library(graphics)
library(purrr)
library(DT)
library(shinydashboard)
library(shinydashboardPlus)

fluidPage(
  includeCSS("www/styles.css"),
  withMathJax(),
  #useShinydashboard(),
  useShinydashboardPlus(),
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
                                    sliderInput("a", "Select: a", min = 0, max = 100, value = 1, step = 0.1),
                                    sliderInput("b", "Select: b", min = 0, max = 100, value = 1, step = 0.1)
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
    ),
    tabPanel('Beta-Bernoulli Model in Learning Analytics',
             sidebarLayout(
               sidebarPanel(width=3,
                            fluidRow(
                              box(width = 12, title = "Number of Students Registered for a Course/Module",background = "olive",
                                  numericInputIcon("enrollement", label = "Number of Students:",
                                                   value = 100, icon = list("Sample Size"), min = 0, step = 5)
                              )
                            ),
                            fluidRow(
                              box(width=12, title = "Generate Data",background = "olive",
                                  chooseSliderSkin("Nice"),
                                  sliderInput("t1", "Probability of Clicking TASK 1", min = 0, max = 1, value = 0.70),
                                  sliderInput("t2", "Probability of Clicking TASK 2", min = 0, max = 1, value = 0.40)

                              ),
                              boxPlus(width = 12,title = "Prior of Parameters",
                                      sliderInput("a_prior", "Select: a", min = 0, max = 100, value = 1),
                                      sliderInput("b_prior", "Select: b", min = 0, max = 100, value = 1)
                                      )
                            )
                            ),
               mainPanel(
                 fluidRow(
                   column(3,
                          fluidRow(
                            tableOutput('tasks')
                          )
                   ),
                   column(5,
                          fluidRow(
                            boxPlus(
                              width = 12,
                              title = "Prior", 
                              closable = FALSE, 
                              status = "warning", 
                              solidHeader = FALSE, 
                              collapsible = FALSE,
                              enable_sidebar = FALSE,
                              sidebar_width = 25,
                              sidebar_start_open = FALSE,
                              sidebar_content = tagList(
                                sliderInput("a_prior", "Select: a", min = 0, max = 100, value = 0.40),
                                sliderInput("b_prior", "Select: b", min = 0, max = 100, value = 0.40)
                              ),
                              plotOutput("prior_plot", width = 235, height = 250),
                              plotOutput("dis", width = 235, height = 250)
                            )
                          )
                          ),
                   column(1,
                          "Moeketsi"
                         
                   )
                 )
               ))
             
             )
  )
  
)