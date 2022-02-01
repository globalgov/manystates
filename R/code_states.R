#' Code states
#'
#' Retrieves countries from a character vector
#' @param v A character vector
#' @param abbrev Do you want 3 letter country
#' abbreviations to be returned?
#' False by default.
#' @details This function builds upon the `stat_actor` list and the
#' `countrycode` package to identify and return the parties mentioned
#' in a character vector of agreement titles or texts.
#' @return A character vector of parties, in English, separated by commas.
#' @import tibble
#' @examples
#' states <- c("Two are from Switzerland", "One from New Zealand",
#' "And one from Brazil")
#' code_states(states)
#' code_states(states, abbrev = TRUE)
#' @export
code_states <- function(v, abbrev = FALSE) {
  # Translates string to ASCII
  v <- stringi::stri_trans_general(v, "Latin-ASCII")
  if (abbrev == TRUE) {
    # Find country labels from the label column
    coment <- vapply(countryregex[, 3],
                     function(x) grepl(x, v, ignore.case = T, perl = T) * 1,
                     FUN.VALUE = double(length(v)))
    colnames(coment) <- countryregex[, 2]
    rownames(coment) <- v
    out <- apply(coment, 1, function(x) paste(names(x[x == 1]), collapse = "_"))
    out[out == ""] <- NA
    out <- unname(out)
  } else {
    # Find country codes from the label column
    coment <- vapply(countryregex[, 3],
                     function(x) grepl(x, v, ignore.case = T, perl = T) * 1,
                     FUN.VALUE = double(length(v)))
    colnames(coment) <- countryregex[, 1]
    rownames(coment) <- v
    out <- apply(coment, 1, function(x) paste(names(x[x == 1]), collapse = "_"))
    out[out == ""] <- NA
    out <- unname(out)
  }
  out
}

#' #' Code country specific indicators
#' #'
#' #' Adds various country specific codes and information to the processed
#' #' dataset. This function is only useful for contemporary countries.
#' #' @param v A character vector leading to the COW_ID column
#' #' @details This function uses the `countrycode` package to identify and
#' return
#' various country specific information such as the internet domain and unicode
#' #' flags to the pre-processed dataset.
#' #' @return A dataframe adding information to the pre-exported dataset.
#' #' @importfrom tibble as_tibble
#' #' @import countrycode
#' #' @examples
#' #' \donttest{
#' #' code_modern_states(states$COW$ID)
#' #' }
#' #' @export
 # code_modern_states <- function(v) {
 #   modinfo <- suppressWarnings(
 #         data.frame(v,
 #           UnicodeSymb = countrycode::countrycode(v,
 #                                                  "cowc",
 #                                                  "unicode.symbol"),
 #           ISO3_ID = countrycode::countrycode(v, "cowc", "iso3c"),
 #           EuroStat_code = countrycode::countrycode(v, "cowc", "eurostat"),
 #          ECB_code = countrycode::countrycode(v, "cowc", "ecb"),
 #          IANA_TLD = countrycode::countrycode(v, "cowc", "cctld"),
 #          un_code = countrycode::countrycode(v, "cowc", "un"),
 #          Continent = countrycode::countrycode(v, "cowc", "continent"),
 #        EU = countrycode::countrycode(v, "cowc", "eu28"),
 #           Currency = countrycode::countrycode(v, "cowc", "iso4217c")))
 #   modinfo  <- tibble::as_tibble(modinfo)
 #   modinfo
 # }
