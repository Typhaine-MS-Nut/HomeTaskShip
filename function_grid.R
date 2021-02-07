#' Grid function
#'
#'Set the skeleton of the application


myGrid <- shiny.semantic::grid_template(default = list(
  areas = rbind(
    # c("header", "header", "header"),
    c("menu", "main")
  ),
  rows_height = c("100%"),
  cols_width = c("30%", "70%")
))

subGrid <- shiny.semantic::grid_template(default = list(
  areas = rbind(
    c("top"),
    c("top_2"),
    c("middle"),
    c("top_left", "top_right"),
    c("bottom_left", "bottom_right")
  ),
  rows_height = c("10%", "10%","30%","25%","25%"),
  cols_width = c("50%", "50%")
))
