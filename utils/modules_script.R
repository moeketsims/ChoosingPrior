HistoramUI <- function(id){
  tagList(
    sidebarLayout(
      sidebarPanel(width = 2,
        fluidRow(
          column(12,
                 chooseSliderSkin("Modern"),
                 sliderInput(NS(id, "a"), "Select: a", min = 0, max = 10, value = 1, step = 1),
                 sliderInput(NS(id, "b"), "Select: b", min = 0, max = 10, value = 1, step = 1)
          )
        )
      ),
      mainPanel(width = 10,
        column(5,
               plotOutput(NS(id, "distplot"))
               ),
        
        column(7,
               helpText('In the Bayesian Machine learning (BML) framework, we use subjective probability to quantify/encode 
               our belief about the world before seeing evidence(data). 
               For instance, when modelling a binary outcome data = \\(\\{0,1\\}_{i=1}^{n}\\), we assume a 
               Bernoulli likelihood Bern(\\(\\theta\\)) where \\(\\theta\\) is a probability of success 
               (e.g. completed a task denoted by 1 and not completed by 0). Thus, in BML we acknowledge that, we know something about the world we are model. 
               For example, we may believe that students are likely to complete a qualification and thus, this prior 
               belief can be quantified by the Beta(a,b) density plot on the left. This belief can be seen by choosing a value of  
               \\(a > b\\)
                  ')

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
                     labs(x=bquote(~ theta), y = "Density", title = paste0("Beta(",input$a,",",input$b,")"))+
                     theme_light()+
                     theme(axis.title.x = element_text(size = 20))+
                     theme(plot.title = element_text(hjust = 0.5))
                   })
               }
               )
}
