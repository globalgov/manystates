#' States datacube
#' @description The states datacube is a list containing 
#' `r length(manystates::states)` datasets: 
#' `r cli::pluralize("{names(manystates::states)}")`.
#' It is a work-in-progress, so please do not rely on it yet.
#' @format
#' \describe{
#' \item{GW: }{A dataset with `r prettyNum(nrow(manystates::states$GW), big.mark=",")` 
#' observations and `r ncol(manystates::states$GW)` variables: 
#' `r cli::pluralize("{names(manystates::states$GW)}")`.}
#' \item{ISD: }{A dataset with `r prettyNum(nrow(manystates::states$ISD), big.mark=",")` 
#' observations and `r ncol(manystates::states$ISD)` variables: 
#' `r cli::pluralize("{names(manystates::states$ISD)}")`.}
#' \item{COW: }{A dataset with `r prettyNum(nrow(manystates::states$COW), big.mark=",")` 
#' observations and `r ncol(manystates::states$COW)` variables: 
#' `r cli::pluralize("{names(manystates::states$COW)}")`.}
#' \item{ICOW: }{A dataset with `r prettyNum(nrow(manystates::states$ICOW), big.mark=",")` 
#' observations and `r ncol(manystates::states$ICOW)` variables: 
#' `r cli::pluralize("{names(manystates::states$ICOW)}")`.}
#' \item{RATRULES: }{A dataset with `r prettyNum(nrow(manystates::states$RATRULES), big.mark=",")` 
#' observations and `r ncol(manystates::states$RATRULES)` variables: 
#' `r cli::pluralize("{names(manystates::states$RATRULES)}")`.}
#' \item{HUGGO_STATES: }{A dataset with `r prettyNum(nrow(manystates::states$HUGGO_STATES), big.mark=",")` 
#' observations and `r ncol(manystates::states$HUGGO_STATES)` variables: 
#' `r cli::pluralize("{names(manystates::states$HUGGO_STATES)}")`.}
#' }
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#' @source
#' \itemize{
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
#' \item{COW: }{
#' Correlates of War Project. _State System Membership List, v2016._
#' <http://correlatesofwar.org>. Accessed: 2021-01-25.
#' \url{https://correlatesofwar.org/data-sets/state-system-membership}
#' }
#' \item{ICOW: }{
#' Hensel, P.R. (2018). _ICOW Colonial History Data Set, version 1.1._
#' <http://www.paulhensel.org/icowcol.html>. Accessed: 2021-12-23.
#' \url{http://www.paulhensel.org/icowcol.html}
#' }
#' \item{RATRULES: }{
#' Simmons, B.A. (2009). _Mobilizing for Human Rights: International Law in Domestic Politics_.
#' Cambridge University Press.
#' \url{https://doi.org/10.1017/CBO9780511811340}
#' }
#' \item{HUGGO: }{
#' Hollway, J. manystates: States for manydata. 2021.
#' Hand-coded by the GGO team.}
#' }
#' @section Mapping:
#' 
#' |  *manystates*  | *GW*  | *ISD* | *COW* | *ICOW* | *RATRULES* |
#' |:---------------|:------|:------|:------|:-------|:-----------|
#' | stateID  | | | | | StatID |
#' | cowID | Cow ID | COW.ID | stateabb | State |
#' | Begin | Start | Start | styear,stmonth,stday | IndDate|
#' | End | Finish | Finish | endyear,endmonth,endday | |
#' | StateName | Name of State | State.Name | statenme | Name |
#' | cowNR | Cow NR. | COW.Nr | ccode | |
#' | RatProcedure | | | | | Rat |
#' 
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(states, messydates::mreport)
#' ```
"states"
