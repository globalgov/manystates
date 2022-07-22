#' contiguity database documentation
#'
#' @format The contiguity database is a list that contains the
#' following 1 datasets: DIRCONT.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{DIRCONT: }{A dataset with 847 observations and the following
#' 8 variables: dyadID, ContiguityType, Beg, End, stateID1, Label1, stateID2, Label2.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(contiguity, messydates::mreport)
#' ```
"contiguity"
