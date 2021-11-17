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
#' @importFrom manypkgs standardise_dates
#' @importFrom rlang .data
#' @import dplyr
#' @return A dataframe of the`[vdem]` dataset in a qVerse-consistent format.
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
    dplyr::rename("ID" = "country_id", "Abbrv" = "country_text_id") %>%
    dplyr::group_by(.data$histname) %>%
    dplyr::mutate(beg = min(.data$year),
                  end = max(.data$year)) %>%
    dplyr::ungroup() %>%
    qData::transmutate(
      Beg = manypkgs::standardise_dates(as.character(.data$beg)),
      End = manypkgs::standardise_dates(as.character(.data$end)),
      Label = .data$histname,
      Country = .data$country_name,
      Date = manypkgs::standardise_dates(.data$historical_date),
      Year = manypkgs::standardise_dates(as.character(.data$year))) %>%
    dplyr::select(-.data$project, #variable indicates which V-Dem project code
                  # that country-year: Contemporary V-Dem, Historical V-Dem
                  -.data$historical, #variable indicates if the Historical V-Dem
                  # project coded a country at any time
                  -.data$codingstart_contemp, -.data$codingend_contemp,
                  # removed because
                  # variable explains methodology relating to V-Dem coding
                  # time-periods
                  -.data$codingstart_hist, -.data$codingend_hist) %>%
                  #removed because
                  # variable explains methodology relating to V-Dem
                  # coding time-periods.
    dplyr::arrange(.data$ID, .data$Year) %>%
    dplyr::relocate(.data$ID, .data$Abbrv, .data$Label, .data$Country,
                    .data$Beg, .data$End, .data$Year, .data$Date)
  return(vdem)
}

#' @name extract_vdem
#' @details `import_vparty()` imports the V-Party dataset and formats it to
#' a qVerse consistent dataframe.
#' @importFrom tibble as_tibble
#' @import dplyr
#' @importFrom manypkgs standardise_dates
#' @importFrom rlang .data
#' @return A dataframe of the`[vparty]` dataset in a qVerse-consistent format.
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
    dplyr::rename("VPartyID" = "v2paid",
                  "ID" = "country_id",
                  "Abbrv" = "v2pashname",
                  "Geographic Region" = "e_regiongeo",
                  "Geopolitical Region" = "e_regionpol") %>%
    dplyr::group_by(.data$VPartyID) %>%
    dplyr::mutate(beg = min(.data$year), #Year is observation year of the panel
                  end = max(.data$year)) %>%
    qData::transmutate(
      Label = .data$v2paenname,
      Country = .data$country_name,
      Country_hist = .data$histname,
      Beg = manypkgs::standardise_dates(as.character(.data$beg)),
      End = manypkgs::standardise_dates(as.character(.data$end)),
      Year = manypkgs::standardise_dates(as.character(.data$year))) %>%
    dplyr::select(-.data$v2paorname,
                  #original party name, primarily a repetition of v2paid
                  -.data$pf_party_id,
                  #refers to party ID used in predecessor dataset
                  -.data$pf_url) %>%
                  #URL to party's webpage in predecessor dataset's website
    dplyr::arrange(.data$Country, .data$VPartyID, .data$Beg) %>%
    dplyr::relocate(.data$VPartyID, .data$Label, .data$Abbrv,
                    .data$Country, .data$Country_hist,
                    .data$ID, .data$Beg, .data$End, .data$Year, )
  # Step 3: return vparty
  return(vparty)
}
