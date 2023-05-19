# FreedomHouseFull Preparation Script

# This script imports, cleans and corrects the FreedomHouseFull dataset before
# including it in the regimes database.
# The FreedomHouseFull dataset contains the full Freedom House scores and statuses
# for countries and territories from the 2013-2021 edition.

# Note that the Freedom House data comprises of three distinct Excel files.
# These have been imported as three separate datasets in the package.
# Please see the FHaggregate dataset for aggregate scores from 2003 and
# the FHstatus dataset for data on the Freedom House status of 
# countries and territories.

# Freedom House 1: Edition 2013-2021 ----
# Stage one: Collecting data
FreedomHouseFull <- readxl::read_excel("data-raw/regimes/FreedomHouseFull/All_data_FIW_2013-2021.xlsx",
                                       sheet = 2,
                                       skip = 1,
                                       na = c("-", "N/A"))

# Stage two: Correcting data
FreedomHouseFull <- dplyr::rename(FreedomHouseFull, StateName = `Country/Territory`) %>%
  manydata::transmutate(Territory = ifelse(`C/T` == "t", 1, 0)) %>%
  dplyr::mutate(
    stateID = manypkgs::code_states(StateName, abbrev = TRUE),
    Year = messydates::as_messydate(as.character(Edition - 1)),
    #Year in which the data was collected is one year prior to the edition year
    Edition = messydates::as_messydate(as.character(Edition)),
    ID = paste0(stateID, "-", as.character(Year))
  ) %>%
  dplyr::relocate(ID, stateID, Year, StateName)

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make FreedomHouse available
# within the many package.
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
# run `manypkgs::add_bib("regimes", "FreedomHouse")`.
# Export FreedomHouseFull
manypkgs::export_data(FreedomHouseFull, database = "regimes",
                      URL = "https://freedomhouse.org/report/freedom-world")
