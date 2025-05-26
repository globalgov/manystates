#' States datacube
#' @description `r describe_datacube(manystates::states)`.
#'   It is a work-in-progress, so please let us know if you have any comments or suggestions.
#' @format
#' \describe{
#' \item{ISD: }{A dataset with `r prettyNum(nrow(manystates::states$ISD), big.mark=",")` 
#' observations and `r ncol(manystates::states$ISD)` variables: 
#' `r cli::pluralize("{names(manystates::states$ISD)}")`.}
#' \item{HUGGO: }{A dataset with `r prettyNum(nrow(manystates::states$HUGGO), big.mark=",")` 
#' observations and `r ncol(manystates::states$HUGGO)` variables: 
#' `r cli::pluralize("{names(manystates::states$HUGGO)}")`.}
#' \item{GW: }{A dataset with `r prettyNum(nrow(manystates::states$GW), big.mark=",")` 
#' observations and `r ncol(manystates::states$GW)` variables: 
#' `r cli::pluralize("{names(manystates::states$GW)}")`.}
#' }
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#' @source
#'   `r call_citations(states, output = "help")`
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

info_states <- tibble::tibble(Dataset = names(data(states, package = "manystates")),
                               Source = c("Griffiths, R.D., and C. R. Butcher. 'Introducing the international system(s) dataset (ISD), 1816-2011'. International Interactions 39.5 (2013), pp. 748-768.",
                                          "Hollway, James, Henrique Sposito, and Jael Tan. 2021. States for manydata.",
                                          "Gleditsch, K.S., and M. D. Ward. 'Interstate system membership: A revised list of the independent states since 1816'. International Interactions 25.4 (1999), pp. 393-413."),
                               URL = c("http://www.ryan-griffiths.com/data",
                                       "",
                                       "http://ksgleditsch.com/data-4.html"))

