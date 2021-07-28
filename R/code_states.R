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
code_states <- function(v) {
  # countryregex <- read.csv("data-raw/states/Stat_Actor/stat_regex.csv",
  #                          stringsAsFactors = F) %>%
  # as.data.frame()
  # Find country codes from the label column
  coment <- sapply(countryregex[, 3], function(x) grepl(x, v,
                                                       ignore.case = T,
                                                       perl = T) * 1)
  colnames(coment) <- countryregex[, 1]
  rownames(coment) <- v
  out <- apply(coment, 1, function(x) paste(names(x[x == 1]), collapse = "_"))
  out[out == ""] <- NA
  out <- unname(out)
  # Some agreements are made between unions of countries and others,
  # but are still considered bilateral. In these cases, abbreviations
  # for unions will have 2 letters instead of 3.
  out
}

# Additional code leveraging the already present COW_ID(ID)

#' Code country specific indicators
#'
#' Adds various country specific codes and information to the processed
#' dataset. This function is only useful for contemporary countries.
#' @param v A character vector leading to the COW_ID column
#' @details This function uses the `countrycode` package to identify and return
#' various country specific information such as the internet domain and unicode
#' flags to the preprocessed dataset.
#' @return A dataframe adding information to the pre-exported dataset.
#' @import tibble
#' @examples
#' \dontrun{
#' code_modern_states(states$ISD$ID)
#' }
#' @export
code_modern_states <- function(v) {
  if ("countrycode" %in% rownames(utils::installed.packages()) == FALSE) {
    stop("Please install the countrycode package before proceeding.")
  }
  modinfo <- suppressWarnings(
        data.frame(v,
          UnicodeSymb = countrycode::countrycode(v, "cowc", "unicode.symbol"),
          ISO3_ID = countrycode::countrycode(v, "cowc", "iso3c"),
          EuroStat_code = countrycode::countrycode(v, "cowc", "eurostat"),
          ECB_code = countrycode::countrycode(v, "cowc", "ecb"),
          IANA_TLD = countrycode::countrycode(v, "cowc", "cctld"),
          un_code = countrycode::countrycode(v, "cowc", "un"),
          Continent = countrycode::countrycode(v, "cowc", "continent"),
          EU = countrycode::countrycode(v, "cowc", "eu28"),
          Currency = countrycode::countrycode(v, "cowc", "iso4217c")))
  modinfo  <- as_tibble(modinfo)
  modinfo
}
