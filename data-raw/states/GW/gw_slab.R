# GW Slab
library(qDatr)
gwstates <- readxl::read_excel("data-raw/states/GW/gwstates.xlsx")
#   gwslab <- as_tibble(gwstates) %>% transmutate(ccode = `Cow Nr.`) %>% 
#   transmutate(Id = `Cow ID`) %>% 
#   transmutate(statename = `Name of State`) %>% 
#   transmutate(Beg = lubridate::dmy(Start)) %>% 
#   transmutate(End = lubridate::dmy(End))
qDatr::use_qData(gwstates, overwrite = TRUE)
