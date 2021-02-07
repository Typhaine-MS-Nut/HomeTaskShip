#' code of the application
#'
#' Shiny Server



server <- function(input, output, session) {


  # prepare dataset
  ships <- reactive({
    ships <- readRDS("www/ships.rds")
  })

  #filter boat type
  type_filter<- shiny::callModule(dynamicSelect, "type_select", ships, "ship_type", default_select = "Cargo")
  #filter boat
  boat_filter<- shiny::callModule(dynamicSelect, "boat_select", type_filter, "SHIPNAME", default_select = type_filter()$disp)
  #calculate extra information (speed and distance)
  boat_filter_info<- reactive({safe_INFO(boat_filter())})
  # creation of the travel number variable
  boat_num<-reactive({creation_travel_ID(boat_filter_info())})
  #filter by the travel number
  boat_final<- shiny::callModule(dynamicSelect, "travel_select", boat_num, "TRAVEL_NUMBER", default_select = boat_filter()$disp)



  #output my map
  output$mymap <- leaflet::renderLeaflet({
    table <- boat_final()
    leaflet::leaflet(data = table) %>%
      leaflet::addTiles() %>%
      leaflet::addCircles(lng = table$LON, lat = table$LAT)
  })
  #information
  shiny::callModule(dynamicInfo,"boat_speed",the_data = boat_final, value = "speed")
  shiny::callModule(dynamicInfo,"boat_max_dist",the_data = boat_final, value = "max_dist")
  shiny::callModule(dynamicInfo,"last_dep",the_data = boat_final, value = "last_dep")
  shiny::callModule(dynamicInfo,"dist_last_trip",the_data = boat_final, value = "dist_last_trip")

  #plot
  output$shipsTable <-shiny::renderDataTable({
    data()
  })
}
