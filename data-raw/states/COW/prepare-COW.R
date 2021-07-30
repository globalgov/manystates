# COW Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.

# Stage one: Collecting data
COW <- readr::read_csv("data-raw/states/COW/states2016.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'COW' object until the object created
# below (in stage three) passes all the tests.
COW <- tibble::as_tibble(COW) %>%
  transmutate(ID = stateabb,
         Beg = qCreate::standardise_dates(styear, stmonth, stday),
         End = qCreate::standardise_dates(endyear, endmonth, endday),
         Label = standardise_titles(statenme),
         COW_Nr = standardise_titles(as.character(ccode))) %>%
  dplyr::select(COW_Nr, ID, Beg, End, Label) %>%
  dplyr::relocate(ID, Beg, End, COW_Nr, Label) %>%
  dplyr::arrange(Beg, ID)
# We know that COW data for "old" states is set to 1816-01-01 by default.
# This is a rather uncretain date, that is, the dataset considers them states
# on 1st January 1816, but they may have been established (much) earlier.
# Let's signal to this uncretainty using `standardise_dates()` is a wrapper
# for the `{messydates}` package which is designed to deal with date uncretianty.
COW$Beg <- qCreate::standardise_dates(stringr::str_replace_all(COW$Beg,
                                                               "1816-1-1|1816-01-1|1816-1-01|1816-01-01",
                                                               "..1816-01-01"))
# qData and qCreate include several other
# functions that should help cleaning and
# standardizing your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make COW available within the qPackage.
export_data(COW, database = "states",
            URL = "https://correlatesofwar.org/data-sets/state-system-membership")

# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards. You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point. Any test failures should be pretty
# self-explanatory and may require you to return to stage two and further clean,
# standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as
# much detail about the variables etc as possible.
