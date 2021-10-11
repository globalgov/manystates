#' Extract CShapes data and matrix
#'
#' Functions to import CShapes 2.0 datasets and distances from
#' the `[cShapes]` package and format them to a qVerse
#' consistent output for creating maps.
#' @param date The date for which the distance list should be computed.
#' This argument must be a single date (ymd) from 1/1/1886 onwards.
#' @param type Specifies the type of distance list: "capdist" for capital
#' distances, "centdist" for centroid distances, and "mindist" for minimum
#' distances.
#' @param ... Arguments to be passed to `[cshapes]` functions.
#' See the `[cshapes]` documentation for more details
#' @name extract_cshapes
NULL

#' @name extract_cshapes
#' @details `import_cshapes()`imports CShapes 2.0 datasets
#' and formats them to a qVerse consistent output.
#' @importFrom cshapes cshp
#' @importFrom tibble as_tibble
#' @importFrom qData transmutate
#' @importFrom qCreate standardise_titles standardise_dates
#' @import dplyr
#' @import lubridate
#' @importFrom rlang .data
#' @return A dataframe with the `[cshapes]` dataset in a qVerse-consistent
#' format.
#' @examples
#' \donttest{
#' import_cshapes(date = "1900-01-01")
#' }
#' @export
import_cshapes <- function(date, ...) {
  # Step 0: Set string dates to actual dates
  date <- as.Date(date)
  # Test for correct dates
  `%within%` <- lubridate::`%within%` #Not very elegant but does the job
  if (!(date %within% lubridate::interval(lubridate::ymd("1886-01-01"),
                                       lubridate::ymd(Sys.Date())))) {
    stop("Please input a date in the following range: 1886-01-01 -
         end of the dataset")
  }
  # Stage 1: Importing
  cshapes <- cshapes::cshp(date, ..., useGW = FALSE) # Use COW_ID instead of GW
  # Stage two: Correcting data
  cshapes <- tibble::as_tibble(cshapes) %>%
    qData::transmutate(Beg = qCreate::standardise_dates(.data$start),
                End = qCreate::standardise_dates(.data$end),
                Label = qCreate::standardise_titles(.data$country_name),
                COW_Nr = qCreate::standardise_titles(
                  as.character(.data$cowcode)),
                Capital = qCreate::standardise_titles(.data$capname),
                CapitalLong = .data$caplong,
                CapitalLat = .data$caplat,
                WellDefinedBorders = .data$b_def,
                Status = dplyr::if_else(.data$status == "independent", 1, 0),
                # All are independent states.
                # Check where the colonies are.
                Owner = .data$owner) %>%
    dplyr::select(- (.data$fid)) %>%
    dplyr::relocate(.data$COW_Nr, .data$Beg, .data$End, .data$Label) %>%
    dplyr::arrange(.data$Beg, .data$COW_Nr)
  return(cshapes)
}

#' @name extract_cshapes
#' @details `import_distlist()` imports pre-computed minimum
#' distance dataframe from the `[cShapes]` package.
#' Minimum distances are computed in three ways:
#' distances between capitals,
#' distances between centroids of the polygons,
#' minimum distances between the polygons in kilometers.
#' @importFrom cshapes distlist
#' @importFrom tibble as_tibble
#' @importFrom countrycode countrycode
#' @import dplyr
#' @import lubridate
#' @importFrom rlang .data
#' @return A dataframe with the desired distance list between polygons,
#' capitals, or polygon centroids in kilometers.
#' @examples
#' \donttest{
#' import_distlist(date = "1900-01-01", type = "capdist")
#' }
#' @export
import_distlist <- function(date, type, ...) {
  # Step 0: Change date in string format to date format
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
  # Step 0.5 Disambiguate certain countrycode pairs such as 730 - Korea by
  # creating a custom dictionary.
  custom_match <- c(`730` = "Korea")
  # Step 1: Import data from cshapes
  dist <- cshapes::distlist(date, type, ..., useGW = FALSE)
  #Step 3: Process dist to make it qConsistent
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
      dplyr::relocate(.data$FromLabel, .data$FromCode, .data$ToLabel,
                      .data$ToCode, .data$Distance)
  }
  return(dist)
}

#' @name extract_cshapes
#' @details `import_distlist()` imports and formats pre-computed
#' minimum distance matrix from the `[cShapes]` package.
#' Minimum distances are computed in three ways:
#' distances between capitals,
#' distances between centroids of the polygons,
#' minimum distances between the polygons in kilometers.
#' @importFrom cshapes distmatrix
#' @import lubridate
#' @return A matrix with the desired distance list between polygons,
#' capitals, or polygon centroids in kilometers.
#' @examples
#' \donttest{
#' import_distmatrix(date = "1900-01-01", type = "capdist")
#' }
#' @export
import_distmatrix <- function(date, type, ...) {
  # Step 0: Change date in string format to date format
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
  # Step 1:
  dist <- cshapes::distmatrix(date, type, ..., useGW = FALSE)
  #Step 3: No Processing required as this is a simple distance matrix.
  return(dist)
}
