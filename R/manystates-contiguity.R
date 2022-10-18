#' contiguity database documentation
#'
#' @format The contiguity database is a list that contains the
#' following 2 datasets: COW_DIRCONT, HUGGO_CONT.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#' @imports manydata
#'\describe{
#' \item{COW_DIRCONT: }{A dataset with 847 observations and the following
#' 8 variables: dyadID, ContiguityType, Beg, End, stateID1, Label1, stateID2, Label2.}
#' \item{HUGGO_CONT: }{A dataset with 192 observations and the following
#' 9 variables: stateID, Label, Beg, End, Contiguity, EntityType, FAOmembership, Group, url.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(contiguity, messydates::mreport)
#' ```
"contiguity"
