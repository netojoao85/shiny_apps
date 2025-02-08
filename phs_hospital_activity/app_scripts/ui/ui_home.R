
fluidPage(
  
  
  #  PHS image --------------------------------------------------------------
  
  fluidRow(
    style = "text-align:center; margin-bottom: 30px;",
    
    tags$a(
      href = "", target = "_Blank",
      img(src = "images/phs_logo.png", height = "150px")
    )
    
  ),
  
  
  # Info text ---------------------------------------------------------------
  
  h4(
    style = "text-align:center",
    "Hover each option to know what information each provides."
  ),
  
  
  # Buttons Stack -----------------------------------------------------------
  
  fluidRow(
    style = "text-align:center",
    
    column(width = 12,
           
           actionButton(
             inputId = "about",
             icon = icon("info-circle"),
             HTML(
               "About App <br> 
          <span class='hover-text'> @ Data Source, Data Quality & Bias, Ethical considerations, and Developer </span>")
           )
    ),
    
    column(width = 12,
           
           actionButton(
             inputId = "length",
             icon = icon("chart-line"),
             HTML(
               "Stay of Lengths <br> 
               <span class='hover-text'> @ Reports, Visualisations, Dasboards, Web Development Apps </span>")
           )
    ), 
    column(width = 12,
           
           actionButton(
             inputId = "beds",
             icon = icon("bed"),
             HTML(
               "Beds Occupancy <br> 
                <span class = 'hover-text'> @ Explore</span>")
           )
           
    ),
    column(width = 12,
           
           actionButton(
             inputId = "covid",
             icon = icon("virus"),
             HTML(
               "Covid Admissions <br> 
               <span class = 'hover-text'> @ Published articles</span>")
           )
           
    )
    
  )
  
)

