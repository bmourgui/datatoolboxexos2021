#####################################%
# Formation CESAB, Reproducitbilite
# 29/11/21
#
# eco_dplyr.R
#
# Script pour l'exo dplyr
# Faire un hist du nb de mams par ecoregions
#####################################%


# load sp-eco data

dat <- read_eco_sp()

mam_per_eco <- table(dat$ecoregion_id)

png(filename = here::here("outputs", "exo_dplyr_hist_mams.png"))
hist(mam_per_eco,
     breaks = 50,
     xlab = "Nombre de mammiferes",
     ylab = "Nombre d'ecoregions",
     col = "red")
dev.off()
