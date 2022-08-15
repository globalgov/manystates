#' regimes database documentation
#'
#' @format The regimes database is a list that contains the
#' following 4 datasets: Polity5, FHaggregate, FHstatus, FHfull.
#' FHaggregate, FHstatus, and FHfull datasets are all part of
#' the FreedomHouse data that have been imported into the package
#' as three datasets as they are provided as three distinct Excel files.
#' The FHaggregate dataset contains aggregate scores from the 2003-2021 edition
#' and the FHfull dataset contains detailed scores from the 2013-2021 edition.
#' The FHstatus dataset contains only data on the Freedom House status of 
#' countries and territories.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{Polity5: }{A dataset with 17574 observations and the following
#' 35 variables: ID, cowID, Year, Label, p5, cyear, ccode, flag, fragment, democ, autoc, polity, polity2, durable, xrreg, xrcomp, xropen, xconst, parreg, parcomp, exrec, exconst, polcomp, prior, eprec, interim, bprec, post, change, d5, sf, regtrans, Beg, End, speccat.}
#' \item{FHaggregate: }{A dataset with 3960 observations and the following
#' 22 variables: ID, cowID, Year, Label, Region, Edition, Status, PR rating, CL rating, A, B, C, Add Q, Add A, PR, D, E, F, G, CL, Total, Territory.}
#' \item{FHstatus: }{A dataset with 11088 observations and the following
#' 8 variables: ID, cowID, Year, Label, PR rating, CL rating, Status, Territory.}
#' \item{FHfull: }{A dataset with 1885 observations and the following
#' 47 variables: ID, cowID, Year, Label, Region, Edition, Status, PR rating, CL rating, A1, A2, A3, A, B1, B2, B3, B4, B, C1, C2, C3, C, Add Q, Add A, PR, D1, D2, D3, D4, D, E1, E2, E3, E, F1, F2, F3, F4, F, G1, G2, G3, G4, G, CL, Total, Territory.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(regimes, messydates::mreport)
#' ```
"regimes"
