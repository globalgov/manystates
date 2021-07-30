# ISD Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.

# Stage one: Collecting data
ISD <- utils::read.csv("data-raw/states/ISD/ISD_Version1_Dissemination.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'ISD' object until the object created
# below (in stage three) passes all the tests. 

ISD <- tibble::as_tibble(ISD) %>%
  dplyr::rename(Finish = End) %>% 
  # Renaming the end date column to avoid self reference in transmutate.
  qData::transmutate(ID = `COW.ID`,
                     Beg = qCreate::standardise_dates(lubridate::dmy(Start)),
                     End = qCreate::standardise_dates(lubridate::dmy(Finish)),
                     Label = qCreate::standardise_titles(as.character(State.Name)),
                     COW_Nr = qCreate::standardise_titles(as.character(COW.Nr.))) %>%
  # Standardising the dummie variables
  dplyr::mutate(across(c(Micro, New.State),  ~ replace(., . == "", 0))) %>% 
  dplyr::mutate(across(c(Micro, New.State), ~ replace(., . == "X", 1))) %>%  
  #Dropping certain unnecessary columns.
  dplyr::select(-X, -X.1, -X.2, -X.3, -X.4, -X.5,  -X.6, -X.7) %>% 
  # Arranging dataset
  dplyr::relocate(ID, Beg, End, COW_Nr, Label, Micro, New.State) %>%
  dplyr::arrange(Beg, ID)
# We know that COW data for "old" states is set to 1816-01-01 by default.
# This is a rather uncretain date, that is, the dataset considers them states
# on 1st January 1816, but they may have been established (much) earlier.
# Let's signal to this uncretainty using `standardise_dates()` is a wrapper
# for the `{messydates}` package which is designed to deal with date uncretianty.
ISD$Beg <- qCreate::standardise_dates(stringr::str_replace_all(ISD$Beg,
                                                               "1816-1-1|1816-01-1|1816-1-01|1816-01-01",
                                                               "..1816-01-01"))
# qData and qCreate include several other
# functions that should help cleaning and
# standardizing your data.
# Please see the vignettes or website for more details.
# Stage three: Connecting data
# Next run the following line to make ISD available within the qPackage.
qCreate::export_data(ISD, database = "states",
                     URL="http://www.ryan-griffiths.com/data")

# This function also does two additional things.
# First, it creates a set of tests for this object to ensure adherence
# to certain standards. You can hit Cmd-Shift-T (Mac) or Ctrl-Shift-T (Windows)
# to run these tests locally at any point. Any test failures should be pretty
# self-explanatory and may require you to return to stage two and further clean,
# standardize, or wrangle your data into the expected format.
# Second, it also creates a documentation file for you to fill in.
# Please make sure that you cite any sources appropriately and fill in as
# much detail about the variables etc as possible.