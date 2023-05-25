# HUGGO_ARCHIGOS Preparation Script

# The HUGGO_ARCHIGOS dataset contains handcoded corrections to the data
# in the original ARCHIGOS dataset.

# This is a template for importing, cleaning, and exporting data
# ready for the many packages universe.

# Stage one: Collecting data from actual Archigos dataset
HUGGO_ARCHIGOS <- manystates::leaders$ARCHIGOS

# 1. Correction of an import warning.
# Line 5622 birthdate was misttyped;
# Didier Burkhalter was born on the 17th of April 1960.
HUGGO_ARCHIGOS[["BornDate"]][[5622]] <- messydates::as_messydate("1960-04-17")

# 2. Correction: Figueres Ferrer's son is not Calderón Fournier but
# José María Figueres
HUGGO_ARCHIGOS$FtiesNameA[c(2105, 2106, 2112:2117, 2133:2137)] <-
  "Father of Figueres Olsen"
HUGGO_ARCHIGOS$FtiesCodeA[c(2105, 2106, 2112:2117, 2133:2137)] <-
  "81ec65ae-1e42-11e4-b4cd-db5882bf8def"

# 3. Correction: Self reference of family ties
HUGGO_ARCHIGOS$FtiesNameB[c(2158:2162)] <- NA
HUGGO_ARCHIGOS$FtiesCodeB[c(2158:2162)] <- NA

# 4. Correction: Missing fties Figueres Olsen
HUGGO_ARCHIGOS$FtiesNameB[c(2163:2167)] <-
  "Son of Figueres Ferrer"
HUGGO_ARCHIGOS$FtiesCodeB[c(2163:2167)] <-
  "81eb718b-1e42-11e4-b4cd-db5882bf8def"

# Formatting dataset for exporting
HUGGO_ARCHIGOS <- HUGGO_ARCHIGOS %>%
  dplyr::select(
    archigosID, cowID, leaderID, idacr, StateName, leader, Beg, End,
    BornDate, DeathDate, YearBorn, YearDied, Female, entry, exit, exitcode,
    prevtimesinoffice, posttenurefate, dbpedia.uri, num.entry,
    num.exit, num.exitcode, num.posttenurefate, FtiesNameA,
    FtiesCodeA, FtiesNameB, FtiesCodeB, FtiesNameC, FtiesCodeC,
    ftcur
  ) %>%
  dplyr::slice(c(5622, 2105, 2106, 2112:2117, 2133:2137, 2158:2162, 2163:2167))

# make sure all vars are correctly coded as NA if necessary
HUGGO_ARCHIGOS <- HUGGO_ARCHIGOS %>% 
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(., "^NA$", NA_character_))) %>%
  mutate(Beg = messydates::as_messydate(Beg),
         End = messydates::as_messydate(End),
         BornDate = messydates::as_messydate(BornDate),
         DeathDate = messydates::as_messydate(DeathDate),
         YearBorn = messydates::as_messydate(YearBorn),
         YearDied = messydates::as_messydate(YearDied)) %>% 
  dplyr::distinct(.keep_all = TRUE)

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make HUGGO_ARCHIGOS available
# within the many package.
manypkgs::export_data(HUGGO_ARCHIGOS, database = "leaders",
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
