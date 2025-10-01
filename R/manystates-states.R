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
#' |  *GGO*  | *GW*  | *ISD* | 
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

info_states <- tibble::tibble(Dataset = c("ISD", "GW", "GGO"),
                              Released = c(2013, 1999, 2025),
                              Updated = c(2025, 1999, 2025),
                              Source = c("Griffiths, Ryan D., and Charles R. Butcher. 'Introducing the international system(s) dataset (ISD), 1816-2011'. International Interactions 39.5 (2013), pp. 748-768.",
                                         "Gleditsch, Kristian S., and Michael D. Ward. 'Interstate system membership: A revised list of the independent states since 1816'. International Interactions 25.4 (1999), pp. 393-413.",
                                         "Hand-coded data by the GGO team"),
                              URL = c("http://www.ryan-griffiths.com/data",
                                      "http://ksgleditsch.com/data-4.html",
                                      "https://panarchic.ch"))

