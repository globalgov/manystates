# Cow Slab
library(qDatr)
cow <- readr::read_csv("data-raw/states/COW/states2016.csv")
#   cowslab <- as_tibble(states2016) %>% 
#   transmutate(statename = entitle(statenme)) %>% 
#   transmutate(Id = stateabb) %>% 
#   rearrange ("statename", "before", "ccode") %>% 
#   transmutate(stdate = paste(stday, stmonth, styear, sep = ".")) %>% 
#   transmutate(edate = paste(endday, endmonth, endyear, sep = ".")) %>% 
#   select(-version) %>% 
#   transmutate(Beg = lubridate::dmy(stdate)) %>% 
#   transmutate(End = lubridate::dmy(edate))  
qDatr::use_qData(cow)
