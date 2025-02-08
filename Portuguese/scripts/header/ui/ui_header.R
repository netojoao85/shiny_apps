fluidPage(
      
  div(id = "page_header",
      
      fluidRow(
        
        column(width = 6,
               
            h2("Tourist Enterprises in Portugal"),
            
            actionButton(
              inputId = "show_popup",
              icon = icon("info-circle"),
              label = "info",
              width = "200px"
            )

          ),
        
        column(width = 6, style = "text-align: right;",
               
          tags$a(
              href="https://www.turismodeportugal.pt/pt/Paginas/homepage.aspx", target = "_blank",
              tags$img(src="images/portuguese_touristic.png", height = "100%")
            )
      )
    ),
      
# 
#     absolutePanel(
#       id = "filter_menu", 
#       fixed = TRUE,
#       draggable = TRUE, 
#       top = 210, left = "auto", right = 20, bottom = "auto",
#       width = 480, 
#       height = "auto",
#       hidden = TRUE,
#       
#       div(
#         class = "menu_header",
#         actionButton(inputId = "hide_filter_menu", label = "  Hide Menu", icon =  icon("times")),
#         actionButton(inputId = "clear_selection", icon =  icon(""),
#                      label = span(img(src = "images/portugal_flag.png", height = "20px"), "Filter by All Districts"),)
#       ),
#       source(here::here("scripts/filter_menu/ui/ui_filter_menu.R"), local = TRUE)$value
#     )
  )
)
