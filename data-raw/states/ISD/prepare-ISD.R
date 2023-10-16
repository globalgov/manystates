# ISD Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the many packages universe

# Stage one: Collecting data
ISD <- utils::read.csv("data-raw/states/ISD/ISD_Version1_Dissemination.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ISD' object until the object created
# below (in stage three) passes all the tests.
ISD <- tibble::as_tibble(ISD) %>%
  dplyr::rename(Finish = End) %>%
  # Renaming the end date column to avoid self reference in transmutate.
  manydata::transmutate(cowID = `COW.ID`,
                        Beg = messydates::as_messydate(Start,
                                                    resequence = "dmy"),
                        End = messydates::as_messydate(Finish,
                                                    resequence = "dmy"),
                        StateName = manypkgs::standardise_titles(as.character(State.Name)),
                        cowNr = manypkgs::standardise_titles(as.character(COW.Nr.))) %>%
  # Standardising the dummy variables
  dplyr::mutate(across(c(Micro, NewState),  ~ replace(., . == "", 0))) %>%
  dplyr::mutate(across(c(Micro, NewState), ~ replace(., . == "X", 1))) %>%  
  #Dropping unnecessary columns.
  dplyr::select(-X, -X.1, -X.2, -X.3, -X.4, -X.5,  -X.6, -X.7) %>%
  # Arranging dataset
  dplyr::relocate(cowID, Beg, End, cowNR, StateName, Micro, NewState) %>%
  dplyr::arrange(Beg, cowID)

# Like COW, ISD sets "old" states as beginning on 1816-01-01 by default.
# This is an approximate and uncertain date,
# since these states may have been established (much) earlier.
# We can annotate the date to account for this uncertainty
# using the `{messydates}` package,
# which is designed to deal with date uncertainty.
ISD <- ISD %>% dplyr::mutate(Beg = messydates::as_messydate(ifelse(Beg <= "1816-01-01", messydates::on_or_before(Beg), Beg)),
                             End = messydates::as_messydate(ifelse(End >= "2011-12-31", messydates::on_or_after(End), End)))

# ensure NAs are coded correctly
ISD <- ISD %>%
  dplyr::mutate(across(everything(),
                       ~stringr::str_replace_all(.,
                                                 "^NA$", NA_character_))) %>%
  dplyr::rename(Begin = Beg) %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin),
                End = messydates::as_messydate(End)) %>%
  dplyr::relocate(cowID, Begin, End)

# manydata and manypkgs include several other
# functions that should help cleaning and
# standardizing your data.
# Please see the vignettes or website for more details.
# Stage three: Connecting data
# Next run the following line to make ISD available within the package.
manypkgs::export_data(ISD, datacube = "states",
                      URL = "http://www.ryan-griffiths.com/data")
# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards. You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point. Any test failures should be pretty
# self-explanatory and may require you to return to stage two and further clean,
# standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as
# much detail about the variables etc as possible.
