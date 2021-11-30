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

