# COW Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.
library(qData)

# Stage one: Collecting data
COW <- readr::read_csv("data-raw/states/COW/states2016.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'COW' object until the object created
# below (in stage three) passes all the tests. 
COW <-as_tibble(COW) %>%
  transmutate(COW_ID = stateabb,
         Beg = standardise_dates(styear, stmonth, stday),
         End = standardise_dates(endyear, endmonth, endday),
         Label = standardise_titles(statenme),
         COW_Nr = standardise_titles(as.character(ccode))) %>%
  dplyr::select(COW_Nr, COW_ID, Beg, End, Label) %>% # Added COW_Nr to perform inner joins on datasets.
  # dplyr::select(COW_ID, Beg, End, Label, everything()) %>%
  dplyr::relocate(COW_Nr, COW_ID, Beg, End, Label) %>%
  dplyr::arrange(Beg, COW_ID)
# qData includes several functions that should help cleaning and standardizing your data.
# Please see the vignettes or website for more details.


# #Additional Identifiers and Unicode Country Flags by using the countrycode package (https://github.com/vincentarelbundock/countrycode)
# library(countrycode)
# ID <- data.frame(COW$COW_ID, UnicodeSymb = countrycode::countrycode(COW$COW_ID, 'cowc', 'unicode.symbol'), ISO3_ID = countrycode::countrycode(COW$COW_ID, 'cowc', 'iso3c'), EuroStat_code = countrycode::countrycode(COW$COW_ID, 'cowc', 'eurostat'), ECB_code = countrycode::countrycode(COW$COW_ID,'cowc', 'ecb'), IANA_TLD = countrycode::countrycode(COW$COW_ID, 'cowc', "cctld"), un_code = countrycode::countrycode(COW$COW_ID, 'cowc', 'un'), Continent = countrycode::countrycode(COW$ID, 'cowc', 'continent'), EU = countrycode::countrycode(COW$ID, 'cowc', 'eu28'), Currency = countrycode::countrycode(COW$ID, 'cowc', 'iso4217c'))
# ID  <- as_tibble(ID)
# COW <- dplyr::bind_cols(COW, ID)
# rm(ID)
# # Issue, historic countries (Denmark for example) that have a non continuous existence are coded with the same ISO-ID's for both occurrences of existence.This also prevents inner joins.

# Stage three: Connecting data
# Next run the following line to make COW available within the qPackage.
export_data(COW, database = "states")
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence to certain standards.
# You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows) to run these tests locally at any point.
# Any test failures should be pretty self-explanatory and may require you to return
# to stage two and further clean, standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as much detail
# about the variables etc as possible.
