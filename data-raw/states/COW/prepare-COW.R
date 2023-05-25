# COW Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many package.

# Stage one: Collecting data
COW <- readr::read_csv("data-raw/states/COW/states2016.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'COW' object until the object created
# below (in stage three) passes all the tests.
COW <- tibble::as_tibble(COW) %>%
  manydata::transmutate(cowID = stateabb,
                        Beg = messydates::make_messydate(styear, stmonth, stday),
                        End = messydates::make_messydate(endyear, endmonth, endday),
                        StateName = manypkgs::standardise_titles(statenme),
                        cowNR = manypkgs::standardise_titles(as.character(ccode))) %>%
  dplyr::select(cowID, Beg, End, cowNR, StateName) %>%
  dplyr::arrange(Beg, cowID)

# We know that COW data for "old" states is set to 1816-01-01 by default.
# This is a rather uncertain date, that is, the dataset considers them states
# on 1st January 1816, but they may have been established (much) earlier.
# Let's signal to this uncertainty using the `{messydates}` package,
# which is designed to deal with date uncertainty
COW <- COW %>% dplyr::mutate(Beg = messydates::as_messydate(ifelse(Beg <= "1816-01-01", messydates::on_or_before(Beg), Beg)),
                             End = messydates::as_messydate(ifelse(End >= "2016-12-31", messydates::on_or_after(End), End)))
# manydata and manypkgs include several other
# functions that should help cleaning and
# standardizing your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make COW available within the many package.
manypkgs::export_data(COW, database = "states",
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
