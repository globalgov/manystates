#' Griffiths, Ryan D, and Charles R. Butcher. 2013. Introducing the International System(s)
#' Dataset (ISD), 1816-2011. International Interactions 39 (5): 748-768.
#'
#' This dataset contains the International System(s) Dataset (ISD) with 363 case countries. 
#' Most of the cases The first category includes the 233 cases that were taken directly from the 
#' Correlates of War (COW) and list of independent states dataset Gleditsch and Ward (1999). 
#' The dataset adds 96 completely new states. Some of these states were earlier
#' incarnations of states that would exist later, typically during the 20th century (e.g. Bhutan), but
#' the majority did not reappear. See the Griffiths and Butcher(2013) article for a conceptual 
#' discussion and the codebook for details on coding rules and cases here
#' (https://static1.squarespace.com/static/54eccfa0e4b08d8eee5174af/t/54ede030e4b0a0f14faa8f84/1424875568381/ISD+Codebook_version1.pdf)
#'
#' @format This dataset contains  363 observations and 7 variables:
#' \describe{
#'   \item{COW_Nr}{Reference number for country according to COW project}
#'   \item{ID}{Three letter country ID according to COW project}
#'   \item{Beg}{Date of beggining of State tenure}
#'   \item{End}{Date of ending of State tenure}
#'   \item{Label}{Name of the state}
#'   \item{Micro}{Whether or not the State is considered a micro state, dummy variable}
#'   \item{New.State}{Whether or not the State appeared in COW or GW datasets before the date of beginning of the state tenure, dummy variable}
#' }
#' @source \url{https://www.tandfonline.com/doi/full/10.1080/03050629.2013.834259}
"ISD"
