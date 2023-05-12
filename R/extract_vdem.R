#' Extract V-Dem and V-Party data
#'
#' Functions to import the
#' [V-Dem](https://www.v-dem.net/en/data/data/v-dem-dataset-v111/) and the
#' [V-Party](https://www.v-dem.net/en/data/data/v-party-dataset/) datasets
#' from the [`{vdemdata}`](https://github.com/vdeminstitute/vdemdata)
#' package in a many packages universe consistent format.
#' @name extract_vdem
NULL

#' @name extract_vdem
#' @details `import_vdem()` imports VDem 11.1 dataset
#' and formats it to be consistent with the many packages universe.
#' @importFrom tibble as_tibble
#' @importFrom manypkgs standardise_dates
#' @importFrom rlang .data
#' @import dplyr
#' @import vdemdata
#' @return A dataframe of the`[vdem]` dataset in a many packages
#' universe-consistent format.
#' @examples
#' \donttest{
#' import_vdem()
#' }
#' @export
import_vdem <- function() {
  # Stage 1: Importing
  vdem <- vdemdata::vdem
  # Stage 2: Correcting data
  vdem <- as_tibble(vdem) %>%
    dplyr::rename("vdemID" = "country_id", "stateID" = "country_text_id") %>%
    dplyr::group_by(histname) %>%
    dplyr::mutate(beg = min(year),
                  end = max(year)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      Beg = messydates::make_messydate(as.character(beg)),
      End = messydates::make_messydate(as.character(end)),
      State = histname,
      StateName = country_name,
      Date = messydates::make_messydate(historical_date),
      Year = messydates::make_messydate(as.character(year))) %>%
    dplyr::select(-project, #variable indicates which V-Dem project code
                  # that country-year: Contemporary V-Dem, Historical V-Dem
                  -historical, #variable indicates if the Historical V-Dem
                  # project coded a country at any time
                  -codingstart_contemp, -codingend_contemp,
                  # removed because
                  # variable explains methodology relating to V-Dem coding
                  # time-periods
                  -codingstart_hist, -codingend_hist,
                  #removed because
                  # variable explains methodology relating to V-Dem
                  # coding time-periods.
                  -beg, end, histname, country_name,
                  historical_date, year) %>%
    dplyr::arrange(vdemID, Year) %>%
    dplyr::relocate(vdemID, stateID, StateName, State,
                    Beg, End, Year, Date)
  return(vdem)
}

#' @name extract_vdem
#' @details `import_vparty()` imports the V-Party dataset and
#' formats it to be consistent with the many packages universe.
#' @importFrom tibble as_tibble
#' @importFrom manypkgs standardise_dates
#' @importFrom rlang .data
#' @import dplyr
#' @import vdemdata
#' @return A dataframe of the`[vparty]` dataset consistent with the
#' many packages universe.
#' @examples
#' \donttest{
#' import_vparty()
#' }
#' @export
import_vparty <- function() {
  # Step 1: Import the data from the vdemdata package
  vparty <- vdemdata::vparty
  # Step 2: Format it to a many packages consistent format
  vparty <- as_tibble(vparty) %>%
    dplyr::rename("vpartyID" = "v2paid",
                  "stateNR" = "country_id",
                  "stateID" = "country_text_id",
                  "partyID" = "v2pashname",
                  "Geographic Region" = "e_regiongeo",
                  "Geopolitical Region" = "e_regionpol") %>%
    dplyr::group_by(vpartyID) %>%
    dplyr::mutate(beg = min(year), #Year is observation year of the panel
                  end = max(year)) %>%
    dplyr::mutate(
      Party = v2paenname,
      StateName = country_name,
      State = histname,
      Beg = messydates::make_messydate(as.character(beg)),
      End = messydates::make_messydate(as.character(end)),
      Year = messydates::make_messydate(as.character(year))) %>%
    dplyr::select(-v2paorname,
                  #original party name, primarily a repetition of v2paid
                  -pf_party_id,
                  #refers to party ID used in predecessor dataset
                  -pf_url,
                  #URL to party's webpage in predecessor dataset's website
                  v2paenname, country_name, histname,
                  beg, end, year) %>%
    dplyr::arrange(StateName, vpartyID, Beg) %>%
    dplyr::relocate(vpartyID, Party, partyID,
                    StateName, State, stateID,
                    stateNR, Beg, End, Year,
                    `Geographic Region`, `Geopolitical Region`)
  # Step 3: return vparty
  return(vparty)
}
