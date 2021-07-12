#' Import and format `[cshapes]` datasets
#' 
#' Imports CShapes 2.0 datasets and formats them to a qVerse
#' consistent output.
#' @param date The date for which the distance list should be computed.
#' This argument must be of type Date and must be in the range 1/1/1886 -
#' end of the dataset.
#' @param ... Arguments to be passed to `[cshapes]`
#' functions. See the `[cshapes]` documentation for more details
#' @importFrom cshapes cshp
#' @return A dataframe with the qVerse-consistently formatted `[cshapes]`
#' dataset.
#' @examples
#' \dontrun{
#' import_cshapes(date = "1900-01-01")
#' }
#' @export

import_cshapes <- function(date, ...){
  # Step 0: Set string dates to actual dates
  date <- as.Date(date)
  # Stage 1: Importing
  cshapes <- cshapes::cshp(date, ..., useGW = FALSE) # Use COW_ID instead of GW
  # Stage two: Correcting data
  cshapes <-as_tibble(cshapes) %>%
    qData::transmutate(Beg = qCreate::standardise_dates(start),
                End = qCreate::standardise_dates(end),
                Label = qCreate::standardise_titles(country_name),
                COW_Nr = qCreate::standardise_titles(as.character(cowcode)),
                Capital = qCreate::standardise_titles(capname),
                CapitalLong = caplong,
                CapitalLat = caplat,
                WellDefinedBorders = b_def,
                Status = dplyr::if_else(status == "independent", 1, 0), # All are independent states. 
                #Check where the colonies are.
                Owner = owner
    ) %>%
    dplyr::select(-(fid)) %>%
    dplyr::relocate(COW_Nr, Beg, End, Label) %>%
    dplyr::arrange(Beg, COW_Nr)
  return(cshapes)
}

#' Imports `[cshapes]` pre-computed distance matrices.
#' 
#' `import_distlist()` imports a pre-computed minimum distance dataframe
#' from the `[cShapes]` package. Minimum distances are computed in three ways:
#' distances between capitals, distances between centroids of the polygons,
#' minimum distances between the polygons in kilometers.
#' @param date The date for which the distance list should be computed.
#' This argument must be of type Date and must be in the range 1/1/1886 -
#' end of the dataset.
#' @param type Specifies the type of distance list: "capdist" for capital
#' distances, "centdist" for centroid distances, and "mindist" for minimum
#' distances.
#' @param ... Arguments to be passed to `[cshapes]`
#' @importFrom cshapes distlist
#' @return A dataframe with the desired distance list between polygons,
#' capitals, or polygon centroids in kilometers.
#' @examples
#' \dontrun{
#' import_distlist(date = "1900-01-01", type = "capdist")
#' }
#' @export

import_distlist <- function(date, type, ...){
  # Step 0: Change date in string format to date format
  date <- as.Date(date)
  # Step 1:
  dist <- cshapes::distlist(date, type, ..., useGW = FALSE)
  #Step 3: Process dist to make it qConsistent
  dist <- as.tibble(dist)%>%
    transmutate(FromLabel = countrycode::countrycode(sourcevar = ccode1,
                                                  origin = "cown",
                                                  destination = "country.name"),
                ToName = countrycode::countrycode(sourcevar = ccode2,
                                                  origin = "cown",
                                                  destination = "country.name"))%>%
    dplyr::rename(FromCode = ccode1, ToCode = ccode2, distance = capdist)%>%
    dplyr::relocate(FromLabel, FromCode, ToName, ToCode, distance)
  return(dist)
}

#' Imports and formats `[cshapes]` pre-computed distance matrices.
#' 
#' `import_distlist()` imports a pre-computed minimum distance matrix
#' from the `[cShapes]` package. Minimum distances are computed in three ways:
#' distances between capitals, distances between centroids of the polygons,
#' minimum distances between the polygons in kilometers.
#' @param date The date for which the distance list should be computed.
#' This argument must be of type Date and must be in the range 1/1/1886 -
#' end of the dataset.
#' @param type Specifies the type of distance list: "capdist" for capital
#' distances, "centdist" for centroid distances, and "mindist" for minimum
#' distances.
#' @param ... Arguments to be passed to `[cshapes]`
#' @importFrom cshapes distlist
#' @return A matrix with the desired distance list between polygons,
#' capitals, or polygon centroids in kilometers.
#' @examples
#' \dontrun{
#' import_distmatrix(date = "1900-01-01", type = "capdist")
#' }
#' @export

import_distmatrix <- function(date, type, ...){
  # Step 0: Change date in string format to date format
  date <- as.Date(date)
  # Step 1:
  dist <- cshapes::distmatrix(date, type, ..., useGW = FALSE)
  #Step 3: No Processing required as this is a simple distance matrix.
  return(dist)
}
