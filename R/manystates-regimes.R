#' regimes database documentation
#'
#' @format The regimes database is a list that contains the
#' following 2 datasets: FreedomHouse, Polity5.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{FreedomHouse: }{A dataset with 10680 observations and the following
#' 47 variables: ID, cowID, Year, Label, Region, Edition, Status, PR rating,
#' CL rating, A1, A2, A3, A, B1, B2, B3, B4, B, C1, C2, C3, C, Add Q, Add A,
#' PR, D1, D2, D3, D4, D, E1, E2, E3, E, F1, F2, F3, F4, F, G1, G2, G3, G4,
#' G, CL, Total, Territory.}
#' \item{Polity5: }{A dataset with 17574 observations and the following
#' 35 variables: ID, cowID, Year, Label, p5, cyear, ccode, flag, fragment,
#' democ, autoc, polity, polity2, durable, xrreg, xrcomp, xropen, xconst,
#' parreg, parcomp, exrec, exconst, polcomp, prior, eprec, interim, bprec, post,
#' change, d5, sf, regtrans, Beg, End, speccat.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(regimes, messydates::mreport)
#' ```
"regimes"
