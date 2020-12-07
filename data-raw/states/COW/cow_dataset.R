# Cow Dataset
library(qDatr)
library(tidyverse)
cow <- readr::read_csv("data-raw/states/COW/states2016.csv")

cow <- as_tibble(cow) %>% transmutate(statename = entitle(statenme)) %>% 
   transmutate(Id = stateabb) %>% 
   rearrange ("statename", "before", "ccode") %>% 
   transmutate(stdate = paste(stday, stmonth, styear, sep = ".")) %>% 
   transmutate(edate = paste(endday, endmonth, endyear, sep = ".")) %>% 
   select(-version) %>% 
  transmutate(Beg = lubridate::dmy(stdate)) %>% 
   transmutate(End = lubridate::dmy(edate))

qDatr::export_data(cow)
