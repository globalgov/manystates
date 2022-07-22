#' states database documentation
#'
#' @format The states database is a list that contains the
#' following 5 datasets: GW, ISD, COW, ICOW, GNEVAR_STATES.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{GW: }{A dataset with 216 observations and the following
#' 5 variables: COW_ID, Beg, End, COW_Nr, Label.}
#' \item{ISD: }{A dataset with 362 observations and the following
#' 7 variables: COW_ID, Beg, End, COW_Nr, Label, Micro, New.State.}
#' \item{COW: }{A dataset with 243 observations and the following
#' 5 variables: COW_ID, Beg, End, COW_Nr, Label.}
#' \item{ICOW: }{A dataset with 217 observations and the following
#' 15 variables: COW_ID, Label, ColRuler, IndFrom, IndDate, IndViol,
#' IndType, SecFrom, SecDate, SecViol, Into, IntoDate, COWsys, GWsys, Notes.}
#' \item{GNEVAR_STATES: }{A dataset with 707 observations and the following
#' 9 variables: stateID, Label, Capital, Beg, End, Latitude, Longitude, Area, Region.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(states, messydates::mreport)
#' ```
"states"
