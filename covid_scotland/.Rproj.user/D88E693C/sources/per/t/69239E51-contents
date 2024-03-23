
# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  

  
  admissions_filter <- reactive({
    if(is.null(nhs_region_select())){
      region <- ""
    }else{
      region <- nhs_region_select()
    }
    
    specialty_admissions %>% 
      filter(specialty == input$specialty, 
             hb == region,
             admission_type == input$admission)
    
  })
  
  output$selection_map <- renderLeaflet({
    leaflet(nhs_borders, options = leafletOptions(zoomControl = FALSE,
                                                  minZoom = 5.8,
                                                  maxZoom = 5.8)) %>% 
      addMarkers(layerId = "Scotland",lng = -4.75 ,lat = 59.5,
                 label = label_scotland, 
                 labelOptions = labelOptions(noHide = TRUE, textsize = "15px", direction = "left")) %>% 
      addPolygons(fillColor = ~pal(HBCode),
                  layerId = ~HBCode,
                  fillOpacity = 1,
                  weight = 1, 
                  color = "white",
                  label = labels_regions,
                  labelOptions = labelOptions(),
                  highlightOptions = highlightOptions(color = "#666",
                                                      weight = 5)
      ) %>% 
      setMaxBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>% 
      setView(lng = mean(bbox[1], bbox[3]), 
              lat = mean(bbox[2], bbox[4]),
              zoom = 5.5)#  %>%
      # onRender(
      #   "function(el, x) {
      #     L.control.zoom({
      #       position:'bottomright'
      #     }).addTo(this);
      #   }")
  })
  
  # Create heatmap plot
  output$heatmap2 <- renderLeaflet({
    leaflet(nhs_borders, options = leafletOptions(zoomControl = FALSE,
                                                  minZoom = 6,
                                                  maxZoom = 6)) %>% 
      addTiles() %>% 
      addPolygons(fillColor = ~pal(HBCode),
                  layerId = ~HBCode,
                  fillOpacity = 1,
                  weight = 1, 
                  color = "white",
                  label = labels_regions,
                  labelOptions = labelOptions()) %>% 
      setMaxBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>% 
      onRender(
        "function(el, x) {
          L.control.zoom({
            position:'bottomright'
          }).addTo(this);
        }")
  })
  
  nhs_region_select <- reactiveVal()
  
  observeEvent(input$selection_map_marker_click$id,{
    nhs_region_select("S92000003")
    
    leafletProxy("selection_map") %>%
      removeShape(layerId = c("highlight",nhs_borders$HBName)) %>%
      addPolylines(data = nhs_borders,
                   layerId = nhs_borders$HBName,
                   color = "yellow",
                   weight = 5,
                   opacity = 1)
    
  })
  
  # Start event if regions in the map are selected
  observeEvent(input$selection_map_shape_click$id, {
    
    # Prepare the shape to be highlighted
    poly_region <- which(nhs_borders$HBCode == input$selection_map_shape_click$id)
    region_highlight <- nhs_borders[poly_region, 1]
    nhs_region_select(input$selection_map_shape_click$id)
    
    
    # Highlight the region on map
    leafletProxy("selection_map") %>%
      removeShape(layerId = c("highlight",nhs_borders$HBName)) %>%
      addPolylines(data = region_highlight,
                   layerId = "highlight",
                   color = "yellow",
                   weight = 5,
                   opacity = 1)
    
  })



