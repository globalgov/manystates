# ARCHIGOS Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.

# Stage one: Collecting data
# ARCHIGOS <- readr::read_csv2("data-raw/leaders/ARCHIGOS/ARCHIGOS.csv")
ARCHIGOS <- read.delim2("data-raw/leaders/ARCHIGOS/arch_annual.txt")

# First up, correction of an import warning. Line 5622, birthdate was misttyped
# Didier Burkhalter was born on the 17th of April 1960.
ARCHIGOS[["borndate"]][[5622]] <- as.Date("1960-04-17")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ARCHIGOS' object until the object created
# below (in stage three) passes all the tests.
ARCHIGOS <- as_tibble(ARCHIGOS) %>%
  mutate(across(where(is.character), ~dplyr::na_if(., "."))) %>%
  mutate(across(where(is.character), ~dplyr::na_if(., "NA"))) %>%
  mutate(across(where(is.character),
                ~dplyr::na_if(., "(p_year)"))) %>%
  mutate(across(where(is.character),
                ~dplyr::na_if(., "(n_year)"))) %>%
  mutate(across(where(is.character),
                ~dplyr::na_if(., "Missing: No Information Found"))) %>%
  qData::transmutate(ID = obsid,
                     LeadID = leadid,
                     Beg = qCreate::standardise_dates(startdate),
                     End = qCreate::standardise_dates(enddate),
                     BornDate = qCreate::standardise_dates(borndate),
                     DeathDate = qCreate::standardise_dates(deathdate),
                     YearBorn = qCreate::standardise_dates(as.character(yrborn)),
                     YearDied = qCreate::standardise_dates(as.character(yrdied)),
                     Female = ifelse(gender == "F", 1, 0)) %>%
  # NB: Max family ties is 3 at the moment
  tidyr::separate(fties, into = c(paste0("Fties",LETTERS[1:3])),
                  ";", remove = T) %>%
  tidyr::separate(FtiesA, into = c("FtiesNameA", "FtiesCodeA"),
                  "%", remove = T) %>%
  tidyr::separate(FtiesB, into = c("FtiesNameB", "FtiesCodeB"),
                  "%", remove = T) %>%
  tidyr::separate(FtiesC, into = c("FtiesNameC", "FtiesCodeC"),
                  "%", remove = T) %>%
  dplyr::mutate(
    leader = stringi::stri_trans_general(leader, "latin-ascii"),
    FtiesNameA = stringi::stri_trans_general(FtiesNameA, "latin-ascii"),
    FtiesNameB = stringi::stri_trans_general(FtiesNameB, "latin-ascii"),
    FtiesNameC = stringi::stri_trans_general(FtiesNameC, "latin-ascii"),
  ) %>%
  dplyr::mutate(Label = countrycode::countrycode(ccode,
                                                 origin = "cown",
                                                 destination = "cow.name"))

# TODO: Fix a bunch of issues with countrycode matching 

# Correction: Figueres Ferrer's son is not Calderón Fournier but
# José María Figueres
ARCHIGOS$FtiesNameA[c(2105, 2106, 2112:2117, 2133:2137)] <-
  "Father of Figueres Olsen"
ARCHIGOS$FtiesCodeA[c(2105, 2106, 2112:2117, 2133:2137)] <-
  "81ec65ae-1e42-11e4-b4cd-db5882bf8def"
# Correction: Self reference of family ties
ARCHIGOS$FtiesNameB[c(2158:2162)] <- NA
ARCHIGOS$FtiesCodeB[c(2158:2162)] <- NA
# Correction: Missing fties Figueres Olsen
ARCHIGOS$FtiesNameB[c(2163:2167)] <-
  "Son of Figueres Ferrer"
ARCHIGOS$FtiesCodeB[c(2163:2167)] <-
  "81eb718b-1e42-11e4-b4cd-db5882bf8def"

# TODO: Figure out a way of arranging stuff

# qCreate includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make ARCHIGOS available
# within the qPackage.
qCreate::export_data(ARCHIGOS, database = "leaders",
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
