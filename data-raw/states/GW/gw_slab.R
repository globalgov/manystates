# GW Slab

library(qDatr)
library(tidyr)
library(lubridate)

gwslab <- as_tibble(gwstates) %>% transmutate(ccode = `Cow Nr.`) %>% transmutate(id = `Cow ID`) %>% 
  transmutate(statename = `Name of State`) %>% transmutate(startdate = lubridate::dmy(Start)) %>% transmutate(enddate = lubridate::dmy(End))


