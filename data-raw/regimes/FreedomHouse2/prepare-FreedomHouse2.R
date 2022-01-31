# FreedomHouse Preparation Script

# This script imports, cleans and corrects the FreedomHouse dataset before
# including it in the Freedom House database.
# 
# Note that the Freedom House dataset is comprised of three distinct Excel
# files that are each imported and cleaned in turn. Navigate to the
# corresponding file in the data raw folder for more details.

# Freedom House 2: Full 1973 - 2021 ----
# Stage one: Collecting data
# Freedom House 2.1: Countries
FreedomHouse2.1 <- readxl::read_excel("data-raw/regimes/FreedomHouse2/Country_and_Territory_Ratings_and_Statuses_FIW1973-2021.xlsx",
  sheet = 2,
  skip = 3,
  col_names = FALSE,
  na = "-"
)
# Freedom House 2.2: Territories
FreedomHouse2.2 <- readxl::read_excel("data-raw/regimes/FreedomHouse2/Country_and_Territory_Ratings_and_Statuses_FIW1973-2021.xlsx",
  sheet = 3,
  skip = 3,
  col_names = FALSE,
  na = "-"
)
# Stage two: Correcting data
# Generate naming convention for columns
years <- (ncol(FreedomHouse2.1) - 1) / 3
var_years <- expand.grid(
  x = c("PR", "CL", "Status"),
  y = c(1972:1980, 1982:(1972 + years))
)
names(FreedomHouse2.1) <- c(
  "Country",
  paste(var_years$x,
    var_years$y,
    sep = "_"
  )
)
names(FreedomHouse2.2) <- c(
  "Country",
  paste(var_years$x,
    var_years$y,
    sep = "_"
  )
)
# Convert PR_1972 and CL_1972 to numeric and deal with South Africa
# Note: South Africa was coded into white(african) scores in 1972. See codebook.
FreedomHouse2.1[["PR_1972"]] <- as.double(FreedomHouse2.1[["PR_1972"]])
FreedomHouse2.1[["CL_1972"]] <- as.double(FreedomHouse2.1[["CL_1972"]])
FreedomHouse2.1 <- dplyr::add_row(FreedomHouse2.1,
  Country = "South Africa (Black)",
  PR_1972 = 5,
  CL_1972 = 6,
  Status_1972 = "NF",
  .before = 162
)
FreedomHouse2.1$Country[161] <- "South Africa (White 1972, Total Rest)"
FreedomHouse2.1$PR_1972[161] <- 2
FreedomHouse2.1$CL_1972[161] <- 3
FreedomHouse2.1$Status_1972[161] <- "F"
# Combine countries and territories into one dataframe and add identifier dummy
FreedomHouse2 <- rbind(FreedomHouse2.1, FreedomHouse2.2) %>%
  dplyr::mutate(
    Country = manypkgs::standardise_titles(Country),
    ID = manystates::code_states(Country)
  ) %>%
  dplyr::rename(Label = Country)
FreedomHouse2$Territory <- c(
  rep(0, nrow(FreedomHouse2.1)),
  rep(1, nrow(FreedomHouse2.2))
)
# Pivot things to a long format and process further
FreedomHouse2 <- tidyr::pivot_longer(FreedomHouse2,
  cols = dplyr::matches("[12][0-9]{3}"),
  values_transform =
    list(value = as.character)
) %>%
  dplyr::rename(Indicator = name, Value = value) %>%
  tidyr::separate(Indicator, into = c("Status", "Year"), sep = "_") %>%
  dplyr::mutate(Year = manypkgs::standardise_dates(Year)) %>%
  dplyr::relocate(ID, Year, Label, Status, Value, Territory)

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

# Export FreedomHouse2
manypkgs::export_data(FreedomHouse2,
                      database = "regimes",
                      URL = "https://freedomhouse.org/report/freedom-world"
)
