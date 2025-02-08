fluidPage(
  
  fluidRow(
    column(width = 6,
           
           div(class = "analysis_section",
               
               div(
                 style="float:left; width:60%; margin:0px; padding:0px",
                 h3("Volume of Enterprises")
               ),
               div(
                 style="float:left;  width:40%; margin:0px; padding:0px;
                                display: flex; justify-content: center; align-items:center;",
                 
                 radioButtons(
                   inputId = "in_volume", 
                   label = "Type", 
                   choices = c("Bar Chart", "GIS"), 
                   inline = TRUE
                 )
                 
               )
           ),
           uiOutput("dynamic_plot")
    ),
    
    column(width = 6,
           
           div(class = "analysis_section",
               h3("Type of Enterprises"),
           ),
           
           
           plotlyOutput("plot_type", height = "500px")
    )
  )
  
)