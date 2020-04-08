library(dplyr)
library(tidyr)
#-------------------------------------------------------------------------------------
#' Gets a parameter value
#'
#' \code{get_curve_analysis()} returns behaviour modes for a time series
#'
#'
#' As it's a generic function, this call is dispatched to run.seir
#'
#' @param out is the output simulation tibble
#' @param vars is the list of vars to do the analysis o
#' @return A tidy data set
#' @export
get_curve_analysis <- function(out, indicators){
  df <- select(out, Date, SimDay,!!indicators)
  df_l <- pivot_longer(df,-c(Date,SimDay),names_to ="Variable",values_to = "Value")


  df_l <- group_by(df_l,Variable)
  df_l <- mutate(df_l,Diff_1=Value-lag(Value,1),Diff_2=Diff_1-lag(Diff_1,1))
  df_l <- df_l[complete.cases(df_l),]
  df_l <- mutate(df_l,Mode_1=ifelse(Diff_1>0,"INC","DEC"),
                      Mode_2=ifelse(Diff_2>0,"INC","DEC"),
                      Behaviour=paste0(Mode_1,"-",Mode_2))
  df_l$Behaviour <- factor(df_l$Behaviour,levels=c("INC-INC","INC-DEC","DEC-INC","DEC-DEC"))
  browser()

}
