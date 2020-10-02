# Cow Slab

library(qDatr)
library(tidyr)
library(lubridate)

cowslab <- as_tibble(states2016) %>% transmutate(statename = entitle(statenme)) %>% transmutate(id = stateabb) %>% rearrange ("statename", "before", "ccode") %>% 
  transmutate(stdate = paste(stday, stmonth, styear, sep = ".")) %>% transmutate(edate = paste(endday, endmonth, endyear, sep = ".")) %>% 
  select(-version) %>% transmutate(startdate = lubridate::dmy(stdate)) %>% transmutate(enddate = lubridate::dmy(edate))  

