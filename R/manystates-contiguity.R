#' State contiguity datacube
#'
#' @description The `contiguity` datacube is a list containing 
#' `r length(manystates::contiguity)` datasets: 
#' `r cli::pluralize("{names(manystates::contiguity)}")`.
#' It is a work-in-progress, so please let us know if you have any comments or suggestions.
#' @format
#' \describe{
#' \item{HUGGO: }{A dataset with `r prettyNum(nrow(manystates::contiguity$HUGGO), big.mark=",")` 
#' observations and `r ncol(manystates::contiguity$HUGGO)` variables: 
#' `r cli::pluralize("{names(manystates::contiguity$HUGGO)}")`.}
#' \item{COW: }{A dataset with `r prettyNum(nrow(manystates::contiguity$COW), big.mark=",")` 
#' observations and `r ncol(manystates::contiguity$COW)` variables: 
#' `r cli::pluralize("{names(manystates::contiguity$COW)}")`.}
#' }
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#' @source
#' \describe{
#' \item{COW: }{
#' Hensel, Paul R. _Correlates of War Project. Direct Contiguity Data, 1816-2016. Version 3.2._ 2017.
#' \url{https://correlatesofwar.org/data-sets/direct-contiguity}
#' }
#' \item{HUGGO: }{
#' Hollway, James, Henrique Sposito, and Jael Tan. 2001. _manystates: States for manydata_.}
#' }
#' @section Mapping:
#'
#' |  *manystates*  | *COW*
#' |:------------|:------------|
#' | stateID1 | statelab |
#' | stateID2 | statehab |
#' | Begin | begin |
#' | End | end |
#' | dyadID | dyad |
#' | cowNR1 | statelno |
#' | cowNR2 | statehno |
#' | ContiguityType | conttype |
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(contiguity, messydates::mreport)
#' ```
"contiguity"
