#' Obtaining a list of state-like entities from a datacube at a certain point in time
#' @param datacube A datacube, 
#'   i.e. a list of data frames with Begin and End date variables.
#' @param date A date (of class Date or character) at which to filter the datacube.
#' @importFrom dplyr filter
#' @examples
#' state_system(manystates::states, date = "2010")
#' @export
state_system <- function(datacube, date = Sys.Date()){
  lapply(datacube, function(x) dplyr::filter(x,
                                             Begin <= date & End >= date))
}