# GW Dataset
library(qData)
library(tidyverse)
gwstates <- readxl::read_excel("data-raw/states/GW/gwstates.xlsx")
# qData::import_data("gwstates", 'states')
  gwstates <- as_tibble(gwstates) %>%
  transmutate(ccode = `Cow Nr.`) %>%
  transmutate(Id = `Cow ID`) %>%
  transmutate(statename = entitle(`Name of State`)) %>%
  transmutate(Beg = lubridate::dmy(Start)) %>%
  rename(eDate = End) %>%
  transmutate(End = lubridate::dmy(eDate))%>%
  relocate(Id, ccode, statename, Beg, End)
qData::export_data(gwstates)
