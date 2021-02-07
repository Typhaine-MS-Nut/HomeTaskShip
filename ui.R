#' Front of the application
#'
#' ui part of the application

ui <- function() {
  shiny.semantic::semanticPage(
    shiny.semantic::grid(myGrid,
                         menu = shiny.semantic::grid(subGrid,
                                                     container_style = "background-color: #e4e8eb;",
                                                     #title
                                                     top = div(class = "center", span(style = "font-size: 30px",
                                                                                      icon("anchor")),HTML("<b>SHIP TRACKING</b>"),
                                                               style = "color: #22125e;text-align: center;font-size: 30px;padding-top: 7%"),
                                                     #Date
                                                     top_2 = div(
                                                       div(HTML("Select a ship type, a ship name and a trip to see the relevant information."),style ="font-weight: bold;padding-top: 3%;padding-left:3%"),
                                                       style = "background-color: #b8d3e3;height: 80%;width: 80%;margin-left:10%;"),
                                                     #BOAT choice
                                                     middle = div(dynamicSelectInput("type_select", "SHIP TYPE", multiple = F),
                                                                  dynamicSelectInput("boat_select", "SHIP NAME", multiple = F),
                                                                  dynamicSelectInput("travel_select", "TRIP", multiple = F),
                                                                  style= "height: 80%;width: 80%;margin-left:10%;"),
                                                     #DEPARTURE DATE
                                                     top_left =div(dynamicInfoInput("last_dep",
                                                                                    name = "DEPARTURE DATE",
                                                                                    img = "cal_icon.png")),
                                                     # DISTANCE
                                                     bottom_left =div(dynamicInfoInput("boat_speed",
                                                                                     name = "AVERAGE SPEED",
                                                                                     img = "speed_icon.png")),

                                                     # DISTANCE MAX
                                                     bottom_right = div(dynamicInfoInput("boat_max_dist",
                                                                                        name = "MAX DISTANCE BETWEEN 2 OBSERVATIONS",
                                                                                        img = "dist_icon.png")),
                                                     # TRAVEL DISTANCE
                                                    top_right = div(dynamicInfoInput("dist_last_trip",
                                                                                        name = "DISTANCE TRAVELED",
                                                                                        img = "travel_icon.png")),
                         ),
                         main = div(leaflet::leafletOutput("mymap",height = 750))
    ))

}

