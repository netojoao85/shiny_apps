fluidPage(
  
  div(style = "overflow: auto;",
      
      div(style = "text-align:left;",
          class = "my_infobox",
          h3(bs_icon("geo-fill"), textOutput(outputId = "selected_region_analysis", inline = TRUE))
      ),
      
      div(style = "text-align:right;",
          class = "my_infobox",
          h3(bs_icon("bank"), textOutput(outputId ="nr_enterprises_analysis", inline = TRUE))
      ),
      
      div(style = "text-align:right;",
          class = "my_infobox",
          h3(icon("calendar"), textOutput(outputId = "selected_years_analysis", inline = TRUE)),
      )
      
  )
)