# Admissions plotly plot --------------------------------------------------

  
  output$katePlot <- renderPlotly({
    
    vline_1 <- function(x = 0, color = "#999999") {
      list(
        type = "line",
        y0 = 0,
        y1 = 1,
        yref = "paper",
        x0 = x,
        x1 = x,
        line = list(color = color)
      )
    }
    
    vline_2 <- function(x = 0, color = "#999999") {
      list(
        type = "line",
        y0 = 0,
        y1 = 1,
        yref = "paper",
        x0 = x,
        x1 = x,
        line = list(color = color, dash = "dot")
      )
    }
    
    # Adding lines denoting lockdowns
    
    annotation_1 <- list(yref = "paper", xref = "x", y = 0.6, x = "2020-03-29", 
                         text = "First Lockdown", xanchor = "left", showarrow = F, 
                         font = list(size = 14), textangle = 90)
    
    annotation_2 <- list(yref = "paper", xref = "x", y = 0.6, x = "2021-01-10", 
                         text = "Second Lockdown", xanchor = "left", showarrow = F, 
                         font = list(size = 14), textangle = 90)
    
    annotation_3 <- list(yref = "paper", xref = "x", y = 0.05, x = "2020-07-12", 
                         text = "Restrictions Eased", xanchor = "left", showarrow = F, 
                         font = list(size = 14), textangle = 90)
    
    annotation_4 <- list(yref = "paper", xref = "x", y = 0.05, x = "2021-05-02", 
                         text = "Restrictions Eased", xanchor = "left", showarrow = F, 
                         font = list(size = 14), textangle = 90)

# Main Plot    
    plot_admissions <- plot_ly(data = admissions_filter(),
                               x = ~week_ending,
                               y = ~number_admissions,
                               type = "scatter", 
                               mode = "lines",
                               name = "2020/2021",
                               text = ~paste("The week ending:", week_ending,
                                             "<br> Number of admissions:", number_admissions),
                               textposition = "auto",
                               hoverinfo = "text") %>% 
      layout(title = "Number of Admissions per Week by Health Board, Specialty and Admission Type", 
             xaxis = list(title = "Month", type = "date", tickformat = "%B"),
             yaxis = list(title = "Number of Admissions"),
             legend = list(title = list(text="<br> Year </br>"), orientation = "h"),
             shapes = list(vline_1("2020-03-29"), vline_1("2021-01-10"), 
                           vline_2("2020-07-12"), vline_2("2021-05-02")),
             annotations = list(annotation_1, annotation_2, annotation_3, annotation_4))
    
    
    plot_admissions <- add_trace(
      plot_admissions,
      data = admissions_filter(),
      x = ~week_ending,
      y = ~average20182019,
      type = "scatter", 
      mode = "lines",
      name = "2018/2019 average",
      text = ~paste("Comparative week ending:", week_ending,
                    "<br> 2018/2019 Average number of admissions:", average20182019), 
      textposition = "auto",
      hoverinfo = "text"
    )
  })
  

