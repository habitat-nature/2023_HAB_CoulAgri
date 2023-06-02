################################################################################
##
## Prep data for interactive CartoDB map
################################################################################
#date: 2023-06-02
#author: Kyle T. Martins & Noemie Lacroix-D. 

#Objective: compile data for data package for the ECCC project

####LOAD LIBRARIES####
library(sf)
library(tidyr)
library(dplyr)
library(plyr)


####DEFINE PATHS####
pathDataECCC <- paste0("G:/Shared drives/Projets/Actif/2022_ECCC_CoulAgri_003/",
                     "3-Analyses/1-Data/")
pathDataJDLT <- paste0("G:/Shared drives/Projets/Actif/2022_JDT_DemForet/",
                     "3-Analyses/1-Data/")
pathOutput <- paste0("G:/My Drive/Github/2020_ECCC_CoulAgri_002/")

pathDataECCC_ph2 <- paste0("G:/Shared drives/Archive/ECCC/2020_ECCC_CoulAgri_002/",
                         "3-Analysis/1-Data/1-GeospatialData/")


####LOAD THE DATA####
#CAG for the BTSL East
btsl_east <- st_read(paste0(pathDataJDLT, "CouleesAgricoles/ALL_btsl/cagFinal_inBTSL.shp"),
                     quiet = T)

#CAG for the BTSL West
btsl_west <- st_read(paste0(pathDataECCC, "CouleesAgricoles/coulees_agricoles.shp"),
                     quiet = T)

# Prioritization results
prio_west <- st_read(paste0(pathDataECCC, "Priorities/prio_bois.shp"))


####DATA PROCESSING####
## 1. Check which column names are not in the other
names(btsl_west)[!names(btsl_west) %in% names(btsl_east)]
names(btsl_east)[!names(btsl_east) %in% names(btsl_west)]


## 2. Merge together
# Coulees agricoles
btsl_combined <- rbind.fill(btsl_east, btsl_west)
names(btsl_combined)

# admin region
admin_combine <- rbind(admin_east, admin_west)

# mrc
mrc_combine <- rbind(mrc_east, mrc_west)


## 3. Reformat
btsl_combined <- btsl_combined %>%
  select(ID, pasl_id, super_m2, super_ha, lwVg_m2 = veg_bas_m2, lwVg_ha = veg_bas_ha, lwVg_prop = veg_bas_p,
         selct_prio, priorite, pnte_mn_p, pnte_mn_d, argile_myn = argile_mn, limon_myn = limon_mn,
         sable_myn = sable_mn, ph_myn = ph_mn, cec_myn = cec_mn, geometry)

prio_west <- prio_west %>%
  mutate(prio_p = priorite * 100) %>%
  select(ID, prio_p, dist_eau_m)


####EXPORT DATA####
st_write(btsl_combined,
         paste0(pathOutput, "coulees_agricoles_2023.shp"),
         quiet = TRUE,
         delete_layer = TRUE)

st_write(prio_west,
         paste0(pathOutput, "prio_west_2023.shp"),
         delete_layer = TRUE)

#End of script#
