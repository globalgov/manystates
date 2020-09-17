#' Stardadizes State Names (Function partially taken from Gnevar Package)
#'
#' @param id A string
#' @param strict By default FALSE
#' @details The function standardize state names as well as capitalises all words in the strings passed to it,
#' trimms all white space from the starts and ends of the strings, remove points and signs. 
#' @return A standard state name across datasets
#' @import textclean
#' @examples
#' @export

namesta <- function(id, strict = FALSE) {
  cap <- function(s) paste(toupper(substring(s, 1, 1)),
                           {s <- substring(s, 2); if(strict) tolower(s) else s},
                           sep = "", collapse = " " )
  out <- sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
  out[out=="NANA"] <- NA
  out <- trimws(out)
  out <- gsub("\\.(?=\\.*$)", "", out, perl=TRUE)
  out <- gsub("U.K.", "UK", out)
  out <- gsub("U.S.S.R.", "USSR", out)
  out <- gsub("U.S. ", "USA", out)
  out <- textclean::add_comma_space(out)
  
  
  out <- textclean::mgsub(out,
                          paste0("(?<!\\w)", as.roman(1:100),"(?!\\w)"),
                          as.numeric(1:100),
                          safe = T, perl = T)
  
  ords <- english::ordinal(1:100)
  ords <- paste0(ords,
                 if_else(stringr::str_count(ords, "\\S+")==2,
                         paste0("|",gsub(" ", "-", as.character(ords))),
                         ""))
  out <- textclean::mgsub(out,
                          paste0("(?<!\\w)", ords,"(?!\\w)"),
                          as.numeric(1:100),
                          safe = T, perl = T, ignore.case = T, fixed = F)
  
  out
}




#' @examples
