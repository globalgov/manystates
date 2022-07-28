# ICOW_COL Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
ICOW_COL <- readr::read_csv("data-raw/states/ICOW_COL/ICOW_COL.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ICOW_COL' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
ICOW_COL <- as_tibble(ICOW_COL) %>%
  manydata::transmutate(cowNR = State,
                        Origin_COW_ID = From,
                        IndepType = Type,
                        Label = manypkgs::standardise_titles(Name),
                        Beg = messydates::as_messydate(lubridate::ym(Indep)),
                        Beg_COW = messydates::as_messydate(lubridate::ymd(COWsys)),
                        Beg_GW = messydates::as_messydate(lubridate::ymd(GWsys)),
                        Beg_Polity2 = messydates::make_messydate(IndepP2)) %>%
  dplyr::select(COW_ID, Label, Beg, Origin_COW_ID, IndepType, Beg_COW, Beg_GW, Beg_Polity2) %>%
  dplyr::arrange(Beg)
# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make ICOW_COL available
# within the package.
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards.You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point.
# Any test failures should be pretty self-explanatory and may require
# you to return to stage two and further clean, standardise, or wrangle
# your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please note that the export_data() function requires a .bib file to be
# present in the data_raw folder of the package for citation purposes.
# Therefore, please make sure that you have permission to use the dataset
# that you're including in the package.
# To add a template of .bib file to the package,
# please run `manypkgs::add_bib("states", "ICOW_COL")`.
manypkgs::export_data(ICOW_COL, database = "states",
                      URL = "https://doi.org/10.7910/DVN/5EMETG")
