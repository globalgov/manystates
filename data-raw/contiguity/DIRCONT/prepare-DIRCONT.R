# DIRCONT Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
DIRCONT <- readr::read_csv("data-raw/contiguity/DIRCONT/contdir.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'DIRCONT' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`
# and `standardise_texts()`.
# Please see the vignettes or website for more details.
DIRCONT <- as_tibble(DIRCONT) %>%
  dplyr::rename(dyadID = dyad, stateID1 = statelno, stateID2 = statehno,
                ContiguityType = conttype) %>%
  manydata::transmutate(Beg = messydates::as_messydate(as.character(begin),
                                                       resequence = "ym"),
                        End = messydates::as_messydate(as.character(end),
                                                       resequence = "ym"),
                        Label1 = manypkgs::standardize_titles(statelab),
                        Label2 = manypkgs::standardize_titles(statehab)) %>%
  dplyr::select(-c(notes, version)) %>%
  dplyr::relocate(dyadID, ContiguityType, Beg, End, stateID1, Label1, stateID2, Label2) %>%
  dplyr::arrange(Beg)

# Stage three: Connecting data
# Next run the following line to make DIRCONT available
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
# please run `manypkgs::add_bib("contiguity", "DIRCONT")`.
manypkgs::export_data(DIRCONT, database = "contiguity",
                      URL = "https://correlatesofwar.org/data-sets/direct-contiguity")
