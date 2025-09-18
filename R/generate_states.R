#' Generate a list of fictional country names
#' @param n Integer number of country names to generate
#'   from a library of fictional country names.
#' @param prefixed Proportion of country names with a prefix by default 0.15.
#' @param suffixed Proportion of country names with a suffix by default 0.15.
#' @return String vector of fictional country names
#' @importFrom stringi stri_trim_both
#' @examples
#'   generate_states(12)
#' @export
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
      if(state == "of" && name_parts[length(name_parts)-1] == "of") next
      if(state == "and" && name_parts[length(name_parts)-1] == "and") next
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
