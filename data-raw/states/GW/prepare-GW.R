# GW Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.

# Stage one: Collecting data
GW <- readxl::read_excel("data-raw/states/GW/gwstates.xlsx")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'GW' object until the object created
# below (in stage three) passes all the tests. 
GW <- tibble::as_tibble(GW) %>%
  dplyr::rename(Finish = End) %>%
  qData::transmutate(ID = `Cow ID`,
                     Beg = qCreate::standardise_dates(Start),
                     End = qCreate::standardise_dates(Finish), 
                     Label = qCreate::standardise_titles(`Name of State`),
                     COW_Nr = qCreate::standardise_titles(`Cow Nr.`)) %>%
  dplyr::relocate(ID, Beg, End, COW_Nr, Label) %>%
  dplyr::arrange(Beg, ID)
# We know that COW data for "old" states is set to 1816-01-01 by default.
# This is a rather uncretain date, that is, the dataset considers them states
# on 1st January 1816, but they may have been established (much) earlier.
# Let's signal to this uncretainty using `standardise_dates()` is a wrapper
# for the `{messydates}` package which is designed to deal with date uncretianty.
GW$Beg <- qCreate::standardise_dates(stringr::str_replace_all(GW$Beg,
                                                               "1816-1-1|1816-01-1|1816-1-01|1816-01-01",
                                                               "..1816-01-01"))
# We can do the same for End dates to signal uncertainty. 
GW$End <- qCreate::standardise_dates(stringr::str_replace_all(GW$End,
                                                               "2017-12-31",
                                                               "2017-12-31.."))
# qData and qCreate include several other
# functions that should help cleaning and
# standardizing your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make GW available within the qPackage.
qCreate::export_data(GW, database = "states",
                     URL="http://ksgleditsch.com/data-4.html")

# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards. You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point. Any test failures should be pretty
# self-explanatory and may require you to return to stage two and further clean,
# standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as
# much detail about the variables etc as possible.