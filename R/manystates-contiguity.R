#' State contiguity datacube
#'
#' @description The contiguity datacube is a list containing 
#' `r length(manystates::contiguity)` datasets: 
#' `r cli::pluralize("{names(manystates::contiguity)}")`.
#' It is a work-in-progress, so please do not rely on it yet.
#' @format
#' \describe{
#' \item{COW: }{A dataset with `r prettyNum(nrow(manystates::contiguity$COW), big.mark=",")` 
#' observations and `r ncol(manystates::contiguity$COW)` variables: 
#' `r cli::pluralize("{names(manystates::contiguity$COW)}")`.}
#' \item{HUGGO: }{A dataset with `r prettyNum(nrow(manystates::contiguity$HUGGO), big.mark=",")` 
#' observations and `r ncol(manystates::contiguity$HUGGO)` variables: 
#' `r cli::pluralize("{names(manystates::contiguity$HUGGO)}")`.}
#' }
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#' @source
#'\itemize{
#' \item{COW: }{
#' Hensel, Paul R. _Correlates of War Project. Direct Contiguity Data, 1816-2016. Version 3.2._ 2017.
#' \url{https://correlatesofwar.org/data-sets/direct-contiguity}
#' }
#' \item{HUGGO: }{
#' J. Hollway. manystates: States for manydata. 2021.}
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
