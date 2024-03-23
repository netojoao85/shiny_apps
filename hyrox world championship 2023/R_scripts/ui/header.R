header <- dashboardHeader(
  title = "HYROX",
  
  dropdownMenu(
    type = "notifications", 
    headerText = 
      span(h4("João Neto", style = "font-size: bold, padding-bottom:0px"), 
           br(), 
           bs_icon("chat-fill"), " I am a HYROX races enthusiast. Visit my LinkedIn and know me better."), 
    icon = icon("user"), 
    badgeStatus = NULL,
    notificationItem(
      icon = icon("linkedin"),
      text = ("Linkedin"),
      href = "https://www.linkedin.com/in/joaonetoprofile/"
    )
  ),
  
  dropdownMenu(
    type = "notifications",
    headerText = 
      span(
        h4("HYROX is a fitness racing", style = "border-bottom: 1px solid black; font-weight: bold"),
        p(em('"HYROX combines both running and functional 
                                      workout stations, where participants run 1km, 
                                      followed by 1 functional workout station, 
                                      repeated eight times"'), " (source: https://hyrox.com/the-fitness-race/).", style = "text-align: justify"),
        br(),
        p("For each 1 km of running completed, athletes have a workout station to finish 
                                     until they complete a total of 8 km of running and 8 different workout stations.", style = "text-align: justify"),
        br(),
        p("It is a global competition; at the end of each race season, 
                                    the top 15 athletes compete against each other. In 2023, 
                                    the world champion race was in Manchester (UK). 
                                    This app is an analysis of that race.", style = "text-align: justify")
      ),
    
    icon = strong(bs_icon("info-circle-fill"), "About APP"),
    badgeStatus = NULL,
    notificationItem(
      icon = icon("running"),
      text = ("Official HYROX Website"),
      href = "https://hyrox.com/"
    )
    
  )
)
