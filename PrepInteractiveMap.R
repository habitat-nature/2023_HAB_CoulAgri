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
# Coulees agricoles delimitations
cag_east <- st_read(paste0(pathDataJDLT, "CouleesAgricoles/BTSL_East/coulees_agricoles.shp"))
cag_west <- st_read(paste0(pathDataECCC, "CouleesAgricoles/coulees_agricoles.shp"))
cag_qc <- st_read(paste0(pathDataJDLT, "CouleesAgricoles/South_QC/coulees_agricoles.shp"))

# Prioritization results 
prio_west <- st_read(paste0(pathDataECCC, "Priorities/prio_bois.shp"))
prio_east <- st_read(paste0(pathDataJDLT, "Priorities/BTSL_East/prio_bois.shp"))
prio_qc <- st_read(paste0(pathDataJDLT, "Priorities/South_QC/prio_bois.shp"))

#Administrative regions for the BTSL West and East
admin_reg <- st_read(paste0(pathAdminReg, "reg_admin/regio_s.shp"))

#MRC
mrc <- st_read(paste0(pathAdminReg, "mrc/mrc_s.shp"))


####DATA PROCESSING####
## 1. Prep data
# Check if crs are matching
st_crs(cag_east) == st_crs(cag_west)
st_crs(cag_east) == st_crs(cag_qc)
st_crs(cag_east) == st_crs(prio_west)
st_crs(cag_east) == st_crs(prio_east)
st_crs(cag_east) == st_crs(prio_qc)
st_crs(cag_east) == st_crs(admin_reg)
st_crs(cag_east) == st_crs(mrc)

# Change crs as needed 
admin_reg <- st_transform(admin_reg, crs = st_crs(cag_east)) %>%
  dplyr::select(REG_NOM = RES_NM_REG, REG_CODE = RES_CO_REG)
mrc <- st_transform(mrc, crs = st_crs(cag_east)) %>% 
  dplyr::select(MRC_NOM = MRS_NM_MRC, MRC_CODE = MRS_CO_MRC,
                REG_NOM = MRS_NM_REG, REG_CODE = MRS_CO_REG)

## 2. Transform ID because some are duplicated
cag_east$ID <- paste0("01", cag_east$ID)
prio_east$ID <- paste0("01", prio_east$ID)
cag_west$ID <- paste0("02", cag_west$ID)
prio_west$ID <- paste0("02", prio_west$ID)
cag_qc$ID <- paste0("03", cag_qc$ID)
prio_qc$ID <- paste0("03", prio_qc$ID)

## 3. Merge layers together
# Coulees agricoles
cag_shp <- rbind(cag_east[, c("ID")], cag_west[, c("ID")], cag_qc[, c("ID")])

cag_df <- rbind.fill(cag_east, cag_west, cag_qc) %>%
  dplyr::select(-geometry)

cag_combined <- cag_shp %>% 
  left_join(cag_df, by = "ID") %>%
  mutate(priorite = round(priorite * 100, digits = 0),
         selct_prio = ifelse(selct_prio == 1, "Oui", "Non"))

# Priorities
prio_shp <- rbind(prio_east[, c("ID")], prio_west[, c("ID")], prio_qc[, c("ID")])

prio_df <- rbind.fill(prio_east, prio_west, prio_qc) %>%
  dplyr::select(-geometry)

prio_combined <- prio_shp %>% 
  left_join(prio_df, by = "ID") %>%
  mutate(priorite = round(priorite * 100, digits = 0))


## 4. Add mrc and admin region info
cag_reg_df <- cag_combined %>% 
  st_intersection(mrc) %>% 
  mutate(sup_m2 = as.numeric(st_area(geometry))) %>% 
  group_by(ID) %>% 
  slice_max(sup_m2, n=1) %>% 
  data.frame %>% 
  dplyr::select(ID, REG_NOM, MRC_NOM)

cag_final <- left_join(cag_combined, cag_reg_df)

head(cag_final)
unique(cag_final$ID) %>% length ; nrow(cag_final)
class(cag_combined)

prio_reg_df <- prio_combined %>% 
  st_intersection(mrc) %>% 
  mutate(sup_m2 = as.numeric(st_area(geometry))) %>% 
  group_by(ID) %>% 
  slice_max(sup_m2, n=1) %>% 
  data.frame %>% 
  dplyr::select(ID, REG_NOM, MRC_NOM)

prio_final <- left_join(prio_combined, prio_reg_df)

head(prio_final)
unique(prio_final$ID) %>% length ; nrow(prio_final)
class(prio_final)


## 5. Subdivised datasets by MRC 
summary(sort(unique(cag_final$MRC_NOM)) == sort(unique(prio_final$MRC_NOM)))
mrc_names <- unique(cag_final$MRC_NOM)

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
  prio_temp <- prio_final %>% filter(MRC_NOM == i)
  cag_temp <- cag_final %>% filter(MRC_NOM == i)
  # Export data
  st_write(prio_temp, paste0("priorisation_", i, ".shp"), delete_layer = TRUE)
  st_write(cag_temp, paste0("coulees_", i, ".shp"), delete_layer = T)
}


####EXPORT DATA####
st_write(cag_final, 
         paste0(pathOutput, "CoulAgri_coulees.shp"), 
         layer_options = "ENCODING=UTF-8",
         delete_layer = TRUE)

st_write(prio_final, 
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