# V-Party Preparation Script

# This is a template for importing, cleaning, and exporting data
# ready for the qPackage.

# Stage one: Collecting data
`V-Party` <- read.csv("data-raw/regimes/V-Party/V-Dem-CPD-Party-V1.csv")

# Stage two: Correcting data
# In this stage you will want to correct the variable names and
# formats of the 'V-Party' object until the object created
# below (in stage three) passes all the tests.
`V-Party` <- as_tibble(`V-Party`) %>%
  dplyr::rename("V-Party_ID" = "v2paid", "ID" = "country_id", "Abbrv" = "v2pashname",
                "Geographic Region" = "e_regiongeo", "Geopolitical Region" = "e_regionpol") %>%
  dplyr::group_by(`V-Party_ID`) %>%
  dplyr::mutate(beg = min(year),
                end = max(year)) %>%
  qData::transmutate(Label = qCreate::standardise_titles(v2paenname), #name of party
                     Country = qCreate::standardise_titles(country_name), #name of country as used currently
                     Country_hist = qCreate::standardise_titles(histname), #name of country as used at the historical point in time
                     Beg = qCreate::standardise_dates(as.character(beg)), #beginning date of party
                     End = qCreate::standardise_dates(as.character(end)), #end date of party
                     Year = qCreate::standardise_dates(as.character(year))) %>%
  dplyr::select(-v2paorname, #original party name, primarily a repetition of v2paid
                -pf_party_id, #refers to party ID used in predecessor dataset
                -pf_url, #URL to party's webpage in predecessor dataset's website
                -CHES_ID, #ID from another dataset, Chapel Hill Expert Survey (CHES)
                -GPS_ID ) %>% #ID from another dataset, Global Party Survey (GPS)
  dplyr::arrange(Country, `V-Party_ID`, Beg) %>%
  dplyr::relocate(`V-Party_ID`, Abbrv, Label, Country, Country_hist, ID, Beg, End, Year, )

# qCreate includes several functions that should help cleaning
# and standardising your data.
# Please see the vignettes or website for more details.

# Stage three: Connecting data
# Next run the following line to make V-Party available
# within the qPackage.
qCreate::export_data(`V-Party`, database = "regimes",
                     URL = "https://doi.org/10.23696/vpartydsv1")
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
