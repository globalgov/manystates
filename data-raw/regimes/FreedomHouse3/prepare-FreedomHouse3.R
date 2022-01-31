# FreedomHouse Preparation Script

# This script imports, cleans and corrects the FreedomHouse dataset before
# including it in the Freedom House database.
# 
# Note that the Freedom House dataset is comprised of three distinct Excel
# files that are each imported and cleaned in turn. Navigate to the
# corresponding file in the data raw folder for more details.

# Freedom House 3: Subcategory scores 2003-2021 ----
# Stage one: Collecting data
# Data from 2006-2021
FreedomHouse3.1 <- readxl::read_excel("data-raw/regimes/FreedomHouse3/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx",
  sheet = 2,
  na = c("-", "N/A")
)
FreedomHouse3.1 <- FreedomHouse3.1[, 1:19]
FreedomHouse3.1 <- dplyr::rename(FreedomHouse3.1, Label = `Country/Territory`) %>%
  manydata::transmutate(Territory = ifelse(`C/T?` == "t", 1, 0)) %>%
  dplyr::mutate(
    ID = manystates::code_states(Label),
    Year = as.character(Edition - 1),
    Edition = as.character(Edition)
  ) %>%
  dplyr::relocate(ID, Year, Label)
# Data from 2003-2006
FreedomHouse3.2 <- readxl::read_excel("data-raw/regimes/FreedomHouse3/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx",
  sheet = 3,
  na = c("N/A", "-")
)
# Stage two: Correcting data
FreedomHouse3.2 <- dplyr::rename(FreedomHouse3.2,
  Label = `Country/Territory`
) %>%
  manydata::transmutate(Territory = ifelse(`C/T?` == "t", 1, 0)) %>%
  dplyr::mutate(ID = manystates::code_states(Label)) %>%
  tidyr::pivot_longer(cols = !c(Territory, ID, Label)) %>%
  dplyr::mutate(
    Year = ifelse(grepl("03", name), "2003",
      ifelse(grepl("04", name), "2004",
        "2005"
      )
    ),
    Rating = ifelse(grepl("PR", name), "PR Rating",
      ifelse(grepl("CL", name), "CL Rating",
        "Total"
      )
    )
  ) %>%
  dplyr::select(ID, Year, Label, Rating, Territory, value) %>%
  pivot_wider(
    names_from = Rating,
    values_from = value
  )

FreedomHouse3 <- dplyr::bind_rows(FreedomHouse3.1, FreedomHouse3.2) %>%
  dplyr::mutate(
    Year = manypkgs::standardise_dates(Year),
    Edition = manypkgs::standardise_dates(Edition)
  )

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

# Export FreedomHouse3
manypkgs::export_data(FreedomHouse3,
                      database = "regimes",
                      URL = "https://freedomhouse.org/report/freedom-world"
)
