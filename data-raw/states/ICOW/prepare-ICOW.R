# ICOW Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
ICOW <- readr::read_csv("data-raw/states/ICOW/coldata110.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ICOW' object until the object created
# below (in stage three) passes all the tests.
colnames <- colnames(ICOW)
colnames[[1]] <- "cowID"
colnames[[2]] <- "StateName"
cust_match <- c("260" = "GFR",
                "730" = "KOR")
ICOW <- dplyr::as_tibble(ICOW) %>%
  dplyr::na_if(-9) %>%
  dplyr::na_if(-90) %>%
  dplyr::mutate(cowID = countrycode::countrycode(State,
                                                  "cown",
                                                  "cowc",
                                                  custom_match = cust_match)) %>%
  # Preprocess strings for {messydates}
  dplyr::mutate(Begin = ifelse(nchar(as.character(IndDate)) == 6,
                                 paste0(substr(as.character(IndDate), 1, 4),
                                        "-",
                                        substr(as.character(IndDate), 5, 6)),
                                 ifelse(nchar(as.character(IndDate)) == 8,
                                        paste0(substr(as.character(IndDate),
                                                      1, 4),
                                               "-",
                                               substr(as.character(IndDate),
                                                      5, 6),
                                               "-",
                                               substr(as.character(IndDate),
                                                      7, 8)),
                                        ifelse(nchar(as.character(IndDate)) == 5,
                                               paste0(substr(as.character(IndDate),
                                                             1, 3),
                                                      "-",
                                                      substr(as.character(IndDate),
                                                             4, 5)),
                                               IndDate))),
                SecDate = ifelse(nchar(as.character(SecDate)) == 6,
                                 paste0(substr(as.character(SecDate), 1, 4),
                                       "-",
                                       substr(as.character(SecDate), 5, 6)),
                                 ifelse(nchar(as.character(SecDate)) == 8,
                                        paste0(substr(as.character(SecDate),
                                                      1, 4),
                                       "-",
                                       substr(as.character(SecDate), 5, 6),
                                       "-",
                                       substr(as.character(SecDate), 7, 8)),
                                 ifelse(nchar(as.character(SecDate)) == 5,
                                        paste0(substr(as.character(SecDate),
                                                      1, 3),
                                               "-",
                                               substr(as.character(SecDate),
                                                      4, 5)),
                                  SecDate))),
                IntoDate = ifelse(nchar(as.character(IntoDate)) == 6,
                                 paste0(substr(as.character(IntoDate), 1, 4),
                                        "-",
                                        substr(as.character(IntoDate), 5, 6)),
                                 ifelse(nchar(as.character(IntoDate)) == 8,
                                        paste0(substr(as.character(IntoDate),
                                                      1, 4),
                                               "-",
                                               substr(as.character(IntoDate),
                                                      5, 6),
                                               "-",
                                               substr(as.character(IntoDate),
                                                      7, 8)),
                                        ifelse(nchar(as.character(IntoDate)) == 5,
                                               paste0(substr(as.character(IntoDate),
                                                             1, 3),
                                                      "-",
                                                      substr(as.character(IntoDate),
                                                             4, 5)),
                                               IntoDate))),
                COWsys = ifelse(nchar(as.character(COWsys)) == 6,
                                  paste0(substr(as.character(COWsys), 1, 4),
                                         "-",
                                         substr(as.character(COWsys), 5, 6)),
                                  ifelse(nchar(as.character(COWsys)) == 8,
                                         paste0(substr(as.character(COWsys),
                                                       1, 4),
                                                "-",
                                                substr(as.character(COWsys),
                                                       5, 6),
                                                "-",
                                                substr(as.character(COWsys), 7, 8)),
                                         ifelse(nchar(as.character(COWsys)) == 5,
                                                paste0(substr(as.character(COWsys), 1, 3),
                                                       "-",
                                                       substr(as.character(COWsys), 4, 5)),
                                                COWsys))),
                GWsys = ifelse(nchar(as.character(GWsys)) == 6,
                                paste0(substr(as.character(GWsys), 1, 4),
                                       "-",
                                       substr(as.character(GWsys), 5, 6)),
                                ifelse(nchar(as.character(GWsys)) == 8,
                                       paste0(substr(as.character(GWsys), 1, 4),
                                              "-",
                                              substr(as.character(GWsys), 5, 6),
                                              "-",
                                              substr(as.character(GWsys), 7, 8)),
                                       ifelse(nchar(as.character(GWsys)) == 5,
                                              paste0(substr(as.character(GWsys),
                                                            1, 3),
                                                     "-",
                                                     substr(as.character(GWsys),
                                                            4, 5)),
                                              GWsys)))) %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin),
                SecDate = messydates::as_messydate(SecDate),
                IntoDate = messydates::as_messydate(IntoDate),
                COWsys = messydates::as_messydate(COWsys),
                GWsys = messydates::as_messydate(GWsys)) %>%
  manydata::transmutate(StateName = manypkgs::standardise_titles(Name)) %>%
  dplyr::select(-State) %>%
  dplyr::arrange(cowID)
# Reorder columns
ICOW <- ICOW[, colnames]

# ensure NAs are coded correctly
ICOW <- ICOW %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(.,
                                                 "^NA$", NA_character_))) %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin),
                SecDate = messydates::as_messydate(SecDate),
                IntoDate = messydates::as_messydate(IntoDate),
                COWsys = messydates::as_messydate(COWsys),
                GWsys = messydates::as_messydate(GWsys))

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make ICOW available
# within the package.
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards.You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point.
# Any test failures should be pretty self-explanatory and may require
# you to return to stage two and further clean, standardise, or wrangle
# your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please note that the export_data() function requires a .bib file to be
# present in the data_raw folder of the package for citation purposes.
# Therefore, please make sure that you have permission to use the dataset
# that you're including in the package.
# To add a template of .bib file to package,
# run `manypkgs::add_bib(states, ICOW)`.
manypkgs::export_data(ICOW, datacube = "states",
                      URL = "http://www.paulhensel.org/icowcol.html")
