# GW Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.
library(qData)

# Stage one: Collecting data
GW <- readxl::read_excel("data-raw/states/GW/gwstates.xlsx")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'GW' object until the object created
# below (in stage three) passes all the tests. 
GW <- as_tibble(GW) %>%
  dplyr::rename(Finish = End) %>% # Renaming the end date column to avoid self reference in transmutate.(can't do it inside the transmutate since we also work on dates)
  transmutate(ID = `Cow ID`,
              Beg = standardise_dates(Start),
              End = standardise_dates(Finish), 
              Label = standardise_titles(`Name of State`),
              COW_Nr = standardise_titles(`Cow Nr.`)) %>%
  dplyr::relocate(COW_Nr, ID, Beg, End, Label) %>%
  dplyr::arrange(Beg, ID)

# #Additional Identifiers and Unicode Country Flags by using the countrycode package (https://github.com/vincentarelbundock/countrycode)
# library(countrycode)
# ID <- data.frame(GW$ID, UnicodeSymb = countrycode::countrycode(GW$ID, 'cowc', 'unicode.symbol'), ISO3_ID = countrycode::countrycode(GW$ID, 'cowc', 'iso3c'), EuroStat_code = countrycode::countrycode(GW$ID, 'cowc', 'eurostat'), ECB_code = countrycode::countrycode(GW$ID,'cowc', 'ecb'), IANA_TLD = countrycode::countrycode(GW$ID, 'cowc', "cctld"), un_code = countrycode::countrycode(GW$ID, 'cowc', 'un'), Continent = countrycode::countrycode(GW$ID, 'cowc', 'continent'), EU = countrycode::countrycode(GW$ID, 'cowc', 'eu28'), Currency = countrycode::countrycode(GW$ID, 'cowc', 'iso4217c'))
# ID  <- as_tibble(ID)
# GW <- dplyr::bind_cols(GW, ID)
# rm(ID)
# # Issue, historic countries (Denmark for example) that have a non continuous existence are coded with the same ISO-ID's for both occurrences of existence.This also prevents inner joins.

# qData includes several functions that should help cleaning and standardizing your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make GW available within the qPackage.
export_data(GW, database = "states")
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence to certain standards.
# You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows) to run these tests locally at any point.
# Any test failures should be pretty self-explanatory and may require you to return
# to stage two and further clean, standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as much detail
# about the variables etc as possible.