# Demographic plots --------------------------------------------------------

  # Activity demographic filter
  
  demographic_filter <- reactive({
    
    activity_patient_demographics %>%
      filter(!is.na(hb_name)) %>% 
      filter(age %in% input$demo_age,
             hb_name %in% input$demo_hb,
             admission_type %in% input$demo_admission_type) %>% 
      group_by(sex, year, age) %>%
      summarise(avg_stay = mean(average_length_of_stay, na.rm = TRUE))
    
  })
  # SIMD 
  demographic_simd_filter <- reactive({
    
    activity_deprivation %>%
      filter(!is.na(hb_name),
             !is.na(simd)) %>% 
      mutate(simd = factor(simd, levels = c(1, 2, 3, 4, 5))) %>%
      filter(hb_name %in% input$demo_hb,
             admission_type %in% input$demo_admission_type) %>% 
      group_by(year, simd) %>% 
      summarise(avg_length_stays = mean(average_length_of_stay, na.rm = TRUE))
    
  })
  # Covid Age
  covid_age_filter <- reactive({
    
    covid_admission_age_sex %>%
      filter(admission_type == input$demo_admission_type_covid_age,
             hb_name        == input$demo_hb_covid_age) %>% 
      mutate(ym = yearquarter(date),
             age_group =  case_when(
               age_group == "Under 5" ~  "0 - 04",
               age_group == "5 - 14" ~  "05 - 14",
               TRUE ~ age_group)) %>% 
      filter(!age_group == "All ages") %>% 
      group_by(age_group, ym, number_admissions) %>% 
      summarise(nr_admissions = sum(number_admissions))
    
  })
  # Activity demographic plot 1 (Age / Sex)
  
  output$demographics_output <- renderPlot({
 
    demographic_filter() %>%
      ggplot() +
      aes(x = age, y = avg_stay, fill = sex) +
      geom_col(position = "dodge") +
      theme_minimal() +
      labs(title = "Average Stay Length by Gender and Age Group",
           x = NULL,
           y = "Average Stay Length", 
           fill = "Sex") +
      theme(legend.position = "right",
            panel.background = element_rect(fill = '#FFFFFF', 
                                            color = '#F8F8F8')) +
      scale_fill_manual(values = c("#003087", 
                                   "#99C7EB"))
    
  })
  
  # Activity demographic plot 2 (SIMD rating)
  
  output$demographics_simd_output <- renderPlot({
    
    demographic_simd_filter() %>%
      ggplot() + 
      aes(x = year, y = avg_length_stays, fill = simd) +
      geom_col(position = "dodge") + 
      labs(title = "Average Length of Stay by Board of Treatment and Deprivation",
           subtitle = "1 - Most deprived | 5 - least deprived",
           x = NULL) +
      theme_minimal() +
      scale_x_continuous(breaks = seq(2016, 2021, 1)) +
      theme(
        legend.position = "right",
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        legend.direction = "horizontal",
        panel.background = element_rect(fill = '#FFFFFF', 
                                        color = '#F8F8F8')) +
      scale_fill_manual(values = c("#003087", "#005EB8", 
                                   "#99C7EB", "#919EA8", 
                                   "#DDE1E4")) +
      labs(y = "Average Stay Length")
    
  })
  
  # Covid demographic plot gender
  
  output$demographics_output_covid <- renderPlot({
    
    covid_admission_age_sex %>%
      filter(!sex == "All",
             admission_type == input$demo_admission_type_covid,
             hb_name        == input$demo_hb_covid) %>% 
      mutate(year_month = yearmonth(date)) %>% 
      group_by(year_month, 
               sex) %>% 
      summarise(nr_admissions = sum(number_admissions)) %>% 
      ggplot() + 
      aes(x = year_month,
          y = nr_admissions, 
          fill = sex, 
          color = sex) +
      geom_line(position = "dodge", size = 1) +
      scale_x_yearmonth(date_labels = "%b \n%Y", 
                        date_breaks = "2 month") +
      labs(title    = "Covid Admissions by Gender",
           subtitle = "January 2020 to February 2022\n",
           x        = NULL, 
           y        = "Admissions") +
      theme_minimal() +
      theme(legend.position = "bottom",
            legend.title = element_blank(),
            panel.background = element_rect(fill = '#FFFFFF', 
                                            color = '#F8F8F8')) +
      scale_color_manual(values = c("Male"   = "#99C7EB",
                                    "Female" = "#003087"))
    
  })
  
  # Demographic plot Covid age
  
  output$demographics_output_covid_age <- renderPlot({
    
    covid_age_filter() %>% 
    ggplot() +
    aes(x = ym, y = nr_admissions, fill = age_group) + 
    geom_col(position = "dodge") + 
    theme_minimal() +
    labs(
      title    = "Covid admissions by group age",
      subtitle = "January of 2020 to January 2022",
      x = NULL,
      y = "Adimissions") +
    scale_fill_manual(values = c("#003087", "#005EB8", 
                                 "#4D7CB9", "#99C7EB", 
                                 "#919EA8", "#B7C0C6", 
                                 "#DDE1E4")) +
    scale_x_yearquarter(date_labels = "%Y \n Q%q", date_breaks = "3 months") +
    theme(
      legend.position = "bottom",
      legend.title = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.background = element_rect(fill = '#FFFFFF', color = '#F8F8F8')
    )
  })


