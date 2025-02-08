fluidRow(class = "bottom_menu",
         column(class = "border", width = 1),
         
         column(width = 10,
                column(class = "icon", width = 3, actionButton("btn_home","", icon("home"))),
                column(class = "icon", width = 3, actionButton("btn_info", "",icon("circle-info"))),
                column(class = "icon", width = 3, actionButton("btn_question", "",icon("question"))),
                column(class = "icon", width = 3, actionButton("btn_linkedin", "",icon("linkedin-in")))),
         
         column(class = "border", width = 1)
)