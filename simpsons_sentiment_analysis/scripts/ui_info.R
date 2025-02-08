fluidPage(
  # fluidRow(
    # column(
    #   width = 12,
      # 
      # absolutePanel(
      #   id = "info_window", 
      #    fixed = TRUE,
      #    draggable = TRUE,
      #    hidden = TRUE,
      #   
        
        tabsetPanel(
          tags$img(src = "tv.png", style = "width:100%; height:auto; display:block"),
          
          
          tabPanel(
            icon = icon("desktop"),
            title = "About App",
            
            div(class = "info_window_content", 
                style = " position: absolute;
                          top: 50%;
                          left: 45%;
                          transform: translate(-50%, -50%);
                          color: black;
                          text-align: center;
                          font-size: 24px;
                          font-weight: bold;",
                
            div(style="text-align:justify",
            HTML("
            
              <h4>
                An app, with 4 different sections, that aims to find the feelings 
                and emotions of the main Simpsons characters.
                
                <br><br>
                
                 <i class='fa-solid fa-database'></i>  Data source: <a href='https://www.kaggle.com/datasets/prashant111/the-simpsons-dataset?resource=download' target='_blank'> click here</a>
                
              </h4>
              <hr>
              
              <div style = 'color:grey'>
              <h4>
                Sentiment Analysis, it tries to find the sentiment of words and 
                of text as a whole, this can be as simple as positive/negative, 
                or emotions like fear and disgust.
                
                <br><br>
                
                Note: <i>Sentiment analysis is not an exact science, the results may not make sense 
                in context, so always should be made an analysis with some healthy skepticism. A 
                common problem is negation. An example, 'Word-based sentiment analysis does not 
                perform well'. While the word 'well' is positive by itself, it has a negative
                meaning if combined with not. </i>
              </h4>
              </div>
         ")
        )
      )
    ),
          
          tabPanel(
            icon = icon("user"),
            title = "About Developer",
            
            div(class = "info_window_content", 
                style = "
                          position: absolute;
                          top: 50%;
                          left: 45%;
                          transform: translate(-50%, -50%);
                          color: black;
                          text-align: center;
                          font-size: 24px;
                          font-weight: bold;",
                
                h1("João Neto", style = "margin-top:0px"),
                hr(style = "margin-top:5px; margin-bottom: 5px"),
                h4("Automation & Control Systems Engineer"),
                h4(" Data Scientist"),
                tags$a(
                  href="https://www.linkedin.com/in/joaonetoprofile", target="_blank",
                  tags$img(src="linkedin_icon.png", alt = "visit me", style='width:40px; height:40px; justify-content:center')
                )
            )
          )
        )
        
  )
   
  
  
# )