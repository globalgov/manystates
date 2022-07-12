# LATLON Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
GNEVAR_STATES <- readr::read_csv("data-raw/states/GNEVAR_STATES/statlatlons.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'GNEVAR_STATES' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
GNEVAR_STATES <- as_tibble(GNEVAR_STATES) %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID)) %>%
  dplyr::rename(Latitude = Lat, Longitude = Lon) %>%
  dplyr::relocate(stateID, Capital)
# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make GNEVAR_STATES available
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
# please run `manypkgs::add_bib("states", "GNEVAR_STATES")`.
manypkgs::export_data(GNEVAR_STATES, database = "states",
                      URL = "https://www.google.com/maps")
