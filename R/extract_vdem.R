#' Extract V-Dem and V-Party data
#'
#' Functions to import the
#' [V-Dem](https://www.v-dem.net/en/data/data/v-dem-dataset-v111/) and the
#' [V-Party](https://www.v-dem.net/en/data/data/v-party-dataset/) datasets
#' from their [`{vdemdata}`](https://github.com/vdeminstitute/vdemdata)
#' package in a qVerse consistent format.
#' @name extract_vdem
NULL

#' @name extract_vdem
#' @details `import_vdem()` imports VDem 11.1 dataset
#' and formats them to a qVerse consistent output.
#' @importFrom tibble as_tibble
#' @importFrom qData transmutate
#' @importFrom qCreate standardise_titles standardise_dates
#' @import dplyr
#' @return A dataframe with the qVerse-consistently formatted `[vdem]`
#' dataset.
#' @examples
#' \donttest{
#' import_vdem()
#' }
#' @export
import_vdem <- function() {
  # Stage 1: Importing
  vdem <- vdemdata::vdem
  # Stage two: Correcting data
  vdem <- as_tibble(vdem) %>%
    dplyr::rename("V-Dem_ID" = "country_id", "Abbrv" = "country_text_id") %>%
    dplyr::group_by(histname) %>%
    dplyr::mutate(beg = min(year),
                  end = max(year)) %>%
    dplyr::ungroup() %>%
    qData::transmutate(
      Beg = qCreate::standardise_dates(as.character(beg)),
      End = qCreate::standardise_dates(as.character(end)),
      # Label = qCreate::standardise_titles(histname),
      # Country = qCreate::standardise_titles(country_name),
      Date = qCreate::standardise_dates(historical_date),
      Year = qCreate::standardise_dates(as.character(year))) %>%
    dplyr::select(-project, #variable indicates which V-Dem project coded that
                  # country-year: Contemporary V-Dem, Historical V-Dem, or both
                  -historical, #variable indicates if the Historical V-Dem
                  # project coded a country at any time
                  -codingstart_contemp, -codingend_contemp, #removed because
                  # variable explains methodology relating to V-Dem coding
                  # time-periods
                  -codingstart_hist, -codingend_hist) %>% #removed because
                  # variable explains methodology relating to V-Dem
                  # coding time-periods.
    dplyr::arrange(`V-Dem_ID`, Year) %>%
    dplyr::relocate(`V-Dem_ID`, Abbrv, Beg, End, Year, Date)
  return(vdem)
}

# Note: We need to improve the performance of standardise_titles() for large
# datasets for both vdem and vparty imports.

#' @name extract_vdem
#' @details `import_vparty()` imports the V-Party dataset and formats it to
#' a qVerse consistent dataframe.
#' @importFrom tibble as_tibble
#' @import dplyr
#' @return A dataframe with the qVerse-consistently formatted `[vdem]`
#' dataset.
#' @examples
#' \donttest{
#' import_vparty()
#' }
#' @export
import_vparty <- function() {
  # Step 1: Import the data from the vdemdata package
  vparty <- vdemdata::vparty
  # Step 2: Format it to a qConsistent format
  vparty <- as_tibble(vparty) %>%
    dplyr::rename("V-Party_ID" = "v2paid",
                  "ID" = "country_id",
                  "Abbrv" = "v2pashname",
                  "Geographic Region" = "e_regiongeo",
                  "Geopolitical Region" = "e_regionpol") %>%
    dplyr::group_by(`V-Party_ID`) %>%
    dplyr::mutate(beg = min(year), #Year is observation year of the panel
                  end = max(year)) %>%
    qData::transmutate(
      Label = v2paenname, # qCreate::standardise_titles(v2paenname),
      Country = country_name, # qCreate::standardise_titles(country_name),
      Country_hist = histname, # qCreate::standardise_titles(histname),
      Beg = qCreate::standardise_dates(as.character(beg)),
      End = qCreate::standardise_dates(as.character(end)),
      Year = qCreate::standardise_dates(as.character(year))) %>%
    dplyr::select(-v2paorname,
                  #original party name, primarily a repetition of v2paid
                  -pf_party_id,
                  #refers to party ID used in predecessor dataset
                  -pf_url) %>%
                  #URL to party's webpage in predecessor dataset's website
    dplyr::arrange(Country, `V-Party_ID`, Beg) %>%
    dplyr::relocate(`V-Party_ID`,Label, Abbrv, Country, Country_hist,
                    ID, Beg, End, Year, )
  # Step 3: return vparty
  return(vparty)
}
