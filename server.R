function(input, output, session){
  
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
    #--------------------------------------------------------------------------------------------
    df_data <- reactive({
      df <- data.frame(Task1 = as.numeric(rbernoulli(input$enrollement, input$t1)),
                       Task2 = as.numeric(rbernoulli(input$enrollement, input$t2)))
      return(df)
    })
    
    output$tasks <- renderTable(head(df_data(),15))
    
    LA_data_density <- reactive({
      x <- seq(0,1,length=input$enrollement)
      y <- dbeta(x, input$a_prior, input$b_prior)
      df <- data.frame(x=x, y=y)
      return(df)
    })
    
    output$prior_plot <- renderPlot({
      ggplot(LA_data_density(), aes(x, y))+
        geom_line()+
        labs(x=bquote(~ theta), y = "Density", title = "Encoding Our Belief:Prior")+
        theme_light()+
        theme(axis.title.x = element_text(size = 20))+
        theme(plot.title = element_text(hjust = 0.5))
    })
    
    
    LA_df <- reactive({
      
      n1 <- length(which(df_data()$Task1==1))
      n0 <- input$enrollement - n1
      
      x <- seq(0,1,length=input$enrollement)
      y <- dbeta(x, input$a_prior + n1, input$b_prior + n0)
      
      beta_mode <- (input$a_prior + n1 - 1)/(input$a_prior + n1 + input$b_prior + n0 - 2)
      
      beta_var <- ((input$a_prior+n1)*(input$b_prior+n0))/(((input$a_prior+n1)+(input$b_prior+n0))^2 * ((input$a_prior+n1) + (input$b_prior+n0) -1))
      df <- data.frame(x=x, y=y)
      
      return(list(df,round(beta_mode,2),round(beta_var,2)))
    })
    
    output$dis <- renderPlot({
      ggplot(LA_df()[[1]], aes(x, y))+
        geom_line()+
        labs(x=bquote(~ theta), y = "Density", title = "Posterior")+
        geom_vline(xintercept=LA_df()[[2]], size=1.5, color="red")+
        geom_text(aes(x=LA_df()[[2]]+0.09, label=paste0("Mean:",LA_df()[[2]]), y=10))+
        theme_light()+
        theme(axis.title.x = element_text(size = 20))+
        theme(plot.title = element_text(hjust = 0.5))
    })
    
  }