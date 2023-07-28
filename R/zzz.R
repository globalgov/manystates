.onAttach <- function(lib, pkg) {
  msg <- c(paste0("manystates ", utils::packageVersion("manystates")),
           "\nFor more information about the package please visit https://globalgov.github.io/manystates/",
           "\nType 'citation(\"manystates\")' for citing this R package in publications.")
  packageStartupMessage(msg)      
  invisible()
}
