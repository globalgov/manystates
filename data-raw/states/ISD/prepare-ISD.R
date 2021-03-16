# ISD Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.
library(qData)
library(tidyverse)

# Stage one: Collecting data
ISD <- read.csv("data-raw/states/ISD/ISD_Version1_Dissemination.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ISD' object until the object created
# below (in stage three) passes all the tests. 

ISD <- as_tibble(ISD) %>%
  dplyr::rename(Finish = End) %>% 
  # Renaming the end date column to avoid self reference in transmutate.
  transmutate(ID = `COW.ID`,
              Beg = standardise_dates(Start),
              End = standardise_dates(Finish),
              Label = standardise_titles(as.character(State.Name)),
              COW_Nr = standardise_titles(as.character(COW.Nr.))) %>%
  # Standardising the dummie variables
  dplyr::mutate_at(vars(Micro, New.State),  ~replace(. == "", 0, .)) %>% 
  dplyr::mutate_at(vars(Micro, New.State), ~replace(. == "x", 1, .)) %>%  
  #Dropping certain unnecessary columns.
  dplyr::select(-X, -X.1, -X.2, -X.3, -X.4, -X.5,  -X.6, -X.7) %>% 
  # Arranging dataset
  dplyr::relocate(COW_Nr, ID, Beg, End, Label, Micro, New.State) %>%
  dplyr::arrange(Beg, ID)

# qData includes several functions that should help cleaning and standardizing your data.
# Please see the vignettes or website for more details.

# #Additional Identifiers and Unicode Country Flags by using the countrycode package (https://github.com/vincentarelbundock/countrycode)
#code_modern_states(states$ISD$ID)
# # Issue, historic countries (Denmark for example) that have a non continuous existence are coded with the same ISO-ID's for both occurrences of existence.This also prevents inner joins.

# Stage three: Connecting data
# Next run the following line to make ISD available within the qPackage.
export_data(ISD, database = "states", URL="http://www.ryan-griffiths.com/data")
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence to certain standards.
# You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows) to run these tests locally at any point.
# Any test failures should be pretty self-explanatory and may require you to return
# to stage two and further clean, standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as much detail
# about the variables etc as possible.