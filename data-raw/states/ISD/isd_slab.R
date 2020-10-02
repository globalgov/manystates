#ISD slab
library(qDatr)
isd <- read_csv("data-raw/states/ISD/ISD_Version1_Dissemination.csv")
#   isdslab <- as_tibble(ISD_Version1_Dissemination) %>% 
#   transmutate(ccode = `COW Nr.`) %>% transmutate(Id = `COW ID`) %>% 
#   transmutate(statename = `State Name`) %>% transmutate(Beg = lubridate::dmy(Start)) %>% 
#   transmutate(End = lubridate::dmy(End)) %>%  
#   select(-X8, -X9, -X10, -X11, -X12,  -X13,  -X14,  -X15)
usethis::use_data(isd)
