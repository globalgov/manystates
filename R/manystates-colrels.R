#' colrels database documentation
#'
#' @format The colrels database is a list that contains the
#' following 1 datasets: ICOW_COL.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{ICOW_COL: }{A dataset with 221 observations and the following
#' 8 variables: COW_ID, Label, Beg, Origin_COW_ID, IndepType,
#' Beg_COW, Beg_GW, Beg_Polity2.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(colrels, messydates::mreport)
#' ```
"colrels"
