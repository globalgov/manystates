# Cow Dataset
library(qData)
library(tidyverse)
cow <- readr::read_csv("data-raw/states/COW/states2016.csv")
# qData::import_data("COW", 'states')
  cow <- as_tibble(cow) %>%
  transmutate(statename = entitle(statenme)) %>%
  transmutate(Id = stateabb) %>%
  relocate (Id, ccode, statename) %>% #changed from rearrange()
  transmutate(stdate = paste(stday, stmonth, styear, sep = ".")) %>%
  transmutate(edate = paste(endday, endmonth, endyear, sep = ".")) %>%
  select(-version) %>%
  transmutate(Beg = lubridate::dmy(stdate)) %>%
  transmutate(End = lubridate::dmy(edate))
qData::export_data(cow)
