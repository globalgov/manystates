# states$GGO Preparation Script

# Stage one: Collecting data
GGO <- read.csv("data-raw/states/GGO/huggo_states_clean.csv",
                  na.strings = c("", "NA"))

# Stage two: Cleaning data
GGO <- dplyr::as_tibble(GGO) %>%
  dplyr::mutate(Begin = messydates::as_messydate(Begin),
                End = messydates::as_messydate(End),
                DecIndep = messydates::as_messydate(DecIndep),
                Autonomy = messydates::as_messydate(Autonomy)
                ) %>%
  dplyr::select(-c(Basis,DecIndep,Autonomy,Constitution,Grounds,RatProcedure)) %>%
  dplyr::arrange(Begin)

# Stage three: Connecting data
manypkgs::export_data(GGO, datacube = "states",
                      URL = "www.panarchic.ch")
