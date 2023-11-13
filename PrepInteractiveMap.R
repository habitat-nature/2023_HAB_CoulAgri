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
pathDataJDLT <- "G:/Shared drives/Projets/Actif/2022_JDT_DemForet/3-Analyses/1-Data/"
pathOutput <- "G:/My Drive/Github/2023_HAB_CoulAgri/"


####LOAD THE DATA####
# Coulees agricoles delimitations
cag <- st_read(paste0(pathDataJDLT, "CouleesAgricoles/coulees_agricoles.shp"))
# Prioritization results 
prio <- st_read(paste0(pathDataJDLT, "Priorities/prio_bois.shp"))
# Administrative regions
admin_reg <- st_read(paste0(pathAdminReg, "reg_admin/regio_s.shp"))
# MRC
mrc <- st_read(paste0(pathAdminReg, "mrc/mrc_s.shp"))


####DATA PROCESSING####
## 1. Prep data
# Change crs as needed 
admin_reg <- st_transform(admin_reg, crs = st_crs(cag_east)) %>%
  dplyr::select(REG_NOM = RES_NM_REG, REG_CODE = RES_CO_REG)
mrc <- st_transform(mrc, crs = st_crs(cag_east)) %>% 
  dplyr::select(MRC_NOM = MRS_NM_MRC, MRC_CODE = MRS_CO_MRC,
                REG_NOM = MRS_NM_REG, REG_CODE = MRS_CO_REG)


## 2. Subdivised datasets by MRC 
summary(sort(unique(cag$mrc_nom)) == sort(unique(prio$mrc_nom)))
mrc_names <- unique(cag$mrc_nom)

for(i in mrc_names){
  # Create folder if non existent and set working directory
  temp_dir <- paste0(pathOutput, "MRC_donnees/", i)
  if (file.exists(temp_dir)){
    setwd(temp_dir)
  } else {
    dir.create(temp_dir)
    setwd(temp_dir)
  }
  # Subset data
  prio_temp <- prio %>% filter(MRC_NOM == i)
  cag_temp <- cag %>% filter(MRC_NOM == i)
  # Export data
  st_write(prio_temp, paste0("priorisation_", i, ".shp"), delete_layer = TRUE)
  st_write(cag_temp, paste0("coulees_", i, ".shp"), delete_layer = T)
}


####EXPORT DATA####
st_write(cag, 
         paste0(pathOutput, "CoulAgri_coulees.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

st_write(prio, 
         paste0(pathOutput, "CoulAgri_priorisation.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

st_write(admin_reg,
         paste0(pathOutput, "CoulAgri_adminRegion.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

st_write(mrc,
         paste0(pathOutput, "CoulAgri_mrc.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

#End of script#