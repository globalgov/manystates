#' States datacube
#' @description The `states` datacube is a list containing 
#'   `r length(manystates::states)` datasets: 
#'   `r cli::pluralize("{names(manystates::states)}")`.
#'   It is a work-in-progress, so please let us know if you have any comments or suggestions.
#' @format
#' \describe{
#' \item{HUGGO: }{A dataset with `r prettyNum(nrow(manystates::states$HUGGO), big.mark=",")` 
#' observations and `r ncol(manystates::states$HUGGO)` variables: 
#' `r cli::pluralize("{names(manystates::states$HUGGO)}")`.}
#' \item{GW: }{A dataset with `r prettyNum(nrow(manystates::states$GW), big.mark=",")` 
#' observations and `r ncol(manystates::states$GW)` variables: 
#' `r cli::pluralize("{names(manystates::states$GW)}")`.}
#' \item{ISD: }{A dataset with `r prettyNum(nrow(manystates::states$ISD), big.mark=",")` 
#' observations and `r ncol(manystates::states$ISD)` variables: 
#' `r cli::pluralize("{names(manystates::states$ISD)}")`.}
#' }
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#' @source
#' \describe{
#' \item{HUGGO: }{
#' Hollway, James, Henrique Sposito, and Jael Tan. 2021. _manystates: States for manydata_.
#' }
#' \item{GW: }{
#' Gleditsch, K.S., and M. D. Ward. “Interstate system membership: A revised list of the independent states since 1816”.
#' _International Interactions_ 25.4 (1999), pp. 393-413.
#' \url{http://ksgleditsch.com/data-4.html}
#' }
#' \item{ISD: }{
#' Griffiths, R.D., and C. R. Butcher. “Introducing the international system (s) dataset (ISD), 1816-2011”.
#' _International Interactions_ 39.5 (2013), pp. 748-768.
#' \url{http://www.ryan-griffiths.com/data}
#' }
#' }
#' @section Mapping:
#' 
#' |  *manystates*  | *GW*  | *ISD* | 
#' |:---------------|:------|:------|
#' | stateID  | | |
#' | Begin | Start | Start |
#' | End | Finish | Finish |
#' | StateName | Name of State | State.Name |
#' | cowID | Cow ID | COW.ID |
#' | cowNR | Cow NR. | COW.Nr |
#' 
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(states, manydata::mreport)
#' ```
"states"
