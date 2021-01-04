#' Code parties
#'
#' Retrieves countries from a character vector
#' @param v A character vector
#' @details This function builds upon the `stat_actor` list and the
#' `countrycode` package to identify and return the parties mentioned
#' in a character vector of agreement titles or texts.
#' @return A character vector of parties, in English, separated by commas.
#' @import tibble	
#' @examples
#' \dontrun{
#' code_states(states$ISD$Label)[1:3]
#' }
#' @export
code_states <- function(v){
  
  # countryregex <- read.csv("data-raw/Stat_Actor/stat_regex.csv", stringsAsFactors = F) %>%
  #   as.data.frame()
  
  # Find country codes
  coment <- sapply(countryregex[,3], function(x) grepl(x, v, ignore.case = T, perl = T)*1)
  colnames(coment) <- countryregex[,1]
  rownames(coment) <- v
  
  out <- apply(coment, 1, function(x) paste(names(x[x==1]), collapse = "_"))
  out[out==""] <- NA
  out <- unname(out)
  out
}
