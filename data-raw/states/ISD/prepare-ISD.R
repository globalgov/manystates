# ISD Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many packages universe

# Stage one: Collecting data
# ISD <- readxl::read_excel("data-raw/states/ISD/ISD+V2.xlsx")
# ISD <- readxl::read_excel("data-raw/states/ISD/isd_2_2_update.xlsx")
ISD <- readr::read_csv("data-raw/states/ISD/isd_2_2_update_reversedates.csv",
                        na= c("", "NA", "-9"))

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ISD' object until the object created
# below (in stage three) passes all the tests.
ISD <- tibble::as_tibble(ISD) %>%
  # standardizing State Name
  dplyr::mutate(StateName = stringi::stri_trans_totitle(as.character(StateName))) %>%
  manydata::transmutate(StateNameAlt = stringi::stri_trans_totitle(as.character(OtherName))) %>%
  # standardizing ID vars
  dplyr::rename(cowNR = COWNum, cowID = COWID) %>%
  dplyr::mutate(stateID = code_states(StateName)) %>%
  # standardizing Begin and End dates
  manydata::transmutate(Begin = messydates::as_messydate(dplyr::coalesce(as.character(EStart), 
                                                                         as.character(Start)))) %>%
  dplyr::mutate(Begin = ifelse(EStart_Am == 1|Start_Am == 1,
                               messydates::as_uncertain(Begin), Begin),
                End = messydates::as_messydate(End),
                End = ifelse(End_Am == 1, messydates::as_uncertain(End), End),
                Begin = messydates::as_messydate(Begin),
                End = messydates::as_messydate(End),
                End = messydates::as_messydate(ifelse(End == "2016-12-31",
                                                messydates::on_or_after(End),
                                                End))) %>%
  # Dropping unnecessary columns
  dplyr::relocate(stateID, StateName, Begin, End, StateNameAlt, 
                  Latitude, Longitude, StartType, EndType, cowID, cowNR) %>%
  dplyr::select(-dplyr::matches("Destination")) %>%
  # Arrange observations
  dplyr::arrange(Begin, stateID)

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
