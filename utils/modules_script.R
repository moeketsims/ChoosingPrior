
SliderUI <- function(id){
  tagList(
    chooseSliderSkin("Modern"),
    sliderInput(NS(id,"a"), "Select: a", min = 0, max = 10, value = 1),
    sliderInput(NS(id,"b"), "Select: b", min = 0, max = 10, value = 1)
  )
}


SliderServer <- function(id){
  moduleServer(id,
               function(input, output, session){
                 data <- reactive({
                   x <- seq(0,1,length=200)
                   y <- dbeta(x, input$a, input$b)
                   df <- data.frame(x=x, y=y)
                   return(df) 
                   })

               }
             )
}

