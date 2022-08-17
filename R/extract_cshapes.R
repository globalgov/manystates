#' Extract CShapes data and matrix
#'
#' Functions to import CShapes 2.0 datasets and distances from
#' the `[cShapes]` package and format them to be consistent with the
#' many packages universe for creating maps.
#' @param date The date for which the distance list should be computed.
#' This argument must be a single date (ymd) from 1/1/1886 onwards.
#' @param type Specifies the type of distance list:
#' "capdist" for capital distances,
#' "centdist" for centroid distances,
#' and "mindist" for minimum distances.
#' @param ... Arguments to be passed to `[cshapes]` functions.
#' See the `[cshapes]` documentation for more details
#' @name extract_cshapes
NULL

#' @name extract_cshapes
#' @details `import_cshapes()`imports CShapes 2.0 datasets
#' and formats them to be consistent with the many packages universe.
#' @importFrom tibble as_tibble
#' @importFrom manypkgs standardise_titles standardise_dates
#' @import dplyr
#' @import lubridate
#' @importFrom cshapes cshp
#' @importFrom rlang .data
#' @return A dataframe with the `[cshapes]` dataset in a format consistent
#' with the many packages universe.
#' @examples
#' \donttest{
#' import_cshapes(date = "1900-01-01")
#' }
#' @export
import_cshapes <- function(date, ...) {
  # Step 1: Set string dates to actual dates
  date <- as.Date(date)
  # Test for correct dates
  if (!(as.numeric(format(date, format = "%Y")) >= 1886 & 
        as.numeric(format(date, format = "%Y")) <= 2021)) {
    stop("Please input a date in the following range: 1886-01-01 -
         end of the dataset")
  }
  # Step 2: Importing
  cshapes <- cshapes::cshp(date, ..., useGW = FALSE) # Use cowID instead of GW
  # Step 3: Correcting data
  cshapes <- tibble::as_tibble(cshapes) %>%
    dplyr::mutate(Beg = messydates::make_messydate(.data$start),
                End = messydates::make_messydate(.data$end),
                Label = manypkgs::standardise_titles(.data$country_name),
                cowID = manystates::code_states(
                  as.character(.data$country_name), abbrev = TRUE),
                Capital = manypkgs::standardise_titles(.data$capname),
                CapitalLong = .data$caplong,
                CapitalLat = .data$caplat,
                WellDefinedBorders = .data$b_def,
                Status = dplyr::if_else(.data$status == "independent", 1, 0),
                # All are independent states.
                # Check where the colonies are.
                Owner = .data$owner) %>%
    dplyr::select(-(.data$start), -(.data$end), -(.data$country_name),
                  -(.data$cowcode), -(.data$capname), -(.data$caplong),
                  -(.data$caplat), -(.data$b_def), -(.data$status),
                  -(.data$owner), -(.data$fid)) %>%
    dplyr::relocate(.data$cowID, .data$Beg, .data$End, .data$Label) %>%
    dplyr::arrange(.data$Beg, .data$cowID)
  return(cshapes)
}

#' @name extract_cshapes
#' @details `import_distlist()` imports pre-computed minimum
#' distance dataframe from the `[cShapes]` package.
#' Minimum distances are computed in three ways:
#' distances between capitals,
#' distances between centroids of the polygons,
#' minimum distances between the polygons in kilometers.
#' @importFrom tibble as_tibble
#' @importFrom countrycode countrycode
#' @import dplyr
#' @import lubridate
#' @importFrom cshapes distlist
#' @importFrom rlang .data
#' @return A dataframe with the desired distance list between polygons,
#' capitals, or polygon centroids in kilometers.
#' @examples
#' \donttest{
#' import_distlist(date = "1900-01-01", type = "capdist")
#' }
#' @export
import_distlist <- function(date, type, ...) {
  # Step 1: Change date in string format to date format
  date <- as.Date(date)
  # Check whether inputs are in range of permitted values for dates and type.
  if (!(type %in% c("capdist", "mindist", "centdist"))) {
    stop("Please input a type among the following: centdist, capdist or
         mindist")
  }
  `%within%` <- lubridate::`%within%` #Not very elegant but does the job
  if (!(date %within% lubridate::interval(lubridate::ymd("1886-01-01"),
                                       lubridate::ymd(Sys.Date())))) {
    stop("Please input a date in the following range: 1886-01-01 -
         end of the dataset")
  }
  # Step 2: Disambiguate certain countrycode pairs such as 730 - Korea by
  # creating a custom dictionary.
  custom_match <- c(`730` = "Korea")
  # Step 3: Import data from cshapes
  dist <- cshapes::distlist(date, type, ..., useGW = FALSE)
  # Step 4: Process dist to make it consistent with the many packages universe
  if (type == "capdist") {
    dist <- tibble::as_tibble(dist) %>%
      dplyr::mutate(FromLabel =
                      countrycode::countrycode(sourcevar = .data$ccode1,
                                               origin = "cown",
                                               destination = "country.name",
                                               custom_match = custom_match),
                    ToLabel =
                      countrycode::countrycode(sourcevar = .data$ccode2,
                                               origin = "cown",
                                               destination = "country.name",
                                               custom_match = custom_match)) %>%
      dplyr::rename(FromCode = .data$ccode1, ToCode = .data$ccode2,
                    Distance = .data$capdist) %>%
      dplyr::mutate(FromCode = manystates::code_states(.data$FromLabel,
                                                       abbrev = TRUE),
                    ToCode = manystates::code_states(.data$ToLabel,
                                                     abbrev = TRUE)) %>%
      dplyr::relocate(.data$FromLabel, .data$FromCode, .data$ToLabel,
                      .data$ToCode, .data$Distance)
  } else if (type == "mindist") {
    dist <- tibble::as_tibble(dist) %>%
      dplyr::mutate(FromLabel =
                      countrycode::countrycode(sourcevar = .data$ccode1,
                                               origin = "cown",
                                               destination = "country.name",
                                               custom_match = custom_match),
                    ToLabel =
                      countrycode::countrycode(sourcevar = .data$ccode2,
                                               origin = "cown",
                                               destination = "country.name",
                                               custom_match = custom_match)) %>%
      dplyr::rename(FromCode = .data$ccode1, ToCode = .data$ccode2,
                    Distance = .data$mindist) %>%
      dplyr::mutate(FromCode = manystates::code_states(.data$FromLabel,
                                                       abbrev = TRUE),
                    ToCode = manystates::code_states(.data$ToLabel,
                                                     abbrev = TRUE)) %>%
      dplyr::relocate(.data$FromLabel, .data$FromCode, .data$ToLabel,
                      .data$ToCode, .data$Distance)
  } else {
    dist <- tibble::as_tibble(dist) %>%
      dplyr::mutate(FromLabel =
                      countrycode::countrycode(sourcevar = .data$ccode1,
                                               origin = "cown",
                                               destination = "country.name",
                                               custom_match = custom_match),
                    ToLabel =
                      countrycode::countrycode(sourcevar = .data$ccode2,
                                               origin = "cown",
                                               destination = "country.name",
                                               custom_match = custom_match)) %>%
      dplyr::rename(FromCode = .data$ccode1, ToCode = .data$ccode2,
                    Distance = .data$centdist) %>%
      dplyr::mutate(FromCode = manystates::code_states(.data$FromLabel,
                                                       abbrev = TRUE),
                    ToCode = manystates::code_states(.data$ToLabel,
                                                     abbrev = TRUE)) %>%
      dplyr::relocate(.data$FromLabel, .data$FromCode, .data$ToLabel,
                      .data$ToCode, .data$Distance)
  }
  return(dist)
}

#' @name extract_cshapes
#' @details `import_distmatrix()` imports and formats pre-computed
#' minimum distance matrix from the `[cShapes]` package.
#' Minimum distances are computed in three ways:
#' distances between capitals,
#' distances between centroids of the polygons,
#' minimum distances between the polygons in kilometers.
#' @import lubridate
#' @importFrom cshapes distmatrix
#' @return A matrix with the desired distance list between polygons,
#' capitals, or polygon centroids in kilometers.
#' @examples
#' \donttest{
#' import_distmatrix(date = "1900-01-01", type = "capdist")
#' }
#' @export
import_distmatrix <- function(date, type, ...) {
  # Step 1: Change date in string format to date format
  date <- as.Date(date)
  # Check whether inputs are in range of permitted values for dates and type.
  if (!(type %in% c("capdist", "mindist", "centdist"))) {
    stop("Please input a type among the following: centdist, capdist or
         mindist")
  }
  `%within%` <- lubridate::`%within%` #Not very elegant but does the job
  if (!(date %within% lubridate::interval(lubridate::ymd("1886-01-01"),
                                         lubridate::ymd(Sys.Date())))) {
    stop("Please input a date in the following range: 1886-01-01 -
         end of the dataset")
  }
  # Step 2:
  dist <- cshapes::distmatrix(date, type, ..., useGW = FALSE)
  # Step 3: No Processing required as this is a simple distance matrix.
  return(dist)
}
