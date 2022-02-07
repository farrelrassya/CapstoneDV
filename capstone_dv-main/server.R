
library(shiny)


shinyServer(function(input, output) {

#-------- Page 2 Plot 1
    output$plot1 <- renderPlotly({
      ispu_lolipop <- 
        ispu_case1 %>% 
        filter(stasiun == input$stasiun_id) %>% 
        select(stasiun, Parameter_Polutan, Total) %>%
        group_by(Parameter_Polutan) %>% 
        mutate(Parameter_Polutan = as.factor(Parameter_Polutan)) %>% 
        summarise(mean_parameter = mean(Total)) %>%
        arrange(mean_parameter, Parameter_Polutan) %>% 
        ungroup()
      
      ispu_plot1 <-
        ispu_lolipop %>% 
        ggplot(aes(x = mean_parameter, 
                   y = reorder(Parameter_Polutan, mean_parameter),
                   text = glue("Average Particle: {mean_parameter}"))
        )+
        geom_segment(aes(yend = Parameter_Polutan,
                         xend = 0),
                     col = "orange")+
        geom_point(col = "yellowgreen", size = 2.5)+
        labs(title = "Average Pollutant Parameters per DKI Jakarta Station",
             y = "Pollutant Parameters",
             x = "Average Particle (µgram/m3)")+
        theme(legend.position = "none")
      
      ggplotly(ispu_plot1, tooltip = "text")
    })

#-------------Page 2 Plot 2    
  output$plot2 <- renderPlotly({
    options(dplyr.summarise.inform = FALSE)
    
    ispu_case2 <-
      ispu %>%
      select(stasiun, tanggal, max) %>%
      group_by(tanggal) %>% 
      summarise(sum_max = sum(max)) %>% 
      arrange(-sum_max) %>% 
      ungroup()
    
    ispu_bar3 <- 
      ispu_case2 %>% 
      ggplot(aes(x = tanggal, 
                 y = sum_max,
                 text = glue("{sum_max}")))+
      geom_bar(stat = "identity",
               width = 0.5,
               fill = "tomato")+
      scale_fill_brewer("Set1")+
      labs(title = "Total Category of Air Pollutant Standard Index each day",
           x = "Date",
           y = "Total")+
      theme_minimal()
    
    ggplotly(ispu_bar3, tooltip = "text")
  })
  
  
  #----------Page 3 Data 
  output$data_ispu <- DT::renderDataTable({
    DT::datatable(ispu)
  })


})
