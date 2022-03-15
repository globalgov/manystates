# EconomicFreedomHist Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
path <- "data-raw/Economics/EconomicFreedomHist/EconomicFreedomIndex.xlsx"
EconomicFreedomHist <- readxl::read_excel(path, sheet = 3)

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'EconomicFreedomHist' object until the object created
# below (in stage three) passes all the tests.
# Historical Economic Freedom Dataset: ----
EconomicFreedomHist <- dplyr::as_tibble(EconomicFreedomHist) %>%
  dplyr::mutate(Year = manypkgs::standardise_dates(as.character(Year)),
                COW_ID = manystates::code_states(Country)) %>%
  dplyr::arrange(COW_ID, Year) %>%
  dplyr::select(COW_ID, Year, dplyr::everything())
# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make EconomicFreedomHist available
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
# run `manypkgs::add_bib(Economics, EconomicFreedomHist)`.
# Economic Freedom Historical
manypkgs::export_data(EconomicFreedomHist, database = "economics",
                      URL = "https://www.fraserinstitute.org/economic-freedom")