# Geo leaflet plot --------------------------------------------------------

  
  key_domain <- reactiveVal()
  
  observeEvent(input$data_select_geo,{
    
    if(input$data_select_geo == "beds"){
      updateSelectInput(session,
                        inputId = "variable_to_plot_geo",
                        label = "Select Variable to plot",
                        choices = beds_variables_selection)
      
      updateSelectInput(session,
                        inputId = "speciality_geo",
                        label = "Select Speciality",
                        choices = sort(unique(beds$specialty_name)))
 
      
      key_domain("specialty_name")
      
    }else{
      updateSelectInput(session,
                        inputId = "variable_to_plot_geo",
                        label = "Select Variable to Plot",
                        choices = activity_dep_variables)
      
      updateSelectInput(session,
                        inputId = "speciality_geo",
                        label = "Select Admission Type",
                        choices = sort(unique(activity_deprivation$admission_type)))
      
      key_domain("admission_type")
      
    }
    
  })
  
  quarter_filter <- reactive({
    eval(as.name(input$data_select_geo)) %>% 
      filter(year_quarter >= yearquarter(input$year_quarter_geo[1]) &
               year_quarter <= yearquarter(input$year_quarter_geo[2]),
             !!as.name(key_domain()) == input$speciality_geo) %>% 
      group_by(HBCode = hb)
  })
  
  
  observeEvent(c(input$year_quarter_geo, input$variable_to_plot_geo,
                 input$speciality_geo),{
                   
                   if(input$data_select_geo == "beds"){
                     geo_data <- quarter_filter() %>% 
                       summarise(plot_this = case_when(
                         str_detect(input$variable_to_plot_geo, "_beds") ~ mean(!!as.name(input$variable_to_plot_geo), na.rm = TRUE),
                         str_detect(input$variable_to_plot_geo, "percentage_occ") ~ 100*sum(total_occupied_beddays, na.rm = TRUE)/sum(all_staffed_beddays, na.rm = TRUE),
                         TRUE ~ sum(!!as.name(input$variable_to_plot_geo), na.rm = TRUE))
                       )
                     
                     legend_title_heatmap <- names(which(beds_variables_selection == input$variable_to_plot_geo))
                     
                   }else{
                     geo_data <- quarter_filter() %>% 
                       summarise(plot_this = case_when(
                         str_detect(input$variable_to_plot_geo, "th_of_st") ~ sum(stays, na.rm = TRUE)/sum(length_of_stay, na.rm = TRUE)*100,
                         str_detect(input$variable_to_plot_geo, "th_of_ep") ~ sum(episodes, na.rm = TRUE)/sum(length_of_episode, na.rm = TRUE)*100,
                         TRUE ~ sum(!!as.name(input$variable_to_plot_geo), na.rm = TRUE))
                       )
                     
                     legend_title_heatmap <- names(which(activity_dep_variables == input$variable_to_plot_geo))
                   }              
                   
                   
                   
                   temp_shape <- sp::merge(nhs_borders, geo_data, by = c("HBCode" = "HBCode"))
                   
                   factor_number <- 10^ceiling(log10(temp_shape$plot_this)-2)
                   
                   range <- c(significance_round(min(temp_shape$plot_this), round_up = FALSE, 2), 
                              significance_round(max(temp_shape$plot_this), round_up = TRUE, 2))
                   
                   if(any(is.na(range))){
                     bins <- c(1:9)
                   }else{
                     bins <- seq(from = range[1], to = range[2], by = (range[2] - range[1])/9) %>% 
                       signif(3)
                     if(length(bins) == 1){
                       bins <- c(bins, bins + 1)
                     }
                   }
                   
                   # Create labels for region plot
                   labels_heat <- paste0(
                     "<b>", temp_shape$HBName, "</b><br>", temp_shape$plot_this
                   ) %>% lapply(htmltools::HTML)
                   
                   hot_colour <- colorBin(palette = "YlOrRd", domain = temp_shape$plot_this, bins = bins)
                   
                  
                   leafletProxy("heatmap2") %>% 
                     clearShapes() %>% 
                     clearControls() %>% 
                     addPolygons(data = temp_shape,
                                 fillColor = hot_colour(temp_shape$plot_this),
                                 fillOpacity = 1,
                                 weight = 3, 
                                 color = "#7fcdbb",
                                 dash = 4,
                                 label = labels_heat,
                                 labelOptions = labelOptions()) %>% 
                     addLegend(pal = hot_colour,
                               values = temp_shape$plot_this, 
                               title = legend_title_heatmap,
                               position = "bottomright") %>% 
                     setMaxBounds(bbox[1], bbox[2], bbox[3], bbox[4])
                  
                 })
  

# Death plots -------------------------------------------------------------

  
  output$deathplot1 <- renderPlot(
  
  deaths_by_deprivation %>% 
    group_by(simd_quintile) %>% 
    summarise(total_deaths = sum(deaths)) %>% 
    ggplot() +
    geom_col(aes(x = simd_quintile, y = total_deaths), fill = "#003087") +
    labs(title = "Number of Deaths Across 2020/2021 by SIMD",
         x = "SIMD",
         y = "Total Deaths") +
    theme(panel.background = element_rect(fill = '#FFFFFF', color = '#F8F8F8'))
  )
  
  output$deathplot2 <- renderPlot(
  
  deaths_by_deprivation %>% 
    group_by(week_ending) %>% 
    ggplot() +
    geom_line(aes(x = week_ending, y = deaths, linetype = "2020/2021"), colour = "#003087", show.legend = TRUE) +
    geom_line(aes(x = week_ending, y = average20152019, linetype = "2015-2019"), colour = "#DDE1E4", show.legend = TRUE) +
    facet_wrap(~simd_quintile) +
    theme(axis.text.x = element_text(angle = 90),
          legend.position = "bottom",
          panel.background = element_rect(fill = '#FFFFFF', color = '#F8F8F8')) +
    ggtitle("Trend of Deaths by SIMD over Time") +
    labs(x = "Date",
         y = "Number of Deaths") +
    guides(linetype = guide_legend(title = NULL))
  )
})