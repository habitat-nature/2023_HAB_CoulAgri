# 2023_HAB_CoulAgri
Dataset used for constructing the interactive map of _coulées agricoles_ and prioritization results, as displayed through Cartodb on the website. The data and methodology come from the following projects : 2020_ECCC_CoulAgri_002, 2022_ECCC_CoulAgri_003 and 2022_JDT_DemForet. The study regions are the St. Lawrence Lowlands and the MRC of Saguenay Lac-Saint-Jean. 

Here is a short description of the different files :

**1.PrepInteractiveMap.R** : Script used to consolidate and merge data from different projects.\
**CoulAgri_adminRegion.zip** : Administrative regions covered by study regions. Contains name and code of each administrative region.\
**CoulAgri_coulees.zip** : _Coulées agricoles_ delimitations. Also contains ID, superficy of each coulees and information on slope, soil properties and vegetation cover. Coulees agricoles are defined as fallows located in agricultural zoning, with a non-linear shape, an average slope superior to 15% and a low vegetation superficy of at least 0.15 hectares. Note that some columns have NA values depending on the region of interest. Example : We didn't extract soil properties for the MRC Saguenay Lac-Saint-Jean so the values in those columns are missing for _coulées agricoles_ in this region. \
**CoulAgri_mrc.zip** : MRC covered by study regions. Contains name and code of each MRC.\
**CoulAgri_priorisation.zip** : Prioritization results. The different criteria used in the prioritizations are mentioned in Metadonnees.pdf. We didn't use the same criteria for every study regions. Example : There were no occurrences of forest threatened species in Saguenay Lac-Saint-Jean, so we didn't include this criteria in the priorization.\ 
**Metadonnees.pdf** : Pdf containing columns description of CoulAgri_adminRegion.zip and CoulAgri_coulees.zip files.

Note that not all file columns are displayed in the map. 

