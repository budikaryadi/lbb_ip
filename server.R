shinyServer(function(input,output){
  
  # menu 1---
  ## output untuk plot pada bagian menu 1  
  
  ## mempersiapkan sebuah output id untuk ditampilkan ke bagiaan UI 
  ## renderPlotly({}), digunakan untuk melakukan rendering visualisasi
  output$plot_1 <- renderPlotly({
    covids_sum <- covids_clean %>% 
      group_by(benua) %>% 
      summarise(sum_benua = sum(total_kasus)) %>% 
      ungroup() %>% 
      arrange(desc(sum_benua))
    
    covids_sum <- 
      covids_sum %>% 
      mutate(label = glue("Benua: {benua}
                      Total :  {scales::comma(sum_benua)}"))
    
    plot1 <- 
      covids_sum %>% 
      ggplot(mapping = aes(y = reorder(benua, sum_benua),
                           x = sum_benua,
                           fill = sum_benua,
                           text = label)) + # tambahan parameter text
      geom_col() +
      scale_fill_gradient(low = "red",
                          high = "green") +
      labs(title = "Benua ",
           x = "Total Kasus", 
           y = NULL) +
      scale_x_continuous(labels = label_number(big.mark = ".")) +
      theme_light() +
      theme(legend.position = "none",
            text = element_text(size = 6, face="bold"),
            axis.text.y = element_text(size=8, face="bold", colour = "black"),
            axis.text.x = element_text(size=8, face="bold", colour = "black"))  
    
    ggplotly(p = plot1, 
             tooltip = "text")
  })
  
  ## renderPlotly({}), digunakan untuk melakukan rendering visualisasi
  output$plot_11 <- renderPlotly({
    covids_sum_dead <- covids_clean %>% 
      group_by(benua) %>% 
      summarise(sum_benua_dead = sum(total_kematian)) %>% 
      ungroup() %>% 
      arrange(desc(sum_benua_dead))
    
    covids_sum_dead <- 
      covids_sum_dead %>% 
      mutate(label = glue("Benua: {benua}
                      Total :  {scales::comma(sum_benua_dead)}"))
    
    plot11 <- 
      covids_sum_dead %>% 
      ggplot(mapping = aes(y = sum_benua_dead,
                           x = reorder(benua, sum_benua_dead),
                           fill = sum_benua_dead,
                           text = label)) + # tambahan parameter text
      geom_col() +
      scale_fill_gradient(low = "red",
                          high = "green") +
      labs(title = "Total Kasus ",
           x = "Benua", 
           y = NULL) +
      scale_y_continuous(labels = label_number(big.mark = ".")) +
      theme_light() +
      theme(legend.position = "none",
            text = element_text(size = 6, face="bold"),
            axis.text.y = element_text(size=8, face="bold", colour = "black"),
            axis.text.x = element_text(size=8, face="bold", colour = "black"))  
    
    ggplotly(p = plot11, 
             tooltip = "text")
  })
  
  # menu 2---
  ## output untuk plot pada bagian menu 2
  
  output$plot_2 <- renderPlotly({
    
    covids_top_cases <- 
      covids_clean %>% 
      filter(benua %in% input$input_benua) %>% 
      group_by(negara) %>% 
      summarise(sum_kasus = sum(total_kasus)) %>% 
      arrange(-sum_kasus) %>% 
      head(10) %>% 
      mutate(label = glue("Negara: {negara}
                           Total Kasus: {scales::comma(sum_kasus)}"))
    
    plot2 <- 
      ggplot(data = covids_top_cases, mapping = aes(x = sum_kasus, 
                                                    y = negara,
                                                    color = sum_kasus,
                                                    text = label)) +
      geom_segment(mapping = aes(x = 0, xend = sum_kasus, 
                                 y = reorder(negara, sum_kasus), yend = negara)) +
      geom_point() +
      scale_color_gradient(low = "red", high = "green") +
      scale_x_continuous(labels = label_number(big.mark = ".")) +
      labs(x = 'Total Kasus',
           y = NULL,
           title = paste('10 Negara Teratas Total Kasus Positif Covid19', input$input_benua)) +
      theme_minimal() +
      theme(legend.position = "none") +
      theme(text = element_text(size = 6, face="bold"),
            axis.text.y = element_text(size=8, face="bold", colour = "black"),
            axis.text.x = element_text(size=8, face="bold", colour = "black"))
    
    ggplotly(p = plot2, tooltip = "text")
    
  }
  )
  
  # menu 3---
  ## output untuk plot pada bagian menu 3
  
  output$plot_3 <- renderPlotly({
    
    covids_deads <- 
      covids_clean %>% 
      filter(benua %in% input$input_benua) %>% 
      group_by(negara) %>% 
      summarise(sum_deads = sum(total_kematian)) %>% 
      arrange(-sum_deads) %>% 
      head(10) %>% 
      mutate(label = glue("Negara: {negara}
                     Total Kasus Kematian: {scales::comma(sum_deads)}"))
    
    
    
    plot3 <- 
      covids_deads %>% 
      ggplot(mapping = aes(y = reorder(negara, sum_deads),
                           x = sum_deads,
                           fill = sum_deads,
                           text = label)) + # tambahan parameter text
      geom_col() +
      scale_fill_gradient(low = "red",
                          high = "green") +
      labs(x = 'Total Kasus',
           y = NULL,
           title = paste('10 Negara Teratas Total Kasus Kematian Covid19', input$input_benua)) +
      scale_x_continuous(labels = label_number(big.mark = ".")) +
      theme_light() +
      theme(legend.position = "none",
            text = element_text(size = 6, face="bold"),
            axis.text.y = element_text(size=8, face="bold", colour = "black"),
            axis.text.x = element_text(size=8, face="bold", colour = "black"))  
    
    ggplotly(p = plot3, 
             tooltip = "text")
    
    
  }
  )
  
  ## renderDataTable({}), digunakan untuk melakukan rendering dataframe
  output$table <- renderDataTable({
    
    datatable(covids_clean,
              options = list(scrollX = TRUE))
    
  })
  
}
)









