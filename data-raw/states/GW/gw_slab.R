# GW Slab
library(qDatr)
gwdata <- readxl::read_excel("data-raw/states/GW/gwstates.xlsx")
qDatr::import_data(gwdata)
#   gwstates <- as_tibble(gwstates) %>% 
#   transmutate(ccode = `Cow Nr.`) %>% 
#   transmutate(Id = `Cow ID`) %>% 
#   transmutate(statename = entitle(`Name of State`)) %>% 
#   transmutate(Beg = lubridate::dmy(Start)) %>% 
#   transmutate(End = lubridate::dmy(End))
qDatr::export_data(gwstates)
