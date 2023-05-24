# HUGGO_STATES Preparation Script

# This dataset contains handcoded information on states,
# such as the capitals, latitude and longitude, beginning and end dates,
# regions, and ratification rules.

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
HUGGO_STATES <- readr::read_csv("data-raw/states/HUGGO_STATES/statlatlons.csv")
beg <- read.csv2("data-raw/states/HUGGO_STATES/extra_begdates.csv")
nap <- read.csv2("data-raw/states/HUGGO_STATES/extra_napdates.csv")
regions <- readr::read_csv("data-raw/states/HUGGO_STATES/extra_regions.csv")
capitals <- readr::read_csv("data-raw/states/HUGGO_STATES/extra_capitals.csv")
ratif <- readr::read_csv("data-raw/states/HUGGO_STATES/extra_ratifs.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'HUGGO_STATES' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
HUGGO_STATES <- as_tibble(HUGGO_STATES) %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID)) %>%
  dplyr::rename(Latitude = Lat, Longitude = Lon) %>%
  dplyr::relocate(stateID, Capital)

beg <- beg %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
                        Beg = messydates::as_messydate(Start)) %>%
  dplyr::mutate(StateName = manypkgs::standardise_titles(StateName),
                End = messydates::as_messydate(End)) %>%
  dplyr::select(stateID, StateName, Beg, End)

nap <- nap %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
                        Beg = messydates::as_messydate(Start)) %>%
  dplyr::mutate(StateName = manypkgs::standardise_titles(StateName),
                End = messydates::as_messydate(End)) %>%
  dplyr::select(stateID, StateName, Beg, End)

capitals <- capitals %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
                        Beg = messydates::as_messydate(Start)) %>%
  dplyr::mutate(StateName = manypkgs::standardise_titles(StateName),
                Capital = manypkgs::standardise_titles(Capital),
                End = messydates::as_messydate(End)) %>%
  dplyr::select(stateID, StateName, Capital, Beg, End)

regions <- regions %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID)) %>%
  dplyr::mutate(StateName = manypkgs::standardise_titles(StateName),
                Capital = manypkgs::standardise_titles(Capital),
                Region = manypkgs::standardise_titles(Region),
                Area = manypkgs::standardise_titles(Area)) %>%
  dplyr::rename(Latitude = Lat, Longitude = Lon) %>%
  dplyr::select(stateID, StateName, Capital, Area, Region, Latitude, Longitude)

# add additional hand-coded information on states' ratification rules
ratif <- ratif %>%
  dplyr::select(-`...1`) %>%
  manydata::transmutate(stateID = manypkgs::standardise_titles(StatID)) %>%
  dplyr::mutate(StateName = manypkgs::standardise_titles(StateName)) %>%
  dplyr::rename(RatProcedure = Rat)

# Combine data
HUGGO_STATES <- HUGGO_STATES %>%
  dplyr::full_join(beg, by = "stateID") %>%
  dplyr::full_join(nap, by = c("stateID", "StateName", "Beg", "End")) %>%
  dplyr::full_join(capitals,
                   by = c("stateID", "StateName", "Capital", "Beg", "End")) %>%
  dplyr::full_join(regions,
                   by = c("stateID", "StateName", "Capital",
                          "Latitude", "Longitude")) %>%
  dplyr::full_join(ratif, by = c("stateID", "StateName"))

# reorder variables and arrange chronologically
HUGGO_STATES <- HUGGO_STATES %>%
  dplyr::relocate(stateID, StateName, Capital, Beg, End, Latitude, Longitude,
                  Area, Region) %>%
  dplyr::arrange(Beg)

# make sure all vars are correctly coded as NA if necessary
HUGGO_STATES <- HUGGO_STATES %>% 
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(., "^NA$", NA_character_))) %>%
  mutate(Beg = messydates::as_messydate(Beg),
         End = messydates::as_messydate(End)) %>% 
  dplyr::distinct(.keep_all = TRUE)

# Add region data
gapminder <- dslabs::gapminder %>% 
  select(country, continent, region) %>% # select only the variables we want
  rename(Continent = continent, Region_gapminder = region) %>%
  distinct() # keeps only distinct rolls (no duplicates)
HUGGO_STATES <- dplyr::left_join(HUGGO_STATES, gapminder,
                                 by = c("StateName" = "country"))
HUGGO_STATES$Regionc <- dplyr::coalesce(HUGGO_STATES$Region, HUGGO_STATES$Region_gapminder)
HUGGO_STATES <- HUGGO_STATES %>%
  dplyr::select(-c(Region, Continent, Region_gapminder)) %>%
  dplyr::rename(Region = Regionc) %>%
  dplyr::mutate(Region = stringr::str_replace(Region, "-", " "))

# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make HUGGO_STATES available
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
# please run `manypkgs::add_bib("states", "HUGGO_STATES")`.
manypkgs::export_data(HUGGO_STATES, database = "states",
                      URL = "Hand-coded data by the GGO team")
