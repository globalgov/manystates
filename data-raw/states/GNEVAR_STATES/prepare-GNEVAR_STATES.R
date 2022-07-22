# GNEVAR_STATES Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
GNEVAR_STATES <- readr::read_csv("data-raw/states/GNEVAR_STATES/statlatlons.csv")
beg <- read.csv2("data-raw/states/GNEVAR_STATES/extra_begdates.csv")
nap <- read.csv2("data-raw/states/GNEVAR_STATES/extra_napdates.csv")
regions <- readr::read_csv("data-raw/states/GNEVAR_STATES/extra_regions.csv")
capitals <- readr::read_csv("data-raw/states/GNEVAR_STATES/extra_capitals.csv")

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

beg <- beg %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
                        Beg = messydates::as_messydate(Start)) %>%
  dplyr::mutate(Label = manypkgs::standardise_titles(Label),
                End = messydates::as_messydate(End)) %>%
  dplyr::select(stateID, Label, Beg, End)

nap <- nap %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
                        Beg = messydates::as_messydate(Start)) %>%
  dplyr::mutate(Label = manypkgs::standardise_titles(Label),
                End = messydates::as_messydate(End)) %>%
  dplyr::select(stateID, Label, Beg, End)

capitals <- capitals %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
                        Beg = messydates::as_messydate(Start)) %>%
  dplyr::mutate(Label = manypkgs::standardise_titles(Label),
                Capital = manypkgs::standardise_titles(Capital),
                End = messydates::as_messydate(End)) %>%
  dplyr::select(stateID, Label, Capital, Beg, End)

regions <- regions %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID)) %>%
  dplyr::mutate(Label = manypkgs::standardise_titles(Label),
                Capital = manypkgs::standardise_titles(Capital),
                Region = manypkgs::standardise_titles(Region),
                Area = manypkgs::standardise_titles(Area)) %>%
  dplyr::rename(Latitude = Lat, Longitude = Lon) %>%
  dplyr::select(stateID, Label, Capital, Area, Region, Latitude, Longitude)

GNEVAR_STATES <- GNEVAR_STATES %>%
  dplyr::full_join(beg, by = "stateID") %>%
  dplyr::full_join(nap, by = c("stateID", "Label", "Beg", "End")) %>%
  dplyr::full_join(capitals, by = c("stateID", "Label", "Capital", "Beg", "End")) %>%
  dplyr::full_join(regions, by = c("stateID", "Label", "Capital", "Latitude", "Longitude"))

# remove complete duplicates
GNEVAR_STATES <- subset(GNEVAR_STATES,
                        subset = !duplicated(GNEVAR_STATES[, c(1,2,3,4,5,6,7,8,9)]))

# reorder variables and arrange chronologically
GNEVAR_STATES <- GNEVAR_STATES %>%
  dplyr::relocate(stateID, Label, Capital, Beg, End, Latitude, Longitude, Area, Region) %>%
  dplyr::arrange(Beg)

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
                      URL = "NA")
