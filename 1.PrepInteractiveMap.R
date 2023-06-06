################################################################################
## 01
## Prep data for interactive CartoDB map
################################################################################
#date: 20230310
#author: Kyle T. Martins & Noemie Lacroix-D. 

# Objective: compile data for the coulees agricole interactive map on the 
# website

####LOAD LIBRARIES####
library(sf)
library(tidyr)
library(dplyr)
library(plyr)


####DEFINE PATHS####
pathAdminReg <- "G:/Shared drives/Database/AdminRegion/QC/"
pathDataECCC <- paste0("G:/Shared drives/Archive Projets/ECCC/2022_ECCC_CoulAgri_003/3-Analyses/1-Data/")
pathDataJDLT <- paste0("G:/Shared drives/Projets/Actif/2022_JDT_DemForet/3-Analyses/1-Data/")
pathOutput <- paste0("G:/My Drive/Github/2023_HAB_CoulAgri/")


####LOAD THE DATA####
# Study region
btsl_delim <- st_read(paste0(pathDataJDLT, "StudyRegion/BTSL_All.shp"))
sag_delim <- st_read(paste0(pathDataJDLT, "StudyRegion/delim_SAG.shp"))

# Coulees agricoles delimitations
cag_east <- st_read(paste0(pathDataJDLT, "CouleesAgricoles/BTSL_East/coulees_agricoles.shp"))
cag_west <- st_read(paste0(pathDataECCC, "CouleesAgricoles/coulees_agricoles.shp"))
cag_sag <- st_read(paste0(pathDataJDLT, "CouleesAgricoles/Saguenay/coulees_agricoles.shp"))

# Prioritization results 
prio_west <- st_read(paste0(pathDataECCC, "Priorities/prio_bois.shp"))
prio_east <- st_read(paste0(pathDataJDLT, "Priorities/BTSL_East/prio_bois.shp"))
prio_sag <- st_read(paste0(pathDataJDLT, "Priorities/Saguenay/prio_bois.shp"))

#Administrative regions for the BTSL West and East
admin_reg <- st_read(paste0(pathAdminReg, "reg_admin/regio_s.shp"))

#MRC
mrc <- st_read(paste0(pathAdminReg, "mrc/mrc_s.shp"))


####DATA PROCESSING####
## 1. Check crs of different layers
st_crs(btsl_delim) == st_crs(sag_delim)
st_crs(btsl_delim) == st_crs(cag_east)
st_crs(btsl_delim) == st_crs(cag_west)
st_crs(btsl_delim) == st_crs(cag_sag)
st_crs(btsl_delim) == st_crs(prio_west)
st_crs(btsl_delim) == st_crs(prio_east)
st_crs(btsl_delim) == st_crs(prio_sag)
st_crs(btsl_delim) == st_crs(admin_reg)
st_crs(btsl_delim) == st_crs(mrc)

admin_reg <- st_transform(admin_reg, crs = crs(btsl_delim))
mrc <- st_transform(mrc, crs = crs(btsl_delim))

## 2. Transform ID because some are duplicated
cag_east$ID <- paste0("01", cag_east$ID)
prio_east$ID <- paste0("01", prio_east$ID)
cag_west$ID <- paste0("02", cag_west$ID)
prio_west$ID <- paste0("02", prio_west$ID)
cag_sag$ID <- paste0("03", cag_sag$ID)
prio_sag$ID <- paste0("03", prio_sag$ID)

## 3. Merge layers together
# Coulees agricoles
cag_shp <- rbind(cag_east[, c("ID")], cag_west[, c("ID")], cag_sag[, c("ID")])
cag_df <- rbind.fill(cag_east, cag_west, cag_sag)
cag_combined <- cag_shp %>% 
  left_join(cag_df, by = "ID") %>%
  mutate(priorite = priorite * 100)

head(cag_combined)
unique(cag_combined$ID) %>% length ; nrow(cag_combined)
class(cag_combined)

# Priorities
prio_shp <- rbind(prio_east[, c("ID")], prio_west[, c("ID")], prio_sag[, c("ID")])
prio_df <- rbind.fill(prio_east, prio_west, prio_sag)
prio_combined <- prio_shp %>% 
  left_join(prio_df, by = "ID") %>%
  mutate(priorite = priorite * 100)

head(prio_combined)
unique(prio_combined$ID) %>% length ; nrow(prio_combined)
class(prio_combined)

## 4. Extract admin region and mrc 
# Admin region
admin_btsl <- admin_reg %>%
  st_intersection(btsl_delim) %>%
  dplyr::select(RES_NM_REG, RES_CO_REG)

admin_sag <- admin_reg %>%
  filter(RES_NM_REG == "Saguenay - Lac-Saint-Jean") %>%
  dplyr::select(RES_NM_REG, RES_CO_REG)

admin_combined <- rbind(admin_btsl, admin_sag)
  
# MRC
mrc_combined <- mrc %>%
  st_intersection(admin_combined[, c("geometry")]) %>%
  dplyr::select(MRS_NM_MRC, MRS_CO_MRC) %>%
  st_collection_extract("POLYGON")


####EXPORT DATA####
st_write(cag_combined, 
         paste0(pathOutput, "CoulAgri_coulees.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

st_write(prio_combined, 
         paste0(pathOutput, "CoulAgri_priorisation.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

st_write(admin_combined,
         paste0(pathOutput, "CoulAgri_adminRegion.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

st_write(mrc_combined,
         paste0(pathOutput, "CoulAgri_mrc.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

#End of script#