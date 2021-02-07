#' output of a shiny semantic box with the information
#'
#' Shiny Module


# UI
dynamicInfoInput <- function(id,label,name,img){

  ns <- shiny::NS(id)
  div(semantic.dashboard::box(title = name, color = "blue",
                              collapse_icon = FALSE,
                              ribbon = FALSE,
                              title_side = "top",
                              div(shiny::tags$img(id = "speed",src = img,
                                                  style='width:100px;margin-left:3px;')),
                              div(htmlOutput(ns("value")))),style = "text-align: center;padding: 3%;font-weight: bold;")

}

# SERVER
dynamicInfo <- function(input, output, session, the_data,value){

  ns <- session$ns

  ## update input$dynamic_select
  observe({
    shiny::validate(
      shiny::need(the_data(),"Fetching data")
    )
    dt <- the_data()

    testthat::expect_is(dt, "data.frame")

    # AVERAGE_SPEED
    if(value == "speed"){
      AV_SPEED<-dt%>%dplyr::filter(is_parked=="0")
      AV_SPEED<-mean(as.numeric(AV_SPEED$SPEED_KMH),na.rm = T)
      output$value<- renderText({
        paste(round(AV_SPEED,0),"Km/h")
      })
    }else{
      if(value=="max_dist"){
        MAX_DIST<-dt%>%dplyr::arrange(dplyr::desc(DISTANCE,DATETIME))
        MAX_DIST<-MAX_DIST$DISTANCE[1]
        output$value<- renderText({
          paste(round((MAX_DIST)*1000,0),"m")
        })
      }else{
        if(value=="last_dep"){
          LAST_DEP<-dt$DATETIME[1]
          output$value<- renderText({
            paste(LAST_DEP)
          })
        }else{
          TOT_DISTANCE<-sum(dt$DISTANCE,na.rm = T)
          output$value<- renderText({
            paste(round((TOT_DISTANCE)*1000,0),"m")
          })
        }
      }
    }
  })
}
