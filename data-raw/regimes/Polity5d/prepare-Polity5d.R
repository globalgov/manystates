# Polity5d Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.
library(qCreate)
library(qData)
library(messydates)

# Stage one: Collecting data

#### Sidenote ####
# Both Polity datasets have a slightly different structure. Polity5 is a
# year-country dataset while Polity5d is a "polity case" dataset 
# (e.g. one observation per regime change)

# Polity case data
Polity5d <- readxl::read_excel("data-raw/regimes/Polity5d/p5v2018d.xls")

# Deal with import warnings above-------------------------------------------

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'Polity5' object until the object created
# below (in stage three) passes all the tests.

Polity5d <- as_tibble(Polity5d) %>%
  transmutate(ID = ccode,
              Beg = messydates::make_messydate(byear, bmonth, bday),
              End = messydates::make_messydate(eyear, emonth, eday),
              Label = standardise_titles(country)) %>%
  dplyr::arrange(ID, Beg, End) %>%
  dplyr::select(-scode) %>%
  dplyr::relocate(ID, Beg, End, Label)

# qData includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make Polity5 available
# within the qPackage.
export_data(Polity5d, database = "regimes", URL = "http://www.systemicpeace.org/inscrdata.html")
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
