#' states datacube documentation
#'
#' @format The states datacube is a list that contains the
#' following 8 datasets: GW, ISD, COW, ICOW, RATRULES, and HUGGO_STATES.
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#'\describe{
#' \item{GW: }{A dataset with 216 observations and the following
#' 6 variables: cowID, Begin, End, cowNR, StateName, stateID.}
#' \item{ISD: }{A dataset with 362 observations and the following
#' 8 variables: cowID, Begin, End, cowNR, StateName, Micro, NewState, stateID.}
#' \item{COW: }{A dataset with 243 observations and the following
#' 6 variables: cowID, Begin, End, cowNR, StateName, stateID.}
#' \item{ICOW: }{A dataset with 217 observations and the following
#' 16 variables: stateID, StateName, Begin, ColRuler, IndFrom, IndViol, IndType,
#' SecFrom, SecDate, SecViol, Into, IntoDate, COWsys, GWsys, Notes, cowID.}
#' \item{RATRULES: }{A dataset with 177 observations and the following
#' 3 variables: stateID, StateName, RatProcedure.}
#' \item{HUGGO_STATES: }{A dataset with 470 observations and the following
#' 14 variables: stateID, StateName, Capital, Begin, End, StateName2, Capital2,
#' Latitude, Longitude, Area, Region, RatProcedure, Constitutional Description,
#' Source_rat.}
#' @source
#' \itemize{
#' \item{GW: }{
#' K. S. Gleditsch and M. D. Ward. “Interstate system membership: A revised list of the independent states since 1816”.
#' _International Interactions_ 25.4 (1999), pp. 393-413.
#' \url{http://ksgleditsch.com/data-4.html}
#' }
#' \item{ISD: }{
#' R. D. Griffiths and C. R. Butcher. “Introducing the international system (s) dataset (ISD), 1816-2011”.
#' _International Interactions_ 39.5 (2013), pp. 748-768.
#' \url{http://www.ryan-griffiths.com/data}
#' }
#' \item{COW: }{
#' Correlates of War Project. _State System Membership List, v2016._
#' <http://correlatesofwar.org>. Accessed: 2021-01-25.
#' \url{https://correlatesofwar.org/data-sets/state-system-membership}
#' }
#' \item{ICOW: }{
#' P. R. Hensel. (2018). _ICOW Colonial History Data Set, version 1.1._
#' <http://www.paulhensel.org/icowcol.html>.Accessed: 2021-12-23.
#' \url{http://www.paulhensel.org/icowcol.html}
#' }
#' \item{RATRULES: }{
#' B. A. Simmons. _Mobilizing for Human Rights: International Law in Domestic Politics_.
#' Cambridge University Press, 2009.
#' \url{https://doi.org/10.1017/CBO9780511811340}
#' }
#' \item{HUGGO_STATES: }{
#' J. Hollway. manystates: States for manydata. 2021.
#' Hand-coded by the GGO team.}
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
