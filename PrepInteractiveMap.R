################################################################################
##
## Prep data for interactive CartoDB map
################################################################################
#date: 20230310
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
pathOutput <- paste0("G:/My Drive/Github/2023_HAB_CagPrio/")


####LOAD THE DATA####
# Coulees agricoles delimitations
cag_east <- st_read(paste0(pathDataJDLT, "CouleesAgricoles/BTSL_East/cagFinal_inBTSL.shp"),
                     quiet = T)
cag_west <- st_read(paste0(pathDataECCC, "CouleesAgricoles/cagFinal.shp"),
                     quiet = T)

#Soil data 
soil_west <- read.csv(paste0(pathDataECCC, "Soils/cag_ProprietesSol.csv"))
soil_east <- read.csv()

# Prioritization results 
prio_west <- st_read(paste0(pathDataECCC, "Priorities/prio_output.shp"))
feat_west <- st_read(pathDataECCC, "Priorities/cag_featuresRaw.shp")
prio_east <- st_read(pathDataECCC_ph2, "Priorities/sol_prob.shp")

#Administrative regions for the BTSL West and East
admin_east <- st_read(paste0(pathDataECCC_ph2, "AdminRegion/admin_reg.shp"),
                      quiet = T)
admin_west <- st_read(paste0(pathDataECCC, "AdminRegion/admin_reg.shp"),
                      quiet = T)

#MRC
mrc_east <- st_read(paste0(pathDataECCC_ph2, "AdminRegion/admin_mrc.shp"),
                      quiet = T)
mrc_west <- st_read(paste0(pathDataECCC, "AdminRegion/admin_mrc.shp"),
                      quiet = T)


####DATA PROCESSING####
## 1. 
## 1. Check which column names are not in the other
names(btsl_west)[!names(btsl_west) %in% names(btsl_east)]
names(btsl_east)[!names(btsl_east) %in% names(btsl_west)]


## 2. Add soil data to west coulees
summary(soil$ID %in% btsl_west$ID) # should all be true
btsl_west <- btsl_west %>%
  left_join(soil %>% data.frame %>% select(-geometry)) 

## 3. Merge together
# Coulees agricoles
btsl_combined <- rbind.fill(btsl_east, btsl_west)
names(btsl_combined)

# admin region
admin_combine <- rbind(admin_east, admin_west)

# mrc 
mrc_combine <- rbind(mrc_east, mrc_west)


## 4. Reformat a little
# Chande ID because some ID are present in east btsl cag and west btsl cag
btsl_combined$ID <- 1:nrow(btsl_combined)


####EXPORT DATA####
st_write(btsl_combined, 
         paste0(pathOutput, "coulees_agricoles_2023.shp"), 
         quiet = TRUE,
         delete_layer = TRUE)

st_write(admin_combine,
         paste0(pathOutput, "admin_region_btsl.shp"), 
         quiet = TRUE,
         delete_layer = TRUE)

st_write(mrc_combine,
         paste0(pathOutput, "mrc_btsl.shp"), 
         quiet = TRUE,
         delete_layer = TRUE)

#End of script#