#ISD slab

library(qDatr)
library(tidyr)
library(lubridate)

isdslab <- as_tibble(ISD_Version1_Dissemination) %>% transmutate(ccode = `COW Nr.`) %>% transmutate(id = `COW ID`) %>% 
  transmutate(statename = `State Name`) %>% transmutate(startdate = lubridate::dmy(Start)) %>% transmutate(enddate = lubridate::dmy(End)) %>%  
  select(-X8, -X9, -X10, -X11, -X12,  -X13,  -X14,  -X15) %>% nest(ccode = c(Micro, `New State`))