# FreedomHouse Preparation Script

# This script imports, cleans and corrects the FreedomHouse dataset before
# including it in the regimes database.

# Note that the Freedom House dataset is comprised of three distinct Excel
# files that are each imported and cleaned in turn. Navigate to the
# corresponding file in the data raw folder for more details.

# Freedom House 1: Edition 2013-2021 ----
# Stage one: Collecting data
FreedomHouse1 <- readxl::read_excel("data-raw/regimes/FreedomHouse/All_data_FIW_2013-2021.xlsx",
                                    sheet = 2,
                                    skip = 1,
                                    na = c("-", "N/A"))
# Stage two: Correcting data
FreedomHouse1 <- dplyr::rename(FreedomHouse1, Label = `Country/Territory`) %>%
  manydata::transmutate(Territory = ifelse(`C/T` == "t", 1, 0)) %>%
  dplyr::mutate(
    cowID = manystates::code_states(Label, abbrev = TRUE),
    Year = messydates::as_messydate(as.character(Edition - 1)),
    #Year in which the data was collected is one year prior to the edition year
    Edition = messydates::as_messydate(as.character(Edition)),
    ID = paste0(cowID, "-", as.character(Year))
  ) %>%
  dplyr::relocate(ID, cowID, Year, Label)

# Freedom House 3: Aggregated category and subcategory scores edition 2003-2021 ----
# Stage one: Collecting data
# Data from edition 2006-2021
FreedomHouse3.1 <- readxl::read_excel("data-raw/regimes/FreedomHouse/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx",
                                      sheet = 2,
                                      na = c("-", "N/A")
)
FreedomHouse3.1 <- FreedomHouse3.1[, 1:19]
FreedomHouse3.1 <- dplyr::rename(FreedomHouse3.1,
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
# Data from edition 2003-2005
FreedomHouse3.2 <- readxl::read_excel("data-raw/regimes/FreedomHouse/Aggregate_Category_and_Subcategory_Scores_FIW_2003-2021.xlsx",
                                      sheet = 3,
                                      na = c("N/A", "-")
)
# Stage two: Correcting data
FreedomHouse3.2 <- dplyr::rename(FreedomHouse3.2,
                                 Label = `Country/Territory`
) %>%
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

FreedomHouse3 <- dplyr::bind_rows(FreedomHouse3.1, FreedomHouse3.2) %>%
  dplyr::mutate(
    Year = messydates::as_messydate(as.character(Year)),
    Edition = messydates::as_messydate(as.character(Edition))
  )

FreedomHouse <- dplyr::full_join(FreedomHouse1, FreedomHouse3,
                                 by = c("ID", "cowID", "Year", "Label",
                                        "Region", "Edition", "Status",
                                        "PR rating", "CL rating",
                                        "A", "B", "C", "Add Q", "Add A",
                                        "PR", "D", "E", "F", "G", "CL",
                                        "Total", "Territory"))

# Freedom House 2: Status of Countries and Territories 1973-2002 ----
# Stage one: Collecting data
# Freedom House 2.1: Countries
FreedomHouse2.1 <- readxl::read_excel("data-raw/regimes/FreedomHouse/Country_and_Territory_Ratings_and_Statuses_FIW1973-2021.xlsx",
                                      sheet = 2,
                                      skip = 3,
                                      col_names = FALSE,
                                      na = "-"
)
# Freedom House 2.2: Territories
FreedomHouse2.2 <- readxl::read_excel("data-raw/regimes/FreedomHouse/Country_and_Territory_Ratings_and_Statuses_FIW1973-2021.xlsx",
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
    cowID = manystates::code_states(Country, abbrev = TRUE)
  ) %>%
  dplyr::rename(Label = Country)
FreedomHouse2$Territory <- c(
  rep(0, nrow(FreedomHouse2.1)),
  rep(1, nrow(FreedomHouse2.2))
)
# Pivot dataset and process further
FreedomHouse2 <- tidyr::pivot_longer(FreedomHouse2,
                                     cols = dplyr::matches("[12][0-9]{3}"),
                                     values_transform =
                                       list(value = as.character)) %>%
  tidyr::separate(name, into = c("name", "Year"), sep = "_") %>%
  dplyr::mutate(Year = messydates::as_messydate(Year),
                ID = paste0(cowID, "-", as.character(Year))) %>%
  tidyr::pivot_wider(names_from = name,
                     values_from = value) %>%
  dplyr::rename(`PR rating` = PR, `CL rating` = CL) %>%
  dplyr::relocate(ID, cowID, Year, Label, `PR rating`, `CL rating`, Status) %>%
  dplyr::filter(Year <= 2001)

FreedomHouse2$`PR rating` <- as.double(FreedomHouse2$`PR rating`)
FreedomHouse2$`CL rating` <- as.double(FreedomHouse2$`CL rating`)

FreedomHouse <- dplyr::full_join(FreedomHouse, FreedomHouse2,
                                 by = c("ID", "cowID", "Year", "Label",
                                        "Status", "PR rating", "CL rating",
                                        "Territory"))

# manypkgs includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make FreedomHouse available
# within the many package.
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
# run `manypkgs::add_bib("regimes", "FreedomHouse")`.

# Export FreedomHouse
manypkgs::export_data(FreedomHouse, database = "regimes",
                      URL = "https://freedomhouse.org/report/freedom-world")
