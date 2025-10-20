#' Generate fictional country names
#' @description
#'   This function generates a vector of fictional country names.
#'   While the generated names are designed to resemble real country names,
#'   the results will not match (at least not exactly) country names from
#'   the library provided.
#'   Please note that the function is still _experimental_.
#'   
#'   Checks are included to ensure that the generated names
#'   are unique, do not match any existing country names,
#'   and avoid certain uncommon patterns such as ending on a preposition.
#'   
#'   This function can be useful for creating fictional datasets
#'   for testing, illustrative, or pedagogical purposes.
#'   For example, it can be used in classroom exercises that rely on
#'   invented country names, such as 
#'   in-class simulations of international relations or negotiation,
#'   role-playing scenarios,
#'   or mock data analysis tasks.
#'   Using fictional country names helps avoid any unintended
#'   bias or preconceptions associated with real countries.
#'   Or they can be used in creative writing or game design.
#'   The names might inspire fictional settings or entities
#'   in stories, games, or other creative works.
#'   Each name could inspire a unique culture, conflict, or mythology. 
#'   Writers could use them to kickstart short stories, 
#'   while game designers might build entire maps or quests around them.
#' 
#' @name generate_states
#' @param n Integer number of country names to generate
#'   from a library of fictional country names.
#'   Default is 10.
#' @param countries Optionally, a list of country names (string vector)
#'   from which to identify the prevalence of modifiers.
#' @param short Logical whether to reference a list of shorter country names,
#'   or to include longer alternative names as well.
#'   Default is `FALSE`, meaning both shorter and longer names are used.
#' @return String vector of fictional country names
#' @importFrom stringi stri_trim_both
NULL

#' @rdname generate_states
#' @examples
#'   generate_states(12)
#' @export
generate_states <- function(n = 10, countries = NULL, short = FALSE) {
  
  if(!is.null(countries)) {
    stnames <- countries
  } else {
    if (short) {
      stnames <- manystates::states$GGO$StateName
    } else {
      stnames <- stats::na.omit(c(manystates::states$GGO$StateName, 
                           manystates::states$GGO$StateNameAlt))
    }
  }
  modifiers <- c("New", "North", "South", "East", "West", "Central", 
                 "Northern","Southern","Eastern","Western",
                 "United", "United States of", "United Republic of",
                 "Old", "Great", "Upper", "Lower", "Isle of",
                 "Federal", "Federation of", "Saint", "San", "The",
                 "Democratic People's Republic of", "Federal Republic of", 
                 "Republic of", "Republic of the", "Commonwealth of",
                 "Kingdom of", "Kingdom of the", "Principality of", "Emirate of")
  modweights <- vapply(modifiers, 
                       FUN = function(x) sum(stringi::stri_detect_fixed(stnames, x)), 
                       FUN.VALUE = integer(1))
  modweights <- c("BLANK"=max(length(stnames)-sum(modweights),0), modweights)
  modifiers <- c("", modifiers)
  modweights <- modweights/length(stnames)
  
  results <- character()
  while (length(results) < n) {
    candidate <- generate_name(modifiers, modweights)
    if (!(tolower(candidate) %in% tolower(results,stnames))) {
      results <- c(results, candidate)
    }
  }
  results
}

generate_name <- function(modifiers, modweights) {
  # forms <- c("", "Republic", "Kingdom", "Empire", "Union", "Confederation", 
  # "Islands", "Federation")
  
  core <- generate_place()
  mod <- sample(modifiers, 1, prob = modweights)
  # form <- sample(forms, 1)
  
  stringi::stri_trim_both(paste(mod, core))
}

generate_place <- function() {
  syllables <- c("bar","bel","ger","kia","mar","nia","oko","ora","pol","qua",
                 "tan","tur","var","ven","zor")
  suffixes <- c("acy", "any", 
                "burg", "berg", 
                "ia", "nia", "via", "ria", "sia",
                "land", "stan", 
                "tia", "dom", "tion","stein","ican",
                "mere", "ford", "ton")
  n <- sample(1:2, 1)
  core <- paste0(sample(syllables, n, replace=TRUE), collapse="")
  suffix <- sample(suffixes, 1)
  core <- paste0(core, suffix)
  stringi::stri_trans_totitle(core)
}


#' @rdname generate_states
#' @param word One or more words (character vector) to split into syllable-like units.
#' @examples
#'   syllabise_states("Afghanistan")
#'   syllabise_states("Saint Pierre and Miquelon")
#' @export
syllabise_states <- function(word) {
  
  if(length(word) > 1) return(lapply(word, syllabise_states))
  
  # standardise input
  word <- tolower(stringi::stri_trans_general(word, "Latin-ASCII")) # remove accents
  word <- stringi::stri_trim_both(word)
  
  # Regex: match consonant cluster + vowel cluster as a unit
  # This captures patterns like "bra", "zil", "ar", "gen", "ti", "na"
  specials <- "burg|stan|land|dem|ia|king|af|ab|st |tion|acy|turk|stadt|-|arc|sax|nam"
  specials <- c(specials, "empire|republic|united|union")
  pattern <- paste0("(?i)(?:", specials, ")|\\s+|(?:[^aeiou\\s]*[aeiou]+(?:[^aeiou\\s]*?(?=(?:", specials, ")|\\s|$))?)")
  stringi::stri_extract_all_regex(word, pattern)[[1]]
}

#' @rdname generate_states
#' @export
syllabize_states <- syllabise_states

