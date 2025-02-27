# COW_CONT Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
COW_CONT <- readr::read_csv("data-raw/contiguity/COW_CONT/contdir.csv")
# version 3.2

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'COW_CONT' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`
# and `standardise_texts()`.
# Please see the vignettes or website for more details.
COW_CONT <- as_tibble(COW_CONT) %>%
  dplyr::rename(dyadID = dyad, cowNR1 = statelno, cowNR2 = statehno,
                ContiguityType = conttype) %>%
  manydata::transmutate(Begin = messydates::as_messydate(as.character(begin),
                                                         resequence = "ym"),
                        End = messydates::as_messydate(as.character(end),
                                                       resequence = "ym"),
                        cowID1 = manypkgs::standardize_titles(statelab),
                        cowID2 = manypkgs::standardize_titles(statehab)) %>%
  # Add StateName var to facilitate consolidation with other datasets
  dplyr::mutate(StateName1 = countrycode::countrycode(cowID1, origin = "cowc",
                                                      destination = "country.name"),
                StateName2 = countrycode::countrycode(cowID2, origin = "cowc",
                                                      destination = "country.name")) %>%
  # manually correct names
  dplyr::mutate(StateName1 = ifelse(cowID1 == "KOR", "Republic of Korea", StateName1),
                StateName1 = ifelse(cowID1 == "GFR", "Germany", StateName1),
                StateName1 = ifelse(StateName1 == "Congo - Kinshasa",
                                    "Democratic Republic of the Congo",
                                    StateName1),
                StateName1 = ifelse(StateName1 == "Congo - Brazzaville",
                                    "Congo", StateName1),
                StateName2 = ifelse(cowID2 == "KOR", "Republic of Korea", StateName2),
                StateName2 = ifelse(cowID2 == "GFR", "Germany", StateName2),
                StateName2 = ifelse(StateName2 == "Congo - Kinshasa",
                                    "Democratic Republic of the Congo",
                                    StateName2),
                StateName2 = ifelse(StateName2 == "Congo - Brazzaville",
                                    "Congo", StateName2)) %>%
  # Add standardised stateID var to facilitate consolidation with other datasets
  dplyr::mutate(StateName1 = manypkgs::code_states(StateName1, activity = FALSE,
                                                   replace = "names"),
                stateID1 = manypkgs::code_states(StateName1, activity = FALSE,
                                                 replace = "ID"),
                StateName2 = manypkgs::code_states(StateName2, activity = FALSE,
                                                   replace = "names"),
                stateID2 = manypkgs::code_states(StateName2, activity = FALSE,
                                                 replace = "ID")) %>%
  dplyr::select(-c(notes, version)) %>%
  dplyr::relocate(dyadID, ContiguityType, Begin, End, cowNR1, cowID1, cowNR2,
                  cowID2, stateID1, StateName1, stateID2, StateName2) %>%
  dplyr::arrange(Begin)

# Stage three: Connecting data
# Next run the following line to make COW_CONT available
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
# To add a template of .bib file to the package,
# please run `manypkgs::add_bib("contiguity", "COW_CONT")`.
manypkgs::export_data(COW_CONT, datacube = "contiguity",
                      URL = "https://correlatesofwar.org/data-sets/direct-contiguity")
