# Packages
# if (!require(states)) install.packages('states')
# library(states)
# if (!require(countrycode)) install.packages('countrycode')
# library(countrycode)

# Source components ####
source("data-raw/Stat_Actor/isd_actor.R")
source("data-raw/Stat_Actor/sys_actor.R")

# Get Beth Simmons' ratification data ####
rat_actor <- read.csv("data-raw/Stat_Actor/BSrat.csv", stringsAsFactors = F) %>%
  mutate(Rat = recode(Rat, "1.5"=2, "2"=3, "2.5"=4, "3"=4, "4"=5))
# '2.5' issue with Colombian Congress, which must ratify with a supermajority
temp <- read.csv("data-raw/Stat_Actor/extra_ratifs.csv", stringsAsFactors = F) %>%
  mutate(Rat = recode(Rat, "1.5"=2, "2"=3, "3"=4, "4"=5)) %>%
  rename(Constn = Constitutional.Description) %>% select(-c(X, Label))
rat_actor <- full_join(rat_actor, temp)

# Merge ####
stat_actor <- full_join(sys_actor, isd_actor, by = c("StatID", "Beg", "End")) %>%
  transmutate(
    Label = coalesce(Label.x, Label.y),
    CowID = coalesce(CowID.x, CowID.y)
  )  %>%
  select(StatID, CowID, Label, Beg, End,
                Capital, everything()) %>%
  arrange(StatID, Beg)
stat_actor <- full_join(stat_actor, rat_actor, "StatID") %>%
  filter(!is.na(Beg))
stat_actor <- repaint(stat_actor, "StatID",
                      c("Capital","Micro","New", "Area", "Region"))
stat_actor <- subset(stat_actor, !(StatID=="CZE" &
                                     Beg == "1945-05-10" & End == "9999-12-31"))

stat_actor <- stat_actor %>% group_by(Group = overlaps(stat_actor, Id="StatID")) %>%
  summarise_all(funs(na_if(paste(sort(unique(na.omit(.))), collapse = "_"), ""))) %>%
  select(-c(Group)) %>%
  mutate(Beg = gsub("_1816-01-01","",Beg),
         Beg = gsub("1816-01-01_","",Beg),
         End = coalesce(End, "9999-12-31"),
         Micro = as.logical(Micro),
         Rat = as.numeric(Rat)) %>%
  arrange(StatID, Beg)
stat_actor[stat_actor$Capital=="Sanaa","Capital"] <- "Sana'a"

# Complete coordinates ####
# library(ggmap)
# stat_actor$Lat <- NA
# stat_actor$Lon <- NA
# stat_actor[,c("Lat","Lon")] <- geocode(stat_actor$Capital, source = "google")[,c(2,1)]
# stat_actor$Lat <- as.numeric(stat_actor$Lat)
# stat_actor$Lon <- as.numeric(stat_actor$Lon)
temp <- read_csv("data-raw/Stat_Actor/statlatlons.csv")
stat_actor <- full_join(stat_actor, temp, by = c("StatID", "Capital")) %>% distinct()

# Export ####
stat_actor <- as.data.frame(stat_actor) %>% arrange(Beg) %>% as_tibble()
# View(stat_actor)
usethis::use_data(stat_actor, overwrite = T)

# Plots ####
library(skimr)
skim(stat_actor)
library(DataExplorer)
DataExplorer::create_report(stat_actor,
                            output_file = "stat_actor_report.html", output_dir = "../../bitbucketio/gnevar/articles/",
                            config = list(
                              "introduce" = list(),
                              "plot_missing" = list(),
                              "plot_histogram" = list(),
                              "plot_bar" = list()
                            ))

# library(VennDiagram)
# futile.logger::flog.threshold(futile.logger::ERROR, name = "VennDiagramLogger")
# venn.diagram(list(sys_actor$StatID, isd_actor$StatID, rat_actor$StatID),
#              file = "../../bitbucketio/gnevar/figs/stat_actor_venn.png", imagetype = "png",
#              fill=c("darkmagenta", "steelblue", "midnightblue"),
#              alpha=c(0.5), cex = 2, cat.fontface=4,
#              category.names=c("gnevar","ISD","BS"),
#              main="stat_actor Overlap")

png("../../bitbucketio/gnevar/figs/stat_actor_vs.png", width = 12, height = 6, units = "in", res = 300)
barplot(c(COW=nrow(states::cowstates),GW=nrow(states::gwstates),GB=nrow(isd),GNEvAR=nrow(stat_actor)),
        main = "State Actors")
dev.off()

library(ggplot2)
plotstart <- "1049-01-01"
plotend <- "2018-01-01"
plotit <- stat_actor[order(stat_actor$Start),]
plotit[plotit$Start<plotstart,"Start"] <- plotstart
plotit[plotit$End>plotend,"End"] <- plotend
plotit <- plotit[order(plotit$Start),]
plotit <- plotit[order(duplicated(plotit$StatID)),]
library(scales)
ggplot(plotit, aes(x=StatID, ymin=as_date(Start), ymax=as_date(End))) + geom_linerange() +
  scale_y_date(limits = c(as_date(plotstart),as_date(plotend)), breaks = date_breaks("100 years")) +
  scale_x_discrete(limits=plotit$StatID[!duplicated(plotit$StatID)]) +
  coord_flip() + geom_hline(yintercept = as_date("1816-01-01"), color="red") + theme_classic() +
  theme(axis.text.x = element_text(angle=90,hjust=1,vjust=0.5)
        ,axis.text.y = element_blank(), axis.title.y = element_blank(), axis.ticks.y = element_blank()
        )
ggsave("../../bitbucketio/gnevar/figs/stat_actor_time.png", width=11, height=8)

library(daff)
render_diff(daff::diff_data(isd, stat_actor), "figs/stat_actor_diff.html", pretty = T)
library(webshot)
webshot("figs/stat_actor_diff.html", "figs/stat_actor_diff.png", selector = ".highlighter")
