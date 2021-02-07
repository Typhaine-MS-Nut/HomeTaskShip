#' calculation of the distance and the speed between two observations
#'
#' return a new dataframe with Ships distance between each observation and ships speed
#'
#' If column not in df, returns back the df
#'

safe_INFO <- function(df){

  testthat::expect_is(df, "data.frame")

  ships_dist<-df%>%dplyr::arrange(., DATETIME)%>%dplyr::mutate(TIME_H = NA)
  #TIME
  ships_dist$TIME_H<-c(NA, difftime(ships_dist$DATETIME[-1],
                                    ships_dist$DATETIME[-nrow(ships_dist)],
                                    units="hours"))
  #DISTANCE
  ships_dist$DISTANCE<-c(NA,radiant.data::as_distance(ships_dist$LAT[-1],
                                                      ships_dist$LON[-1],
                                                      ships_dist$LAT[-nrow(ships_dist)],
                                                      ships_dist$LON[-nrow(ships_dist)],
                                                      unit = "km"))
  #SPEED
  ships_dist<-ships_dist%>%
    dplyr::mutate(SPEED_KMH = DISTANCE/TIME_H)

  ships_dist

}
