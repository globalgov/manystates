#' ratrules database documentation
#'
#' @format The ratrules database is a list that contains the
#' following 1 datasets: RATRULES.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{RATRULES: }{A dataset with 215 observations and the following
#' 5 variables: stateID, Label, RatProcedure, ConstitutionalDesc, url.}
#' }

#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(ratrules, messydates::mreport)
#' ```
"ratrules"
