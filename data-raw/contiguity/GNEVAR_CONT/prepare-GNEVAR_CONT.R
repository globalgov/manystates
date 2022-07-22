# REGIONS Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
GNEVAR_CONT <- readr::read_csv("data-raw/contiguity/REGIONS/FAO and Region Membership Data.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'REGIONS' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
GNEVAR_CONT <- as_tibble(GNEVAR_CONT) %>%
  dplyr::filter(ID != "ISO3") %>%
  dplyr::rename(stateID = ID, EntityType = CATEGORY, FAOmembership = FAO_MEMBERS,
                Group = IS_IN_GROUP, url = URI) %>%
  manydata::transmutate(Label = manypkgs::standardise_titles(LISTNAME_EN),
                        Contiguity = manypkgs::standardise_titles(HAS_BORDER_WITH),
                        Beg = messydates::as_messydate(VALID_SINCE),
                        End = messydates::as_messydate(VALID_UNTIL)) %>%
  dplyr::select(stateID, Label, Beg, End, Contiguity, EntityType, FAOmembership, Group, url) %>%
  dplyr::arrange(Beg, stateID)

# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`
# and `standardise_texts()`.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make REGIONS available
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
# please run `manypkgs::add_bib("contiguity", "GNEVAR_CONT")`.
manypkgs::export_data(GNEVAR_CONT, database = "contiguity",
                      URL = "NA")
