#' Extract CShapes data and matrix
#' 
#' Functions to import CShapes 2.0 datasets, distances and
#' formats them to a qVerse consistent output from the `[cShapes]` package.
#' @param date The date for which the distance list should be computed.
#' This argument must be of type Date and must be in the range 1/1/1886 -
#' end of the dataset.
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
#' @return A dataframe with the qVerse-consistently formatted `[cshapes]`
#' dataset.
#' @examples
#' \donttest{
#' import_cshapes(date = "1900-01-01")
#' }
#' @export
import_cshapes <- function(date, ...) {
  # Initializing variables to avoid an annoying Note when checking the package.
  start <- end <- country_name <- cowcode <- capname <- caplong <- NULL
  caplat <- b_def <- status <- owner <- fid <- COW_Nr <- Beg <- End <- NULL
  Label <- NULL
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
    qData::transmutate(Beg = qCreate::standardise_dates(start),
                End = qCreate::standardise_dates(end),
                Label = qCreate::standardise_titles(country_name),
                COW_Nr = qCreate::standardise_titles(as.character(cowcode)),
                Capital = qCreate::standardise_titles(capname),
                CapitalLong = caplong,
                CapitalLat = caplat,
                WellDefinedBorders = b_def,
                Status = dplyr::if_else(status == "independent", 1, 0),
                # All are independent states.
                # Check where the colonies are.
                Owner = owner
    ) %>%
    dplyr::select(-(fid)) %>%
    dplyr::relocate(COW_Nr, Beg, End, Label) %>%
    dplyr::arrange(Beg, COW_Nr)
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
#' @return A dataframe with the desired distance list between polygons,
#' capitals, or polygon centroids in kilometers.
#' @examples
#' \donttest{
#' import_distlist(date = "1900-01-01", type = "capdist")
#' }
#' @export
import_distlist <- function(date, type, ...) {
  #Initialize variables:
  ccode1 <- ccode2 <- capdist <- FromLabel <- FromCode <- ToCode <- NULL
  ToLabel <- distance <- distance <- centdist <- mindist <- NULL
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
      dplyr::mutate(FromLabel = countrycode::countrycode(sourcevar = ccode1,
                                                         origin = "cown",
                                                         destination = "country.name", custom_match = custom_match),
                    ToLabel = countrycode::countrycode(sourcevar = ccode2,
                                                       origin = "cown",
                                                       destination = "country.name", custom_match = custom_match)) %>%
      dplyr::rename(FromCode = ccode1, ToCode = ccode2, Distance = capdist) %>%
      dplyr::relocate(FromLabel, FromCode, ToLabel, ToCode, distance)
  } else if (type == "mindist") {
    dist <- tibble::as_tibble(dist) %>%
      dplyr::mutate(FromLabel = countrycode::countrycode(sourcevar = ccode1,
                                                         origin = "cown",
                                                         destination = "country.name", custom_match = custom_match),
                    ToLabel = countrycode::countrycode(sourcevar = ccode2,
                                                       origin = "cown",
                                                       destination = "country.name", custom_match = custom_match)) %>%
      dplyr::rename(FromCode = ccode1, ToCode = ccode2, Distance = mindist) %>%
      dplyr::relocate(FromLabel, FromCode, ToLabel, ToCode, distance)
  } else {
    dist <- tibble::as_tibble(dist) %>%
      dplyr::mutate(FromLabel = countrycode::countrycode(sourcevar = ccode1,
                                                         origin = "cown",
                                                         destination = "country.name", custom_match = custom_match),
                    ToLabel = countrycode::countrycode(sourcevar = ccode2,
                                                       origin = "cown",
                                                       destination = "country.name", custom_match = custom_match)) %>%
      dplyr::rename(FromCode = ccode1, ToCode = ccode2, Distance = centdist) %>%
      dplyr::relocate(FromLabel, FromCode, ToLabel, ToCode, distance)
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
