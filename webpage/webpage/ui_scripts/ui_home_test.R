

h1(id = "title", "João Neto_") 


tags$table(
  
              tags$tr(
  
                tags$td(
                  actionButton(
                    inputId = "button1",
                    HTML("  > About <br/> <span class='hover-text'> Tech Skills, Work Experience, Education, Hobbies </span>"))
                ),
                tags$td(
                  actionButton(
                    inputId = "button2",
                    HTML("  > Data Analysis<br/><span class='hover-text'> Reports, Visualisations, Dasboards, Web Development Apps </span>"))
                )
              ),
  
  
            tags$tr(
  
                tags$td(
                  actionButton(
                    inputId = "button3",
                    HTML("  > Python Development<br/><span class='hover-text'>Explore</span>"))
                ),
                tags$td(
                  actionButton(
                    inputId = "button4",
                    HTML("  > Articles<br/><span class='hover-text'>Published articles</span>"))
                )
              )
            )


# 
# fluidRow(
#   
#   column(width = 4,
#          # class = "col-md-6", # Adjust column width for medium-sized screens (col-md-*)
#          
#          tags$table(
#            
#            tags$tr(
#              
#              tags$td(
#                actionButton(
#                  inputId = "button1", 
#                  HTML("  > About <br/> <span class='hover-text'> Tech Skills, Work Experience, Education, Hobbies </span>"))
#              ),
#              tags$td(
#                actionButton(
#                  inputId = "button2", 
#                  HTML("  > Data Analysis<br/><span class='hover-text'> Reports, Visualisations, Dasboards, Web Development Apps </span>"))
#              )
#            ),
#            
#            
#            tags$tr(
#              
#              tags$td(
#                actionButton(
#                  inputId = "button3", 
#                  HTML("  > Python Development<br/><span class='hover-text'>Explore</span>"))
#              ),
#              tags$td(
#                actionButton(
#                  inputId = "button4",
#                  HTML("  > Articles<br/><span class='hover-text'>Published articles</span>"))
#              )
#            )
#          )
#   )
#   
# 
# )




