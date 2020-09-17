library(countrycode)
sys_actor <- read.csv("data-raw/states/StateSys.csv",
                      stringsAsFactors = F, na.strings = "") %>%
  transmutate(
    StatID = recode(Id, PAP="VAT"),
    CowID = countrycode(CoW, "cown", "cowc"),
    Beg = as.character(lubridate::ymd(Start))
  ) %>%
  mutate(
    End = as.character(lubridate::ymd(End))
  ) %>% select(StatID, CowID, Label, Beg, End,
               Capital, Area, Region, Notes) %>%
  filter(!is.na(Beg)) %>% arrange(Beg)

# Get capital cities
extracaps <- read.csv("data-raw/Stat_Actor/extra_capitals.csv",
                      stringsAsFactors = F) %>% rename(Beg=Start)
sys_actor <- full_join(sys_actor, extracaps,
                       c("StatID","Label","Beg","End")) %>%
  transmutate(Capital = coalesce(Capital.y, Capital.x)) %>%
  select(StatID, CowID, Label, Beg, End,
         Capital, Area, Region, Notes) %>%
  arrange(Beg)

# Get pre-Napoleon dates
extranaps <- read.table("data-raw/Stat_Actor/extra_napdates.csv",
                        sep=";", quote = "", header = T, na.strings = "",
                        stringsAsFactors = F) %>%
  transmutate(Beg=recent(Start))
sys_actor <- full_join(sys_actor, extranaps, by = "StatID")
sys_actor <- sys_actor %>% mutate(
  Notes = na_if(Notes, "")
) %>% transmutate(
  Label = coalesce(Label.y, Label.x),
  Beg = if_else(Beg.x=="1816-01-01",
                Beg.y, Beg.x),
  End = if_else(End.x=="1816-01-01",
                End.y, End.x),
  Note = reunite(Notes, Comment)
)

# Reconcile competing start dates
extrabegs <- read.table("data-raw/Stat_Actor/extra_begdates.csv",
                       sep=";", header = T, na.strings = c("","NA"),
                       stringsAsFactors = F) %>%
  transmutate(Beg=recent(Start)) %>%
  select(-c(Start2, End2))
sys_actor <- full_join(sys_actor, extrabegs, by = c("StatID","Label")) %>%
  transmutate(Beg = coalesce(Beg.y, Beg.x),
              End = coalesce(End.y, End.x),
              Notes = reunite(Note, Comment)) %>%
  distinct() %>%
  select(StatID, Beg, End, Label, Capital, everything())
sys_actor <- repaint(sys_actor, "Capital", c("Area","Region","CowID"))

sys_actor[sys_actor$StatID=="DEU" & sys_actor$Beg=="1949-05-23", "End"] <- "1990-10-02"
sys_actor[sys_actor$StatID=="BOL" & sys_actor$Beg=="1825-08-06", "End"] <- "1836-12-31"
sys_actor[sys_actor$StatID=="RVN" & sys_actor$Beg=="1955-10-26", "End"] <- "1975-04-30"
sys_actor <- subset(sys_actor, !(StatID=="PER" & Beg=="1824-12-09" & End=="9999-12-31"))
sys_actor <- subset(sys_actor, !(StatID=="YEM" & Beg=="1926-09-02" & End=="1990-05-21"))
sys_actor <- subset(sys_actor, !(StatID=="DDR" & Beg=="1954-03-25"))
sys_actor <- subset(sys_actor, Capital!="Bonn/Berlin")
sys_actor <- subset(sys_actor, !(Capital=="Cetinje" & Beg=="2006-06-03"))
sys_actor <- subset(sys_actor, !(Capital=="Podgorica" & Beg=="1852-03-13"))
sys_actor <- subset(sys_actor, !(StatID=="MAR" & grepl("_",Notes)))
sys_actor <- subset(sys_actor, !(StatID=="MDG" & Beg=="1960-06-26" & grepl("From death",Notes)))
# sys_actor[sys_actor$StatID=="IRL","Beg"] <- NA
sys_actor[sys_actor$StatID=="AZE" & sys_actor$Beg=="1991-10-18","Beg"] <- NA

# Complete area/regions ####
extraregs <- read.csv("data-raw/Stat_Actor/extra_regions.csv", stringsAsFactors = F) %>%
  select(StatID, Area, Region)
sys_actor <- full_join(sys_actor, extraregs, by = "StatID") %>%
  transmutate(Area = coalesce(Area.x, Area.y),
              Region = coalesce(Region.x, Region.y))

sys_actor <- sys_actor %>% distinct() %>%
  arrange(StatID, Beg)

rm(extracaps, extrabegs, extranaps, extraregs)
