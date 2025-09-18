# HUGGO_STATES Preparation Script

# This dataset contains handcoded information on states,
# such as the capitals, latitude and longitude, beginning and end dates,
# regions, and ratification rules.

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
# HUGGO_STATES <- read.csv2("data-raw/states/HUGGO_STATES/extra_begdates.csv")
# nap <- read.csv2("data-raw/states/HUGGO_STATES/extra_napdates.csv")
# regions <- readr::read_csv("data-raw/states/HUGGO_STATES/extra_regions.csv")
# ratif <- readr::read_csv("data-raw/states/HUGGO_STATES/extra_ratifs.csv")
# capitals <- readr::read_csv("data-raw/states/HUGGO_STATES/extra_capitals.csv")
# latlon <- readr::read_csv("data-raw/states/HUGGO_STATES/statlatlons.csv")
# 
# # Stage two: Correcting data
# # In this stage you will want to correct the variable names and
# # formats of the 'HUGGO_STATES' object until the object created
# # below (in stage three) passes all the tests.
# # We recommend that you avoid using one letter variable names to keep
# # away from issues with ambiguous names down the road.
# HUGGO_STATES <- as_tibble(HUGGO_STATES) %>%
#   manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
#                         Begin = messydates::as_messydate(Start),
#                         StateName = manypkgs::standardise_titles(Label)) %>%
#   dplyr::mutate(End = messydates::as_messydate(End)) %>%
#   dplyr::select(stateID, StateName, Begin, End) %>%
#   dplyr::distinct()
# 
# nap <- nap %>%
#   manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
#                         Begin = messydates::as_messydate(Start),
#                         StateName = manypkgs::standardise_titles(Label)) %>%
#   dplyr::mutate(End = messydates::as_messydate(End)) %>%
#   dplyr::select(stateID, StateName, Begin, End) %>%
#   dplyr::distinct()
# 
# # add data on capitals
# capitals <- capitals %>%
#   manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
#                         Begin = messydates::as_messydate(Start),
#                         StateName = manypkgs::standardise_titles(Label)) %>%
#   dplyr::mutate(Capital = manypkgs::standardise_titles(Capital),
#                 End = messydates::as_messydate(End)) %>%
#   dplyr::select(stateID, StateName, Capital, Begin, End) %>%
#   dplyr::distinct()
# 
# # add data on regions
# regions <- regions %>%
#   manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
#                         StateName = manypkgs::standardise_titles(Label)) %>%
#   dplyr::mutate(Capital = manypkgs::standardise_titles(Capital),
#                 Region = manypkgs::standardise_titles(Region),
#                 Area = manypkgs::standardise_titles(Area)) %>%
#   dplyr::rename(Latitude = Lat, Longitude = Lon) %>%
#   dplyr::select(stateID, StateName, Capital, Area, Region, Latitude, Longitude) %>%
#   dplyr::distinct()
# 
# # data on latitude and longitude
# latlon <- latlon %>%
#   manydata::transmutate(stateID = manypkgs::standardise_titles(StatID)) %>%
#   dplyr::rename(Latitude = Lat, Longitude = Lon) %>%
#   dplyr::relocate(stateID, Capital) %>%
#   dplyr::distinct()
# 
# # combine data on latitude and longitude
# regions2 <- regions %>%
#   dplyr::full_join(latlon, by = c("stateID", "Capital")) %>%
#   dplyr::distinct()
# regions2 <- regions2 %>%
#   dplyr::mutate(Latitude.x = ifelse(is.na(Latitude.x), Latitude.y, Latitude.x),
#                 Longitude.x = ifelse(is.na(Longitude.x), Longitude.y, Longitude.x),
#                 Latitude2 = ifelse(Latitude.x != Latitude.y, 1, 0),
#                 Latitude2 = ifelse(Latitude2 == 1, Latitude.y, NA),
#                 Longitude2 = ifelse(Longitude.x != Longitude.y, 1, 0),
#                 Longitude2 = ifelse(Longitude2 == 1, Longitude.y, NA)) %>%
#   dplyr::rename(Latitude = Latitude.x, Longitude = Longitude.x)
# # Checked Latitude2 and Longitude2, no alternative Latitude and Longitude values
# regions2 <- regions2 %>%
#   dplyr::select(stateID, StateName, Capital, Area, Region,
#                 Latitude, Longitude) %>%
#   dplyr::distinct()
# 
# # additional hand-coded information on states' ratification rules
# ratif <- ratif %>%
#   dplyr::select(-(`...1`)) %>%
#   manydata::transmutate(stateID = manypkgs::standardise_titles(StatID),
#                         StateName = manypkgs::standardise_titles(Label)) %>%
#   dplyr::rename(RatProcedure = Rat, Source_rat = Source) %>%
#   dplyr::relocate(stateID, StateName)
# 
# ### Combine data
# HUGGO_STATES2 <- dplyr::bind_rows(HUGGO_STATES, nap) %>%
#   dplyr::arrange(stateID, Begin) %>%
#   dplyr::distinct()
# 
# HUGGO_STATES2 <- HUGGO_STATES2 %>%
#   dplyr::full_join(capitals,
#                    by = c("stateID", "StateName", "Begin", "End")) %>%
#   dplyr::distinct()
# 
# # Missing StateName for some observations in regions2
# # Combine rows with same stateID to avoid missing State Names after merging
# names <- HUGGO_STATES2 %>%
#   dplyr::group_by(stateID) %>%
#   dplyr::summarise(dplyr::across(1, list(~ .[!is.na(.)][1])))
# colnames(names) <- stringr::str_remove_all(colnames(names), "_1")
# regions2 <- dplyr::left_join(regions2, names, by = "stateID")
# regions2 <- regions2 %>%
#   dplyr::mutate(StateName = ifelse(is.na(StateName.x), StateName.y, StateName.x)) %>%
#   dplyr::select(-c(StateName.x, StateName.y)) %>%
#   dplyr::distinct()
# 
# HUGGO_STATES2 <- HUGGO_STATES2 %>%
#   dplyr::full_join(regions2,
#                    by = "stateID") %>%
#   dplyr::distinct()
# # Keep state/capital names and alternative state/capital names if available
# HUGGO_STATES2 <- HUGGO_STATES2 %>%
#   dplyr::mutate(StateName = ifelse(!is.na(StateName.x), StateName.x, StateName.y),
#                 StateName2 = ifelse(StateName.x != StateName.y, StateName.y, NA),
#                 Capital = ifelse(!is.na(Capital.x), Capital.x, Capital.y),
#                 Capital2 = ifelse(Capital.x != Capital.y, Capital.y, NA))%>%
#   dplyr::select(-c(StateName.x, StateName.y, Capital.x, Capital.y)) %>%
#   dplyr::relocate(stateID, StateName, StateName2, Begin, End, Capital, Capital2) %>%
#   dplyr::arrange(stateID, Begin)
# 
# HUGGO_STATES2 <- HUGGO_STATES2 %>%
#   dplyr::full_join(ratif, by = c("stateID", "StateName")) %>%
#   dplyr::distinct()
# 
# # reorder variables and arrange chronologically
# HUGGO_STATES <- HUGGO_STATES2 %>%
#   dplyr::relocate(stateID, StateName, Capital, Begin, End, Latitude, Longitude,
#                   Area, Region) %>%
#   dplyr::arrange(Begin)
# 
# # Fill in missing state names for now
# HUGGO_STATES <- HUGGO_STATES %>%
#   dplyr::mutate(StateName = ifelse(stateID == "YEM", "Yemen", StateName),
#                 StateName = ifelse(stateID == "ZWE", "Zimbabwe", StateName))
# 
# # ensure NAs are coded correctly
# HUGGO <- HUGGO_STATES %>%
#   dplyr::mutate(across(everything(),
#                        ~stringr::str_replace_all(.,
#                                                  "^NA$", NA_character_))) %>%
#   dplyr::mutate(Begin = messydates::as_messydate(Begin),
#                 End = messydates::as_messydate(End)) %>%
#   dplyr::relocate(stateID, StateName, Capital, Begin, End) %>%
#   dplyr::arrange(Begin)

# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`.
# Please see the vignettes or website for more details.

HUGGO <- read.csv("data-raw/states/HUGGO/huggo_states_clean.csv",
                  na.strings = c("", "NA"))
HUGGO <- dplyr::as_tibble(HUGGO) %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin),
                End = messydates::as_messydate(End),
                DecIndep = messydates::as_messydate(DecIndep),
                Autonomy = messydates::as_messydate(Autonomy)
                ) %>%
  dplyr::select(-c(Basis,DecIndep,Autonomy,Constitution)) %>%
  dplyr::arrange(Begin)

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
# please run `manypkgs::add_bib("states", "HUGGO")`.
manypkgs::export_data(HUGGO, datacube = "states",
                      URL = "Hand-coded data by the GGO team")
