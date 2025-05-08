# ISD Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many packages universe

# Stage one: Collecting data
ISD <- readxl::read_excel("data-raw/states/ISD/ISD+V2.xlsx")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ISD' object until the object created
# below (in stage three) passes all the tests.
ISD <- tibble::as_tibble(ISD) %>%
  # standardizing State Name
  dplyr::mutate(StateName = manypkgs::standardise_titles(as.character(StateName))) %>%
  manydata::transmutate(StateName2 = manypkgs::standardise_titles(as.character(OtherName))) %>%
  # standardizing ID vars
  dplyr::rename(cowNR = COWNum, cowID = COWID) %>%
  dplyr::mutate(stateID = manypkgs::code_states(StateName, activity = F,
                                                replace = "ID")) %>%
  # standardizing Begin and End dates
  manydata::transmutate(Begin = ifelse(EStart != -9,
                                       messydates::as_messydate(EStart, resequence = "dmy"),
                                       messydates::as_messydate(Start, resequence = "dmy"))) %>%
  dplyr::mutate(Begin = ifelse(EStart_Am == 1|Start_Am == 1,
                               messydates::as_uncertain(Begin), Begin),
                End = messydates::as_messydate(End, resequence = "dmy"),
                End = ifelse(End_Am == 1, messydates::as_uncertain(End), End)) %>%
  # Dropping unnecessary columns
  dplyr::relocate(stateID, StateName, StateName2, Begin, End,
                  Latitude, Longitude, StartType, EndType, cowID, cowNR) %>%
  # Arrange observations
  dplyr::arrange(Begin, stateID)

# Fix NAs in stateID
ISD <- ISD %>%
  dplyr::mutate(stateID = ifelse(is.na(stateID), cowID, stateID))

# ensure NAs are coded correctly
ISD <- ISD %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(.,
                                                 "^NA$", NA_character_))) %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(.,
                                                 "-9", NA_character_))) %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin),
                End = messydates::as_messydate(End))

# manydata and manypkgs include several other
# functions that should help cleaning and
# standardizing your data.
# Please see the vignettes or website for more details.
# Stage three: Connecting data
# Next run the following line to make ISD available within the package.
manypkgs::export_data(ISD, datacube = "states",
                      URL = "http://www.ryan-griffiths.com/data")
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards. You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point. Any test failures should be pretty
# self-explanatory and may require you to return to stage two and further clean,
# standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as
# much detail about the variables etc as possible.
