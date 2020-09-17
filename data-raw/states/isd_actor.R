library(countrycode)
# Get Griffiths/Butcher ISD data ####
isd_actor <- read.csv("data-raw/Stat_Actor/ISD_Version1_Dissemination.csv",
                      stringsAsFactors = F)[,1:7] %>% mutate(
                        StatID = coalesce(countrycode(State.Name, "country.name", "iso3c"),
                                          COW.ID),
                        StatID = recode(StatID, "ZAN"="EAZ"),
                        End = recode(as.character(lubridate::dmy(End)), "2011-12-31"="9999-12-31"),
                        Micro = (Micro=="X")
                      ) %>% transmutate(
                        Label = gsub("&","and", na_if(na_if(State.Name, ""), "State Name")),
                        CowID = COW.ID,
                        Beg = as.character(lubridate::dmy(Start)),
                        New = (New.State=="X")
                      ) %>% filter(!is.na(Label)) %>%
  select(-c(COW.Nr., New)) %>%
  select(StatID, Label, Beg, End, CowID, everything()) %>%
  arrange(Beg)
isd_actor[isd_actor$Label=="German Democratic Republic","StatID"] <- "DDR"
isd_actor[isd_actor$Label=="Kazembe","StatID"] <- "KZB"
isd_actor[isd_actor$Label=="Perak","StatID"] <- "IPH"
isd_actor[isd_actor$StatID=="YUG","StatID"] <- "SRB"
# isd_actor[isd_actor$Label=="Peru_Bolivia","Label"] <- "Peru-Bolivia"
isd_actor <- subset(isd_actor, StatID != "PER")
isd_actor <- subset(isd_actor, StatID != "SLV")
isd_actor <- subset(isd_actor, StatID != "YAR")
isd_actor <- subset(isd_actor, StatID != "YPR")
isd_actor <- subset(isd_actor, StatID != "SAU")
isd_actor <- subset(isd_actor, StatID != "KOR")
isd_actor <- subset(isd_actor, StatID != "RVN")
isd_actor <- subset(isd_actor, StatID != "VNM")
isd_actor <- subset(isd_actor, StatID != "DDR")
isd_actor <- subset(isd_actor, !(StatID == "DEU" & Beg=="1816-01-01"))
isd_actor <- subset(isd_actor, !(StatID == "DEU" & Beg=="1955-05-05"))
isd_actor[isd_actor$StatID=="SMR","Beg"] <- NA
isd_actor[isd_actor$StatID=="AND","Beg"] <- NA
isd_actor[isd_actor$StatID=="VEN","Beg"] <- NA
isd_actor[isd_actor$StatID=="NIC","Beg"] <- NA
isd_actor[isd_actor$StatID=="BGR","Beg"] <- NA
isd_actor[isd_actor$StatID=="KEL","Beg"] <- NA
isd_actor[isd_actor$StatID=="LIE","Beg"] <- NA
isd_actor[isd_actor$StatID=="ECU","Beg"] <- NA
isd_actor[isd_actor$StatID=="CRI","Beg"] <- NA
isd_actor[isd_actor$StatID=="ARM","Beg"] <- NA
isd_actor[isd_actor$StatID=="ZAF","Beg"] <- NA
isd_actor[isd_actor$StatID=="NER","Beg"] <- NA
isd_actor[isd_actor$StatID=="MEX","Beg"] <- NA
isd_actor[isd_actor$StatID=="AUH","End"] <- NA
isd_actor[isd_actor$StatID=="HSE","End"] <- NA
isd_actor[isd_actor$StatID=="OFS","End"] <- NA
isd_actor[isd_actor$StatID=="MOD","End"] <- NA
isd_actor[isd_actor$StatID=="HSG","End"] <- NA
isd_actor[isd_actor$StatID=="MEC","End"] <- NA
isd_actor[isd_actor$StatID=="PMA","End"] <- NA
isd_actor[isd_actor$StatID=="SAX","End"] <- NA
isd_actor[isd_actor$StatID=="SIC","End"] <- NA
isd_actor[isd_actor$StatID=="EGY","Beg"] <- NA
isd_actor[isd_actor$StatID=="WAD",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="TEX",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="TRA",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="MCO",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="MNE",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="TUS",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="ZUL",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="VAT",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="KOS",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="MDA",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="MKD",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="LBN",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="PLW",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="HUN",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="HND",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="HRV",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="JOR",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="LBR",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="GEO",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="BGD",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="BLR",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="CHL",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="COL",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="COM",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="UKR",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="SVN",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="AUT" & isd_actor$Beg=="1918-03-11","Beg"] <- NA
isd_actor[isd_actor$StatID=="GRC" & isd_actor$Beg=="1828-01-01","Beg"] <- NA
isd_actor[isd_actor$StatID=="POL" & isd_actor$Beg=="1918-11-03","Beg"] <- NA
isd_actor[isd_actor$StatID=="NOR" & isd_actor$End=="1940-04-30","End"] <- NA
isd_actor[isd_actor$StatID=="DZA" & isd_actor$Beg=="1816-01-01",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="UPR" & isd_actor$Beg=="1816-01-01",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="LBY" & isd_actor$Beg=="1816-01-01",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="MAR" & isd_actor$Beg=="1816-01-01",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="MDG" & isd_actor$Beg=="1816-01-01",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="SYR" & isd_actor$Beg=="1946-04-17",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="EST" & isd_actor$Beg=="1991-09-06",c("Beg","End")] <- NA
isd_actor[isd_actor$StatID=="DOM","Beg"] <- NA
