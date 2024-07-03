#' contiguity datacube documentation
#'
#' @format The contiguity datacube is a list that contains the
#' following 2 datasets: COW_CONT, HUGGO_CONT.
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#'\describe{
#' \item{COW_CONT: }{A dataset with 847 observations and the following
#' 12 variables: dyadID, ContiguityType, Begin, End, cowNR1, cowID1, cowNR2,
#' cowID2, stateID1, StateName1, stateID2, StateName2.}
#' \item{HUGGO_CONT: }{A dataset with 609 observations and the following
#' 8 variables: stateID1, stateID2, Begin, End, StateName1, StateName2,
#' ContiguityType, url.}
#' }
#' @source
#'\itemize{
#' \item{COW_CONT: }{
#' Hensel, Paul R. _Correlates of War Project. Direct Contiguity Data, 1816-2016. Version 3.2._ 2017.
#' }
#' \item{HUGGO_CONT: }{
#' J. Hollway. manystates: States for manydata. 2021.}
#' }
#' @section URL:
#'\itemize{
#' \item{COW_CONT: }{
#' \url{https://correlatesofwar.org/data-sets/direct-contiguity}
#' }
#' \item{HUGGO_CONT: }{Hand-coded data by the GGO team}
#' }
#' @section Mapping:
#'\itemize{
#' \item{COW_CONT: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | dyad | dyadID |
#' | statelno | cowNR1 |
#' | statehno | cowNR2 |
#' | conttype | ContiguityType |
#' | begin | Begin |
#' | end | End |
#' | statelab | cowID1 |
#' | statehab | cowID2 |
#' 
#' }
#' }
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(contiguity, messydates::mreport)
#' ```
"contiguity"
