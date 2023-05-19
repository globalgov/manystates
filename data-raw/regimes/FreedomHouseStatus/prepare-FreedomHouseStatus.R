# FreedomHouseStatus Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for many packages universe.
# The FreedomHouseStatus dataset contains only the statuses of countries and 
# territories as determined by Freedom House in the 1973-2021 edition.
# These statuses are based on a range of scores by Freedom House.
# For the full scores,
# please see the FreedomHouseScore and FreedomHouseAggregate datasets.

# Stage one: Collecting data
# Countries
FreedomHouseStatus.1 <- readxl::read_excel("data-raw/regimes/FreedomHouseStatus/Country_and_Territory_Ratings_and_Statuses_FIW1973-2021.xlsx",
                                           sheet = 2,
                                           skip = 3,
                                           col_names = FALSE,
                                           na = "-")
# Territories
FreedomHouseStatus.2 <- readxl::read_excel("data-raw/regimes/FreedomHouseStatus/Country_and_Territory_Ratings_and_Statuses_FIW1973-2021.xlsx",
                                 sheet = 3,
                                 skip = 3,
                                 col_names = FALSE,
                                 na = "-")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'FreedomHouseStatus' object until the object created
# below (in stage three) passes all the tests.
# We recommend that you avoid using one letter variable names to keep
# away from issues with ambiguous names down the road.
# manypkgs includes several functions that should help cleaning
# and standardising your data such as `standardise_titles()`
# and `standardise_texts()`.
# Please see the vignettes or website for more details.

# Generate naming convention for columns
years <- (ncol(FreedomHouseStatus.1) - 1) / 3
var_years <- expand.grid(
  x = c("PR", "CL", "Status"),
  y = c(1972:1980, 1982:(1972 + years))
)
names(FreedomHouseStatus.1) <- c(
  "Country",
  paste(var_years$x,
        var_years$y,
        sep = "_"
  )
)
names(FreedomHouseStatus.2) <- c(
  "Country",
  paste(var_years$x,
        var_years$y,
        sep = "_"
  )
)
# Convert PR_1972 and CL_1972 to numeric and deal with South Africa
# Note: South Africa was coded into white(african) scores in 1972. See codebook.
FreedomHouseStatus.1[["PR_1972"]] <- as.double(FreedomHouseStatus.1[["PR_1972"]])
FreedomHouseStatus.1[["CL_1972"]] <- as.double(FreedomHouseStatus.1[["CL_1972"]])
FreedomHouseStatus.1 <- dplyr::add_row(FreedomHouseStatus.1,
                                       Country = "South Africa (Black)",
                                       PR_1972 = 5,
                                       CL_1972 = 6,
                                       Status_1972 = "NF",
                                       .before = 162)
FreedomHouseStatus.1$Country[161] <- "South Africa (White 1972, Total Rest)"
FreedomHouseStatus.1$PR_1972[161] <- 2
FreedomHouseStatus.1$CL_1972[161] <- 3
FreedomHouseStatus.1$Status_1972[161] <- "F"

# Combine countries and territories into one dataframe and add identifier dummy
FreedomHouseStatus <- rbind(FreedomHouseStatus.1, FreedomHouseStatus.2) %>%
  dplyr::mutate(
    Country = manypkgs::standardise_titles(Country),
    stateID = manypkgs::code_states(Country, abbrev = TRUE)) %>%
  dplyr::rename(StateName = Country)
FreedomHouseStatus$Territory <- c(
  rep(0, nrow(FreedomHouseStatus.1)),
  rep(1, nrow(FreedomHouseStatus.2))
)
# Pivot dataset and process further
FreedomHouseStatus <- tidyr::pivot_longer(FreedomHouseStatus,
                                     cols = dplyr::matches("[12][0-9]{3}"),
                                     values_transform =
                                       list(value = as.character)) %>%
  tidyr::separate(name, into = c("name", "Year"), sep = "_") %>%
  dplyr::mutate(Year = messydates::as_messydate(Year),
                ID = paste0(stateID, "-", as.character(Year))) %>%
  tidyr::pivot_wider(names_from = name,
                     values_from = value) %>%
  dplyr::rename(`PR rating` = PR, `CL rating` = CL) %>%
  dplyr::mutate(`PR rating` = as.double(`PR rating`),
                `CL rating` = as.double(`CL rating`)) %>%
  dplyr::relocate(ID, stateID, Year, StateName, `PR rating`, `CL rating`, Status)

# Stage three: Connecting data
# Next run the following line to make FreedomHouseStatus available
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
# please run `manypkgs::add_bib("regimes", "FreedomHouseStatus")`.
manypkgs::export_data(FreedomHouseStatus, database = "regimes",
                      URL = "https://freedomhouse.org/report/freedom-world")
