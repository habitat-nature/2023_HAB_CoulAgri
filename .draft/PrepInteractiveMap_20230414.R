################################################################################
##
## Prep data for interactive CartoDB map
################################################################################
#date: 20230310
#author: Kyle T. Martins

#Objective: compile data for data package for the ECCC project

library(sf)
library(tidyr)
library(dplyr)

#Set the working directory to the source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
for(i in 1:4){setwd("..")}

####DEFINE PATHS####

pathDataECCC<-paste0("G:/Shared drives/Projets/Actif/2022_ECCC_CoulAgri_003/",
                     "3-Analyses/1-Data/")
pathDataJDLT<-paste0("G:/Shared drives/Projets/Actif/2022_JDT_DemForet/",
                     "3-Analyses/1-Data/")
pathOutput<-paste0("G:/My Drive/Github/2020_ECCC_CoulAgri_002/")

pathDataECCC_ph2<-paste0("G:/Shared drives/Archive/ECCC/2020_ECCC_CoulAgri_002/",
                         "3-Analysis/1-Data/1-GeospatialData/")

####LOAD THE DATA####

#CAG for the BTSL West
btsl_west = 
  st_read(paste0(pathDataJDLT, "CouleesAgricoles/cagFinal_inBTSL.shp"),
          quiet=T)

#CAG for the BTSL East
btsl_east = 
  st_read(paste0(pathDataECCC, "CouleesAgricoles/cagFinal.shp"),
          quiet=T)


#Administrative regions for the BTSL West and East

admin_east <- st_read(paste0(pathDataECCC_ph2, "AdminRegion/admin_reg.shp"),
                      quiet=T)
admin_west <- st_read(paste0(pathDataECCC, "AdminRegion/admin_reg.shp"),
                      quiet=T)

#MRC

mrc_east <- st_read(paste0(pathDataECCC_ph2, "AdminRegion/admin_mrc.shp"),
                      quiet=T)
mrc_west <- st_read(paste0(pathDataECCC, "AdminRegion/admin_mrc.shp"),
                      quiet=T)



####DATA PROCESSING####

#Combine the layers
names(btsl_west)[!names(btsl_west) %in% names(btsl_east)]
names(btsl_east)[!names(btsl_east) %in% names(btsl_west)]

library(plyr)
btsl_combined<-rbind.fill(btsl_east, btsl_west)
names(btsl_combined)

admin_combine<-rbind(admin_east, admin_west)

mrc_combine<-rbind(mrc_east, mrc_west)

####EXPORT DATA####


st_write(btsl_combined, 
         paste0(pathOutput, "coulees_agricoles_2023.shp"), 
         quiet=TRUE,
         delete_layer = TRUE)

st_write(admin_combine,
         paste0(pathOutput, "admin_region_btsl.shp"), 
         quiet=TRUE,
         delete_layer = TRUE)

st_write(mrc_combine,
         paste0(pathOutput, "mrc_btsl.shp"), 
         quiet=TRUE,
         delete_layer = TRUE)


#End of script#

