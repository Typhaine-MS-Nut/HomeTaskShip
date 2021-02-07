#' Safe subset
#'
#' @param df Dataframe
#' @param column One name of column to subset within
#' @param subset Vector of entries in column to subset to
#'
#' If column not in df, returns back the df
safeSubset <- function(df, column, subset){
  
  testthat::expect_is(df, "data.frame")
  testthat::expect_is(column, "character")
  testthat::expect_equal(length(column), 1)
  
  if(!is.null(subset)){
    testthat::expect_is(subset, "character")
  } else {
    message("Subset is NULL, returning original")
    out <- df
  }
  
  message(" # subsetting # original rows: ",nrow(df) ," column:", column, " by ", paste(subset, collapse = ", "))
  
  col <- df[[column]]
  
  if(!is.null(col)){
    out <- df[col %in% subset,]
    message("Subset rows: ", nrow(out))
  } else {
    message("Column not found:", column)
    out <- df
  }
  
  out
  
}
