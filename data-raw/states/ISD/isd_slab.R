#ISD slab
library(qDatr)
isddata <- readr::read_csv("data-raw/states/ISD/ISD_Version1_Dissemination.csv")
qDatr::import_data(isddata)
#   isd <- as_tibble(isddata) %>% 
#   transmutate(ccode = `COW Nr.`) %>% 
#   transmutate(Id = `COW ID`) %>% 
#   transmutate(statename = entitle(`State Name`)) %>% 
#   transmutate(Beg = lubridate::dmy(Start)) %>% 
#   transmutate(End = lubridate::dmy(End)) %>%  
#   mutate_all(funs(ifelse(is.na(.), 0, .))) %>% 
#   mutate(across(everything(), ~replace(., . ==  "X" , 1))) %>%
#   dplyr::select(-X8, -X9, -X10, -X11, -X12,  -X13,  -X14,  -X15)
qDatr::export_data(isd)
