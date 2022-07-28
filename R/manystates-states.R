#' states database documentation
#'
#' @format The states database is a list that contains the
#' following 7 datasets: GW, ISD, COW, ICOW, GNEVAR_STATES, ICOW_COL, RATRULES.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{GW: }{A dataset with 216 observations and the following
#' 5 variables: cowID, Beg, End, cowNR, Label.}
#' \item{ISD: }{A dataset with 362 observations and the following
#' 7 variables: cowID, Beg, End, cowNR, Label, Micro, NewState.}
#' \item{COW: }{A dataset with 243 observations and the following
#' 5 variables: cowID, Beg, End, cowNR, Label.}
#' \item{ICOW: }{A dataset with 217 observations and the following
#' 15 variables: cowID, Label, ColRuler, IndFrom, IndDate, IndViol, IndType,
#' SecFrom, SecDate, SecViol, Into, IntoDate, COWsys, GWsys, Notes.}
#' \item{GNEVAR_STATES: }{A dataset with 707 observations and the following
#' 9 variables: stateID, Label, Capital, Beg, End, Latitude, Longitude,
#' Area, Region.}
#' \item{ICOW_COL: }{A dataset with 221 observations and the following
#' 9 variables: cowID, cowNR, Label, Beg, cowID_Origin, IndepType, Beg_COW,
#' Beg_GW, Beg_Polity2.}
#' \item{RATRULES: }{A dataset with 215 observations and the following
#' 5 variables: stateID, Label, RatProcedure, ConstitutionalDesc, url.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(states, messydates::mreport)
#' ```
"states"
