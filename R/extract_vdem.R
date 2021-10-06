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
  # Initialising variables to avoid annoying note when running checks
  histname <- beg <- end <- country_name <- historical_date <- NULL
  project <- historical <- codingstart_contemp <- codingend_contemp <- NULL
  codingstart_hist <- codingend_hist <- ID <- Year <- Abbrv <- Label <- NULL
  Country <- Beg <- End <- NULL
  # Stage 1: Importing
  vdem <- vdemdata::vdem
  # Stage two: Correcting data
  vdem <- as_tibble(vdem) %>%
    dplyr::rename("ID" = "country_id", "Abbrv" = "country_text_id") %>%
    dplyr::group_by(histname) %>%
    dplyr::mutate(beg = min(year),
                  end = max(year)) %>%
    dplyr::ungroup() %>%
    qData::transmutate(
      Beg = qCreate::standardise_dates(as.character(beg)),
      End = qCreate::standardise_dates(as.character(end)),
      Label = histname,
      Country = country_name,
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
    dplyr::arrange(ID, Year) %>%
    dplyr::relocate(ID, Abbrv, Label, Country, Beg, End, Year, Date)
  return(vdem)
}

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
  # Initialize the variables used to avoid an annoying note
  VPartyID <- v2paenname <- country_name <- histname <- beg <- end <- NULL
  v2paorname <- pf_party_id <- pf_url <- Country <- Beg <- End <- NULL
  Label <- Abbrv <- Country_hist <- ID <- Year <- NULL
  # Step 1: Import the data from the vdemdata package
  vparty <- vdemdata::vparty
  # Step 2: Format it to a qConsistent format
  vparty <- as_tibble(vparty) %>%
    dplyr::rename("VPartyID" = "v2paid",
                  "ID" = "country_id",
                  "Abbrv" = "v2pashname",
                  "Geographic Region" = "e_regiongeo",
                  "Geopolitical Region" = "e_regionpol") %>%
    dplyr::group_by(VPartyID) %>%
    dplyr::mutate(beg = min(year), #Year is observation year of the panel
                  end = max(year)) %>%
    qData::transmutate(
      Label = v2paenname,
      Country = country_name,
      Country_hist = histname,
      Beg = qCreate::standardise_dates(as.character(beg)),
      End = qCreate::standardise_dates(as.character(end)),
      Year = qCreate::standardise_dates(as.character(year))) %>%
    dplyr::select(-v2paorname,
                  #original party name, primarily a repetition of v2paid
                  -pf_party_id,
                  #refers to party ID used in predecessor dataset
                  -pf_url) %>%
                  #URL to party's webpage in predecessor dataset's website
    dplyr::arrange(Country, VPartyID, Beg) %>%
    dplyr::relocate(VPartyID, Label, Abbrv, Country, Country_hist,
                    ID, Beg, End, Year, )
  # Step 3: return vparty
  return(vparty)
}
