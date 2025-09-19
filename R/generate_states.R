#' Generate fictional country names
#' @description
#'   This function generates a vector of fictional country names.
#'   While the generated names are designed to resemble real country names,
#'   the results will not match (at least not exactly) country names from
#'   the library provided.
#'   
#'   The names are generated using a Markov chain approach based on
#'   syllable patterns found in a library of real country names.
#'   The function `generate_states()` uses the `syllabise_states()` function
#'   to split existing country names into syllable-like units,
#'   providing special attention to common patterns in country names
#'   such as "land", "stan", "burg", and others.
#'   A transition matrix is then built from these syllable units,
#'   allowing for the generation of new names that mimic the structure and
#'   length of real country names.
#'   Checks are included to ensure that the generated names
#'   are unique, do not match any existing country names,
#'   and avoid certain uncommon patterns such as ending on a preposition.
#'   
#'   If no library of country names is provided,
#'   the function defaults to using a comprehensive list
#'   of country names from the `{manystates}` package.
#'   However, users can supply their own list of country names
#'   to customize the generation process.
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
#' @param countries Optional string vector of country names
#'   to use as a library for generating fictional names.
#' @return String vector of fictional country names
#' @importFrom stringi stri_trim_both
NULL

#' @rdname generate_states
#' @examples
#'   generate_states(12)
#' @export
generate_states <- function(n = 10, countries = NULL) {
  
  if(is.null(countries)){
    countries <- unique(unlist(lapply(names(manystates::states), 
                                      function(x) if("StateNameAlt" %in% names(manystates::states[[x]])) {
                                        c(manystates::states[[x]]$StateName, 
                                          manystates::states[[x]]$StateNameAlt) } else {
                                            manystates::states[[x]]$StateName
                                          })))
  } 
  unique_countries <- unique(tolower(stringi::stri_trans_general(countries, 
                                                                 "Latin-ASCII")))
  unique_countries <- stringi::stri_replace_all_regex(unique_countries, "\\(|\\)", "")
  unique_countries <- stringi::stri_replace_all_regex(unique_countries, ",", "")
  
  # Use improved syllable splitter
  syllable_list <- syllabise_states(unique_countries)
  
  # Record syllable length distribution
  syllable_lengths <- sapply(syllable_list, length)
  
  # Build transitions
  transitions <- list()
  for (sylls in syllable_list) {
    seq <- c(sylls, "END")
    for (i in seq_along(seq)[-length(seq)]) {
      from <- seq[i]
      to <- seq[i + 1]
      transitions[[from]] <- c(transitions[[from]], to)
    }
  }
  
  # prefixlib <- c("The ", "Central ", 
  #                "North ", "Northern ", "South", "Southern ", 
  #                "West ", "Western ", "East ", "Eastern ", 
  #                "Empire of ", "Kingdom of ", "Republic of ", 
  #                "United ", "United States of ", 
  #                "Isle of ", 
  #                "New ", 
  #                "Saint ", "San ", 
  #                "Upper ", "Lower ")
  # suffixlib <- c(" Confederacy", " Empire", " Islands", " Kingdom", " Republic", 
  #                " Union", " United", " Republic")
  
  generate_name <- function() {
    target_len <- sample(syllable_lengths, 1)
    poss_starts <- names(transitions)
    poss_starts <- poss_starts[!stringi::stri_detect_regex(poss_starts, 
                                                           "^.( |-)|and|of", 
                                                           case_insensitive=TRUE)]
    state <- sample(poss_starts, 1)
    name_parts <- c(state)
    
    while (state != "END" && length(name_parts) < target_len) {
      state <- sample(transitions[[state]], 1)
      if(state == "END" && length(name_parts) < target_len){
        state <- " "
      }
      if(state == " " && name_parts[length(name_parts)] == " ") next
      # avoid preposition chaining
      if(state == "and" && name_parts[length(name_parts)-1] %in% c("and","of","the")) next
      if(state == "of" && name_parts[length(name_parts)-1] %in% c("and","of","the")) next
      if(state == "the" && name_parts[length(name_parts)-1] %in% c("and","of","the")) next
      name_parts <- c(name_parts, state)
    }
    
    name <- paste(name_parts, collapse = "")
    stringi::stri_trim_both(stringi::stri_trans_totitle(name))
  }
  
  check_candidate <- function(candidate, results, unique_countries){
    
    lcand <- tolower(candidate)
    
    if(lcand %in% tolower(results)){ # check unique
      return(results)
    } else if(lcand %in% tolower(unique_countries)){ # check fictional
      return(results)
    } else if(grepl("-$| of$|^saint$| [a-z]$", lcand)){ # check ending
      return(results)
    } else {
      return(c(results, candidate))
    }
  }
  
  results <- character()
  while (length(results) < n) {
    candidate <- generate_name()
    results <- check_candidate(candidate, results, unique_countries)
  }
  
  results
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
  pattern <- paste0("(?i)(?:", specials, ")|\\s+|(?:[^aeiou\\s]*[aeiou]+(?:[^aeiou\\s]*?(?=(?:", specials, ")|\\s|$))?)")
  stringi::stri_extract_all_regex(word, pattern)[[1]]
}

#' @rdname generate_states
#' @export
syllabize_states <- syllabise_states

