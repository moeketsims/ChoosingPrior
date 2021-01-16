
DataInput <- function(id){
 tagList(
   numericInput(NS(id, "sample_size"), label = "Enter Sample Size:", value = 100),
   numericInput(NS(id, "p"), label = "Enter Parameter:", value = 0.5),
   actionBttn(NS(id, "gen"), label = "Simulate")
 )
}


DataServer <- function(id){
  moduleServer(id,
               function(input, output, session){
                 df <- reactive({
                    df <- rbernoulli(input$sample_size, input$p)
                    df <- data.frame(a=1:input$sample_size, b=df)
                    return(df)
                 })
               }
               )
}















