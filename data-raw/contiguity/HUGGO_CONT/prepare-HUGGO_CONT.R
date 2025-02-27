# HUGGO_CONT Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
HUGGO_CONT <- readr::read_csv("data-raw/contiguity/HUGGO_CONT/FAO and Region Membership Data.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'HUGGO_CONT' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
HUGGO_CONT <- as_tibble(HUGGO_CONT) %>%
  dplyr::filter(ID != "ISO3") %>%
  # filtering removes the rows that contain repetitions of variable names only
  dplyr::rename(stateID = ID, url = URL) %>%
  manydata::transmutate(StateName1 = manypkgs::standardise_titles(LISTNAME_EN),
                        Contiguity = HAS_BORDER_WITH,
                        Begin = messydates::as_messydate(VALID_SINCE),
                        End = messydates::as_messydate(VALID_UNTIL)) %>%
  dplyr::mutate(StateName1 = manypkgs::code_states(StateName1, activity = F,
                                                  replace = "names"),
                StateName1 = ifelse(stateID == "CIV", "Cote d'Ivoire",
                                   StateName1),
                StateName1 = ifelse(stringr::str_detect(StateName1, "Korea - "),
                                    "Democratic People's Republic of Korea",
                                    StateName1)) %>%
  tidyr::separate_wider_delim(Contiguity, delim = ",",
                              names_sep = "_", too_few = "align_start") %>%
  tidyr::pivot_longer(c("Contiguity_1":"Contiguity_14"),
                      values_to = "StateName", values_drop_na = TRUE) %>%
  dplyr::mutate(StateName = stringr::str_remove_all(StateName, "_the"),
                StateName = stringr::str_replace_all(StateName, "_", " "),
                StateName2 = manypkgs::code_states(StateName, activity = F,
                                                   replace = "names"),
                StateName2 = ifelse(is.na(StateName2), StateName, StateName2),
                StateName2 = ifelse(stringr::str_detect(StateName2, "Korea - "),
                                    "Democratic People's Republic of Korea",
                                    StateName2),
                stateID2 = manypkgs::code_states(StateName2, activity = F,
                                                 replace = "ID"),
                stateID2 = ifelse(stateID2 == "KOR - PRK", "PRK", stateID2),
                stateID1 = manypkgs::code_states(StateName1, activity = F,
                                                 replace = "ID"),
                stateID1 = ifelse(is.na(stateID1), stateID, stateID1),
                stateID1 = ifelse(stateID1 == "KOR - PRK", "PRK", stateID1),
                # coding standardised with COW_CONT: 1 = shared border
                ContiguityType = 1) %>%
  dplyr::select(stateID1, stateID2, Begin, End, StateName1, StateName2,
                ContiguityType, url) %>%
  dplyr::arrange(Begin, stateID1)

# make sure all vars are correctly coded as NA if necessary
HUGGO_CONT <- HUGGO_CONT %>% 
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(., "^NA$", NA_character_))) %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin),
                End = messydates::as_messydate(End),
                ContiguityType = as.numeric(ContiguityType)) %>% 
  dplyr::distinct(.keep_all = TRUE)

# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`
# and `standardise_texts()`.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make HUGGO_CONT available
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
# please run `manypkgs::add_bib("contiguity", "HUGGO_CONT")`.
manypkgs::export_data(HUGGO_CONT, datacube = "contiguity",
                      URL = "Hand-coded data by the GGO team")
