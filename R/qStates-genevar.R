#' Genevar database documentation
#'
#' @format The genevar database is a list that contains the
#' following 1 datasets: ARCHIGOSgenevar. This database contains similar
#' datasets than the others but with our hand-coded modifications. These may
#' include typos that we spotted during the import/cleaning and processing steps
#' of the original data or other corrections. These modifications are kept
#' separate in the Genevar database so as to stay true to the standardize
#' without modifying process.
#' For more information and references to each of the datasets used,
#' please use the `data_source()`, `data_contrast()`, and `data_evolution()`
#' functions.
#'\describe{
#' \item{ARCHIGOSgenevar: }{A dataset with 24 observations and the following
#' 30 variables: ID, LeadID, ccode, idacr, Label, leader, Beg, End, BornDate, DeathDate, YearBorn, YearDied, Female, entry, exit, exitcode, prevtimesinoffice, posttenurefate, dbpedia.uri, num.entry, num.exit, num.exitcode, num.posttenurefate, FtiesNameA, FtiesCodeA, FtiesNameB, FtiesCodeB, FtiesNameC, FtiesCodeC, ftcur.}
#' }
 "genevar"
