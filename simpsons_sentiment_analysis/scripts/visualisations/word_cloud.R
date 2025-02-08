output$wordcloud <- renderPlot({
  
  filtered_wc <- filtered_data()
  
  if (input$in_wc_sentiment != "All") {
    filtered_wc <- filtered_wc[filtered_wc$sentiment_nrc == input$in_wc_sentiment, ]
  }

  word_cloud <- filtered_wc %>%
    # filter(character == "Homer Simpson") %>% 
    group_by(word, sentiment_nrc) %>% 
    summarise(n = n()) %>% 
    drop_na() %>% 
    arrange(desc(n))
  
  ggwordcloud(
    words = word_cloud$word,
    freq = word_cloud$n,
    scale = c(8, 0.5), 
    min.freq = 30,
    max.words = 100
    #max.words = Inf,   
    #random.order = TRUE,
    #random.color = TRUE,
    # ordered.colors = TRUE
    # colors = c("#005FE7", "#FFDE00", "#B7E4A2", "#DF8470", "#232423")
  )

})