# FreedomHouse Preparation Script

# This script imports, cleans and corrects the FreedomHouse dataset before
# including it in the Freedom House database.
# 
# Note that the Freedom House dataset is comprised of three distinct Excel
# files that are each imported and cleaned in turn. Navigate to the
# corresponding file in the data raw folder for more details.

# Freedom House 1: Modern 2013-2021 ----

# Stage one: Collecting data
FreedomHouse1 <- readxl::read_excel("data-raw/regimes/FreedomHouse1/All_data_FIW_2013-2021.xlsx",
                                    sheet = 2,
                                    skip = 1,
                                    na = c("-", "N/A"))
# Stage two: Correcting data
FreedomHouse1 <- dplyr::rename(FreedomHouse1, Label = `Country/Territory`) %>%
  manydata::transmutate(Territory = ifelse(`C/T` == "t", 1, 0)) %>%
  dplyr::mutate(
    COW_ID = manystates::code_states(Label, abbrev = TRUE),
    Year = manypkgs::standardise_dates(as.character(Edition - 1)),
    Edition = manypkgs::standardise_dates(as.character(Edition)),
    ID = paste0(COW_ID, "-", as.character(Year))
  ) %>%
  dplyr::relocate(ID, COW_ID, Year, Label)


# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make FreedomHouse available
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
# To add a template of .bib file to package,
# run `manypkgs::add_bib(regimes, FreedomHouse)`.

# Export FreedomHouse1
manypkgs::export_data(FreedomHouse1,
  database = "regimes",
  URL = "https://freedomhouse.org/report/freedom-world"
)
