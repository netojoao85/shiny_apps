fluidRow(class = "header",
         column(class = "border", width = 1),
         
         column(width = 10,
                
                fluidRow(style= "height:25px; background:#11BBA1; border-radius: 50px 50px 0px 0px; margin: 0px; padding:0px;
                           display:flex; align-items:center; justify-content:center",
                         
                         column(width = 4, paste0(lubridate::hour(Sys.time()),":", lubridate::minute(Sys.time()))),
                         column(width = 8, style = "text-align: end;",
                                icon("wifi"), 
                                icon("battery-three-quarters", style = "margin-left: 10px")
                         )
                ),
                
                
                span(
                  h3(icon("running"), "Running Calculator", style = "font-weight: bold; padding-left: 20px; margin:15px 0px 0px 0px; display:inline-block;"),
                  img(src = "me.png", style = "margin:25px 20px 0px 0px; padding:0px; float:right; display:inline-block;")
                ),
                
                h4("Welcome my App", style = "padding-left:55px; margin-top:5px; margin-bottom:0px; display:inline-block;"),
                
         ),
         
         column(class = "border", width = 1)
)