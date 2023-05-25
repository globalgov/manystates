#' Generate a list of fictional country names
#' @param n Integer number of country names to generate
#'   from a library of fictional country names.
#' @param prefixed Proportion of country names with a prefix by default 0.15.
#' @param suffixed Proportion of country names with a suffix by default 0.15.
#' @return String vector of fictional country names
#' @importFrom stringr str_trim
#' @examples
#'   generate_states(12)
#' @export
generate_states <- function(n = 10, prefixed = 0.15, suffixed = 0.15){
  namelib <- c("Malania", "Maliwar", "Rhonda", "Astan", "Boroland", "Jawar", 
               "Teldir", "Toramos", "Lanfal", "Samovar", "Westenam", "Aramin", "Cradis", 
               "Samonda", "Volorea", "Telti", "Jormos", "Karador", "Paradis", "Yutria", "Osmayya",
               "Glayland", "Etror", "Esweau", "Askor", "Ugraria")
  prefixlib <- c("The", "Central", "East", "Eastern", "Empire of", "Isle of", 
                 "Kingdom of", "New", "North", "Northern", "Repulic of", 
                 "Saint", "San", "South", "Southern", "United", 
                 "The United States of", "Upper", "West", "Western")
  prefixlib <- c(prefixlib, rep("", round(length(prefixlib)/(prefixed*100)*100) - length(prefixlib)))
  suffixlib <- c("Confederacy", "Empire", "Islands", "Kingdom", "Republic", "Union", "United")
  suffixlib <- c(suffixlib, rep("", round(length(suffixlib)/(suffixed*100)*100) - length(suffixlib)))
  stringr::str_trim(paste(sample(prefixlib, n), sample(namelib, n), sample(suffixlib, n)))
}