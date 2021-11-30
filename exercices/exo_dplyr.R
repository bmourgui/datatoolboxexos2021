############################################%
# Formation CESAB, Reproducitbilite
# 29/11/21
#
# eco_dplyr.R
#
# Script pour l'exo dplyr
# Faire un hist du nb de mams par ecoregions
############################################%

# load sp-eco data

dat <- read_eco_sp()

mam_per_eco <- table(dat$ecoregion_id)

png(filename = here::here("outputs", "exo_dplyr_hist_mams.png"))
hist(mam_per_eco,
     breaks = 40,
     xlab = "Nombre d'epeces de mammiferes",
     ylab = "Nombre d'ecoregions",
     col = "red")
dev.off()


# Exo 2
data_eco_sp <- read_eco_sp()
data_eco_list <- read_eco_list()
data_sp_list <- read_sp_list()

data_eco_sp %>%
  dplyr::inner_join(data_eco_list) %>%
  dplyr::inner_join(data_sp_list) -> data

data %>%
  dplyr::filter(family == "Ursidae", sci_name != "Ursinus malayanus") %>%
  dplyr::select(ecoregion, realm, biome, sci_name) -> data_urs

data_urs %>%
  dplyr::count(ecoregion, sci_name) %>%
  dplyr::group_by(sci_name) %>%
  dplyr::summarise(n_ecoregion = dplyr::n_distinct(ecoregion)) -> data_n_ecor

data_urs %>%
  dplyr::count(biome, sci_name) %>%
  dplyr::group_by(sci_name) %>%
  dplyr::summarise(n_biome = dplyr::n_distinct(biome)) -> data_n_biome

data_urs %>%
  dplyr::count(realm, sci_name) %>%
  dplyr::group_by(sci_name) %>%
  dplyr::summarise(n_realm = dplyr::n_distinct(realm)) -> data_n_realm

data_n_realm %>%
  dplyr::left_join(data_n_biome) %>%
  dplyr::left_join(data_n_ecor)

# Exo 3 : ggplot2
pantheria <- readr::read_delim("data/pantheria-traits/PanTHERIA_1-0_WR05_Aug2008.txt", delim = "\t")

pantheria %>%
  dplyr::mutate_at(c("MSW05_Order", "MSW05_Family"),
                   forcats::as_factor) %>%
  dplyr::rename(family = "MSW05_Family",
                order = "MSW05_Order",
                mass = "5-1_AdultBodyMass_g",
                dispersal = "7-1_DispersalAge_d",
                gestation = "9-1_GestationLen_d",
                range = "22-2_HomeRange_Indiv_km2",
                litters = "16-1_LittersPerYear",
                longevity = "17-1_MaxLongevity_m") %>%
  dplyr::select(family, order, longevity, range, litters) %>%
  dplyr::mutate_all(function(x)dplyr::na_if(x, -999)) -> data

data %>%
  dplyr::count(family)

data %>%
  dplyr::count(order)

data %>%
  dplyr::group_by(family) %>%
  dplyr::summarise(avg_range = mean(range, na.rm = TRUE),
                   sd_range = sd(range, na.rm = TRUE),
                   size_sample = dplyr::n())

# Plot 1
data %>%
  dplyr::group_by(family) %>%
  dplyr::count()
  dplyr::filter(n > 100) %>%
  ggplot2::ggplot() +
  ggplot2::aes(x = n, y = forcats::fct_reorder(family, n)) +
  ggplot2::geom_col() + # same as geom_bar() when counts are already made
  ggplot2::xlab("Counts") +
  ggplot2::ylab("Family") +
  ggplot2::ggtitle("Number of entries per family") +
  ggplot2::theme_bw()

# Plot 2
data %>%
  dplyr::filter(!is.na(litters)) %>%
  dplyr::filter(!is.na(longevity)) %>%
  dplyr::group_by(family) %>%
  dplyr::mutate(n = dplyr::n()) %>%
  dplyr::filter(n > 20) %>%
  dplyr::right_join(sub_data) %>%
  dplyr::mutate(family2 = forcats::fct_drop(family)) %>%
  ggplot2::ggplot() +
  ggplot2::aes(y = litters, x = longevity, color = family) +
  ggplot2::geom_point() +
  ggplot2::geom_smooth(method = "lm") +
  ggplot2::facet_wrap(~ family, nrow = 2) +
  ggplot2::xlab("Litter size") +
  ggplot2::ylab("Longevity") +
  ggplot2::ggtitle("Relationship between longevity and litter size")
