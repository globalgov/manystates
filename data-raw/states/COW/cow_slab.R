# Cow Slab
library(qDatr)
cowdata <- readr::read_csv("data-raw/states/COW/states2016.csv")
qDatr::import_data(cowdata)
#   cow <- as_tibble(cow) %>% 
#   transmutate(statename = entitle(statenme)) %>% 
#   transmutate(Id = stateabb) %>% 
#   rearrange ("statename", "before", "ccode") %>% 
#   transmutate(stdate = paste(stday, stmonth, styear, sep = ".")) %>% 
#   transmutate(edate = paste(endday, endmonth, endyear, sep = ".")) %>% 
#   select(-version) %>% 
#   transmutate(Beg = lubridate::dmy(stdate)) %>% 
#   transmutate(End = lubridate::dmy(edate))  
qDatr::export_data(cow)
