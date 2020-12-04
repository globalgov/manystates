#ISD Dataset
library(qData)
library(tidyverse)
isd <- readr::read_csv("data-raw/states/ISD/ISD_Version1_Dissemination.csv")
# qData::import_data(isd)
  isd <- as_tibble(isd) %>%
  transmutate(ccode = `COW Nr.`) %>%
  transmutate(Id = `COW ID`) %>%
  transmutate(statename = entitle(`State Name`)) %>%
  transmutate(newstate = entitle(`New State`)) %>% # Added this to rename the newstate column 
  transmutate(Beg = lubridate::dmy(Start)) %>%
  rename(eDate = End) %>% # renamed it for the next function not to be auto-referencing itself
  transmutate(End = lubridate::dmy(eDate)) %>%
  mutate_at(vars(Micro), ~replace(., is.na(.), 0)) %>% # replaced mutate_all(funs(ifelse(is.na(.), 0, .))) %>%, standardizes the dummies
  mutate_at(vars(Micro), ~replace(., .=="X" , 1)) %>%  # replaced mutate(across(everything(), ~replace(., . ==  "X" , 1))) %>%, standardizes the dummies
  mutate_at(vars(newstate), ~replace(., is.na(.), 0)) %>% # standardizes the dummies like the previous lines, na becomes 0 and 10 becomes 1
  mutate_at(vars(newstate), ~replace(., .==10 , 1)) %>%  # standardizes the dummies like the previous lines, na becomes 0 and 10 becomes 1
  dplyr::select(-X8, -X9, -X10, -X11, -X12,  -X13,  -X14,  -X15) %>%
  relocate(Id, ccode, statename, Beg, End, Micro, newstate)
qData::export_data(isd)
