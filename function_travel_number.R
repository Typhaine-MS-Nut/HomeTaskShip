#' creation of a new variable whose separe every travel of a choosen boat
#'
#' return a new dataframe with a column travel number
#'
#' If column not in df, return only trip superior to 5KM
#'

creation_travel_ID <- function(df){

  testthat::expect_is(df, "data.frame")

  ships_dist<-df%>%dplyr::arrange(., DATETIME)
  #new column with a 1 value for every departure
  ships_dist$TRAVEL_NUMBER<-c(NA,as.numeric(as.character(ships_dist$is_parked))[-1]+as.numeric(as.character(ships_dist$is_parked))[-nrow(ships_dist)])
  #number of travel
  TRAVEL_DATE<-ships_dist%>%filter(TRAVEL_NUMBER=="1" & is_parked == "1")%>%select(DATETIME)%>%pull()
  #had the last date
  TRAVEL_DATE<-c(TRAVEL_DATE, "2021-12-13 22:33:06 UTC")
  #function to assign the date


  ships_dist[ships_dist$DATETIME <= TRAVEL_DATE[1],"TRAVEL_NUMBER"]<-1

  if (length(TRAVEL_DATE)>1){
    for (i in 1:length(TRAVEL_DATE)) {
      ships_dist[ships_dist$DATETIME >= TRAVEL_DATE[i] & ships_dist$DATETIME <= TRAVEL_DATE[i+1],"TRAVEL_NUMBER"]<-i+1
    }
  }

  ships_dist$TRAVEL_NUMBER<-as.factor(ships_dist$TRAVEL_NUMBER)
  ships_dist<-ships_dist%>%group_by(TRAVEL_NUMBER)%>%
    mutate(TOTAL_DIST = sum(DISTANCE, na.rm = T))%>%
    filter(TOTAL_DIST>5)
  ships_dist
}
