# EconomicFreedom Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.

# Stage one: Collecting data
# Note: The two datasets are imported and processed separately since their
# methodology differs. Furthermore, they are not combined in the source
# file. Thus, this way of incorporating the data in {manystates} follows the
# authors' design.

# Import
path <- "data-raw/economics/EconomicFreedom/EconomicFreedomIndex.xlsx"
EconomicFreedom <- readxl::read_excel(path = path,
                                      skip = 4)[, 1:73]
# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'EconomicFreedom' object until the object created
# below (in stage three) passes all the tests.

# Economic Freedom Dataset: ----
EconomicFreedom <- dplyr::as_tibble(EconomicFreedom) %>%
  dplyr::rename(`1A_data` = data...9,
                `1B_data` = data...11,
                `1C_data` = data...13,
                `1Di_data` = data...15,
                `1Dii_data` = data...17,
                `3A_data` = data...32,
                `3B_data` = data...34,
                `3C_data` = data...36,
                `4Ai_data` = data...40,
                `4Aii_data` = data...42,
                `4Aiii_data` = data...44) %>%
  dplyr::mutate(cowID =
                  countrycode::countrycode(ISO_Code_3, "iso3c", "cowc",
                                           custom_match =
                                             c("HKG" = "HKG",
                                               "SRB" = "YUG")),
                Year = messydates::as_messydate(as.character(Year))) %>%
  dplyr::arrange(cowID, Year) %>%
  dplyr::relocate(cowID, Year) %>%
  dplyr::select(-c(ISO_Code_2, ISO_Code_3)) # obtainable from COW codes

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make EconomicFreedom available
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
# run `manypkgs::add_bib("economics", "EconomicFreedom")`.

# Economic Freedom
manypkgs::export_data(EconomicFreedom, database = "economics",
                     URL = "https://www.fraserinstitute.org/economic-freedom")
