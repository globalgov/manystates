# FreedomHouseAggregate Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.
# The FreedomHouseAggregate dataset contains Freedom House aggregated category and
# subcategory scores from the 2003-2021 edition.

# Stage one: Collecting data
# Data from edition 2006-2021
FreedomHouseAggregate.1 <- readxl::read_excel("data-raw/regimes/FreedomHouseAggregate/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx",
                                              sheet = 2,
                                              na = c("-", "N/A"))
# Data from edition 2003-2005
FreedomHouseAggregate.2 <- readxl::read_excel("data-raw/regimes/FreedomHouseAggregate/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx",
                                              sheet = 3,
                                              na = c("N/A", "-"))

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'FreedomHouseAggregate' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
FreedomHouseAggregate.1 <- FreedomHouseAggregate.1[, 1:19]
FreedomHouseAggregate.1 <- dplyr::rename(FreedomHouseAggregate.1,
                                         Label = `Country/Territory`) %>%
  manydata::transmutate(Territory = ifelse(`C/T?` == "t", 1, 0)) %>%
  dplyr::mutate(
    cowID = manystates::code_states(Label, abbrev = TRUE),
    Year = as.character(Edition - 1),
    Edition = as.character(Edition),
    ID = paste0(cowID, "-", Year)
  ) %>%
  dplyr::rename(`PR rating` = `PR Rating`, `CL rating` = `CL Rating`) %>%
  dplyr::relocate(ID, cowID, Year, Label)

FreedomHouseAggregate.2 <- dplyr::rename(FreedomHouseAggregate.2,
                                         Label = `Country/Territory`) %>%
  manydata::transmutate(Territory = ifelse(`C/T?` == "t", 1, 0)) %>%
  dplyr::mutate(cowID = manystates::code_states(Label, abbrev = TRUE)) %>%
  tidyr::pivot_longer(cols = !c(Territory, cowID, Label)) %>%
  dplyr::mutate(
    Year = ifelse(grepl("03", name), "2002",
                  ifelse(grepl("04", name), "2003",
                         "2004"
                  )
    ),
    Rating = ifelse(grepl("PR", name), "PR rating",
                    ifelse(grepl("CL", name), "CL rating",
                           "Total"
                    )
    ),
    ID = paste0(cowID, "-", Year)
  ) %>%
  dplyr::select(ID, cowID, Year, Label, Rating, Territory, value) %>%
  tidyr::pivot_wider(names_from = Rating, values_from = value)

FreedomHouseAggregate <- dplyr::bind_rows(FreedomHouseAggregate.1, FreedomHouseAggregate.2) %>%
  dplyr::mutate(
    Year = messydates::as_messydate(as.character(Year)),
    Edition = messydates::as_messydate(as.character(Edition))
  )

# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`
# and `standardise_texts()`.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make FreedomHouseAggregate available
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
# please run `manypkgs::add_bib("regimes", "FreedomHouseAggregate")`.
manypkgs::export_data(FreedomHouseAggregate, database = "regimes",
                      URL = "https://freedomhouse.org/report/freedom-world")
