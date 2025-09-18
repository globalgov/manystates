# GW Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many packages universe.

# Stage one: Collecting data
GW <- readxl::read_excel("data-raw/states/GW/gwstates.xlsx")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'GW' object until the object created
# below (in stage three) passes all the tests.
GW <- tibble::as_tibble(GW) %>%
  manydata::transmutate(cowID = `Cow ID`,
                        cowNR = `Cow Nr.`,
                        Begin = messydates::as_messydate(Start),
                        StateName = stringi::stri_trans_totitle(`Name of State`)) %>%
  dplyr::mutate(End = messydates::as_messydate(End),
                StateNameAlt = t(as.data.frame(stringi::stri_split_fixed(StateName, "(")))[,2],
                StateNameAlt = stringi::stri_replace_all_regex(StateNameAlt, "\\)", ""),
                StateNameAlt = stringi::stri_replace_all_regex(StateNameAlt, "/", ", "),
                StateName = t(as.data.frame(stringi::stri_split_fixed(StateName, "(")))[,1],
                StateName = stringi::stri_trim_both(StateName),
                StateNameAlt = dplyr::if_else(StateNameAlt == StateName, NA_character_, StateNameAlt),
                stateID = code_states(StateName)) %>%
  dplyr::select(stateID, StateName, Begin, End, StateNameAlt, everything()) %>%
  dplyr::arrange(Begin, stateID)

# Like COW data, GW sets "old" states as beginning from 1816-01-01 by default.
# This is an approximate and uncertain date,
# since these states may have been established (much) earlier.
# We can annotate the date to account for this uncertainty 
# using the `{messydates}` package,
# which is designed to deal with date uncertainty.
GW <- GW %>%
  dplyr::mutate(Begin = messydates::as_messydate(ifelse(Begin <= "1816-01-01",
                                                        messydates::on_or_before(Begin),
                                                        Begin)),
                End = messydates::as_messydate(ifelse(End >= "2017-12-31",
                                                      messydates::on_or_after(End),
                                                      End)))

# Stage three: Connecting data
# Next run the following line to make GW available within the package.
manypkgs::export_data(GW, datacube = "states",
                      URL = "http://ksgleditsch.com/data-4.html")

# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards. You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point. Any test failures should be pretty
# self-explanatory and may require you to return to stage two and further clean,
# standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as
# much detail about the variables etc as possible.
