# Cow Dataset
library(qDatr)
library(tidyverse)
cow <- readr::read_csv("data-raw/states/COW/states2016.csv")
# qDatr::import_data("cow", 'states')
  cow <- as_tibble(cow) %>%
  transmutate(statename = entitle(statenme)) %>%
  transmutate(Id = stateabb) %>%
  relocate (Id, ccode, statename) %>% #changed from rearrange()
  transmutate(stdate = paste(stday, stmonth, styear, sep = ".")) %>%
  transmutate(edate = paste(endday, endmonth, endyear, sep = ".")) %>%
  select(-version) %>%
  transmutate(Beg = lubridate::dmy(stdate)) %>%
  transmutate(End = lubridate::dmy(edate))
qDatr::export_data(cow)
