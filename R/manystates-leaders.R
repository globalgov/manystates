#' leaders datacube documentation
#'
#' @format The leaders datacube is a list that contains the
#' following 2 datasets: ARCHIGOS, HUGGO_ARCHIGOS.
#' For more information and references to each of the datasets used,
#' please use the `data_source()` and `data_contrast()` functions.
#'\describe{
#' \item{ARCHIGOS: }{A dataset with 17686 observations and the following
#' 30 variables: archigosID, leaderID, cowID, idacr, StateName, leader, Beg,
#' End, BornDate, DeathDate, YearBorn, YearDied, Female, entry, exit, exitcode,
#' prevtimesinoffice, posttenurefate, dbpedia.uri, num.entry, num.exit,
#' num.exitcode, num.posttenurefate, FtiesNameA, FtiesCodeA, FtiesNameB,
#' FtiesCodeB, FtiesNameC, FtiesCodeC, ftcur.}
#' \item{HUGGO_ARCHIGOS: }{A dataset with 24 observations and the following
#' 30 variables: archigosID, cowID, leaderID, idacr, StateName, leader, Beg,
#' End, BornDate, DeathDate, YearBorn, YearDied, Female, entry, exit, exitcode,
#' prevtimesinoffice, posttenurefate, dbpedia.uri, num.entry, num.exit,
#' num.exitcode, num.posttenurefate, FtiesNameA, FtiesCodeA, FtiesNameB,
#' FtiesCodeB, FtiesNameC, FtiesCodeC, ftcur.}
#' }
#'
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(leaders, messydates::mreport)
#' ```
"leaders"
