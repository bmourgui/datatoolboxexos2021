#################################################################%
# Formation CESAB, Reproducitbilite
# 29/11/21
#
# make.R
#
# Script pour l'execution du projet entier (automatisation)
#################################################################%


# install dependences (packages used)
devtools::install_deps()

# load functions
# devtools::load_all() # but does not work with package 'targets'
source(here::here("R", "data_wildfinder.R"))

# run exodplyr
source(here::here("exercices", "exo_dplyr.R"))
