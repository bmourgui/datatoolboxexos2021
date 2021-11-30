#' Import WWF Species Data
#'
#' @return A tibble containing species ID & taxonomy
#' @export
#'
read_sp_list <- function() {

  readr::read_csv(
    here::here("data", "wwf-wildfinder", "wildfinder-mammals_list.csv")
    # here::here("data/wwf-wildfinder/wildfinder-mammals_list.csv") # also works
  )

}

#' Import WWF Ecoregions Data
#'
#' @return A tibble containing ecoregions ID & taxonomy
#' @export
#
read_eco_list <- function() {

  readr::read_csv(
    here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_list.csv")
  )

}


#' Import WWF Species x Ecoregions Data
#'
#' @return A tiblle liking species IDs to ecoregions IDs
#' @export
#
read_eco_sp <- function() {

  readr::read_csv(
    here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_species.csv")
  )

}

