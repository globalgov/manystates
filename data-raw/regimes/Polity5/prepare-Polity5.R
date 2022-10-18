# Polity5 Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many packages universe.

# Stage one: Collecting data

#### Sidenote ####
# Both Polity datasets have a slightly different structure.
# Polity5 is a year-country dataset
# while Polity5d is a "polity case" dataset
# (e.g. one observation per regime change).
# We only integrate the Polity5 dataset in the present package.

# Polity case data
Polity5 <- readxl::read_excel("data-raw/regimes/Polity5/p5v2018.xls")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'Polity5' object until the object created
# below (in stage three) passes all the tests.
Polity5 <- tibble::as_tibble(Polity5) %>%
  dplyr::mutate(cowID = manypkgs::code_states(country, abbrev = TRUE)) %>%
  manydata::transmutate(
              Beg = messydates::make_messydate(byear, bmonth, bday),
              End = messydates::make_messydate(eyear, emonth, eday),
              Year = messydates::as_messydate(as.character(year)),
              Label = manypkgs::standardise_titles(country)) %>%
  dplyr::mutate(ID = paste0(cowID, "-", Year)) %>%
  dplyr::arrange(cowID, Year) %>%
  dplyr::select(-scode) %>%
  dplyr::relocate(ID, cowID, Year, Label)

# manydata includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Dealing with special codes in autoc, democ, polity and polity2 variables.
# Adds a dummy variable for polity interruptions, interregnum and transitions.
Polity5 <- Polity5 %>%
  # Create a new variable to hold special cases
  dplyr::mutate(speccat = ifelse(democ == -66, -66,
                          ifelse(democ == -77, -77,
                          ifelse(democ == -88, -88, NA)))) %>%
  # Set special cases to NA in original variables
  dplyr::mutate(dplyr::across(c(democ, autoc, polity, polity2, xrreg,
                                xrcomp, xropen, xconst, parreg, parcomp,
                                exconst),
                              ~dplyr::na_if(., -66))) %>%
  dplyr::mutate(dplyr::across(c(democ, autoc, polity, polity2, xrreg,
                                xrcomp, xropen, xconst, parreg, parcomp,
                                exconst),
                              ~dplyr::na_if(., -77))) %>%
  dplyr::mutate(dplyr::across(c(democ, autoc, polity, polity2, xrreg,
                                xrcomp, xropen, xconst, parreg, parcomp,
                                exconst),
                              ~dplyr::na_if(., -88))) %>%
  # Set messydates column NA-NA-NA to NA
  dplyr::mutate(dplyr::across(c(Beg, End),
                              ~dplyr::na_if(., "NA-NA-NA")))

# Stage three: Connecting data
# Next run the following line to make Polity5 available
# within the many package.
manypkgs::export_data(Polity5, database = "regimes", 
                     URL = "http://www.systemicpeace.org/inscrdata.html")

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
