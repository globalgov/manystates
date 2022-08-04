# ARCHIGOS Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many packages universe.

# Stage one: Collecting data
ARCHIGOS <- read.delim2("data-raw/leaders/archigos/arch_annual.txt")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ARCHIGOS' object until the object created
# below (in stage three) passes all the tests.
ARCHIGOS <- as_tibble(ARCHIGOS) %>%
  dplyr::mutate(across(where(is.character), ~dplyr::na_if(., "."))) %>%
  dplyr::mutate(across(where(is.character), ~dplyr::na_if(., "NA"))) %>%
  dplyr::mutate(across(where(is.character),
                ~dplyr::na_if(., "(p_year)"))) %>%
  dplyr::mutate(across(where(is.character),
                ~dplyr::na_if(., "(n_year)"))) %>%
  dplyr::mutate(across(where(is.character),
                ~dplyr::na_if(., "Missing: No Information Found"))) %>%
  manydata::transmutate(archigosID = obsid,
                     leaderID = leadid,
                     Beg = messydates::as_messydate(startdate),
                     End = messydates::as_messydate(enddate),
                     BornDate = messydates::as_messydate(borndate),
                     DeathDate = messydates::as_messydate(deathdate),
                     YearBorn = messydates::as_messydate(as.character(yrborn)),
                     YearDied = messydates::as_messydate(as.character(yrdied)),
                     Female = ifelse(gender == "F", 1, 0)) %>%
  # NB: Max family ties is 3 at the moment
  tidyr::separate(fties, into = c(paste0("Fties", LETTERS[1:3])),
                  ";", remove = TRUE) %>%
  tidyr::separate(FtiesA, into = c("FtiesNameA", "FtiesCodeA"),
                  "%", remove = TRUE) %>%
  tidyr::separate(FtiesB, into = c("FtiesNameB", "FtiesCodeB"),
                  "%", remove = TRUE) %>%
  tidyr::separate(FtiesC, into = c("FtiesNameC", "FtiesCodeC"),
                  "%", remove = TRUE) %>%
  dplyr::mutate(
    leader = stringi::stri_trans_general(leader, "latin-ascii"),
    FtiesNameA = stringi::stri_trans_general(FtiesNameA, "latin-ascii"),
    FtiesNameB = stringi::stri_trans_general(FtiesNameB, "latin-ascii"),
    FtiesNameC = stringi::stri_trans_general(FtiesNameC, "latin-ascii"),
  ) %>%
  dplyr::mutate(Label =
                  countrycode::countrycode(ccode,
                                          origin = "cown",
                                          destination = "cow.name",
                                          custom_match =
                                            c("260" = "German Federal Republic",
                                              "340" = "Serbia",
                                              "563" = "South African Republic",
                                              "564" = "Orange Free State",
                                              "711" = "Tibet",
                                              "730" = "Korea",
                                              "815" = "Vietnam"))) %>%
  dplyr::mutate(cowID =
                  countrycode::countrycode(ccode,
                                           origin = "cown",
                                           destination = "cowc",
                                           custom_match =
                                             c("260" = "GFR",
                                               "340" = "SRB",
                                               "563" = "SAR",
                                               "564" = "OFS",
                                               "711" = "TBT",
                                               "730" = "KOR",
                                               "815" = "VIE")))

# Note for the custom matching dictionary:
# 260; German Federal Republic, taken from COW.
# 340; Serbia until 1915 and from 2006 onward
# 563; Refers to the South African Republic
# 564; Refers to the Orange Free State
# 711; Refers to Tibet prior to 1951
# 730; Refers to Korea prior to the Korean War
# 815; Refers to imperial Vietnam prior to the French colonization
# Ordering variables for output:
ARCHIGOS <- ARCHIGOS %>%
    dplyr::select(archigosID, leaderID, cowID, idacr, Label, leader, Beg, End,
                  BornDate, DeathDate, YearBorn, YearDied, Female, entry, exit,
                  exitcode, prevtimesinoffice, posttenurefate, dbpedia.uri,
                  num.entry, num.exit, num.exitcode, num.posttenurefate,
                  FtiesNameA, FtiesCodeA, FtiesNameB, FtiesCodeB, FtiesNameC,
                  FtiesCodeC, ftcur)

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make ARCHIGOS available
# within the many package.
manypkgs::export_data(ARCHIGOS, database = "leaders",
                      URL = "http://ksgleditsch.com/archigos.html")
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
