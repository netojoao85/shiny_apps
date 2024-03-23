
ui <- fluidPage(
  
  actionButton("articles_button", 
               div(
                 class = "articles_button",
                 tags$img(
                   src = "images/articles/data-ethics.jpg", 
                   height = "120px", 
                   width = "200px"),
                 
                 div(
                   class = "text",
                   h1("> Data Ethics, Privacy, and Bias"),
                   br(),
                   h4("This text will introduce concepts about practical
                      ethical issues in data science by exploring topics such 
                      as privacy and accountability. Biases in data will also 
                      be touched upon.")
                 )
               )
  ),
  
  br(),
  br(),
  
  actionButton("articles_button_one",
               div(
                 class = "articles_button",
                 tags$img(
                   src = "images/articles/web-scraping.png", 
                   height = "120px", 
                   width = "200px"),
                 
                 div(
                   class = "text",
                   h1("> Web Scraping & REST APIs"),
                   br(),
                   h4("A literature review based on scientific papers and books
                      about the theme for a higher awareness of steps and 
                      decisions to take under good practice.")
                 )
               )
  )
  
)









