# 2023_HAB_CoulAgri

Ensemble de données utilisées pour développer la carte interactive des coulées agricoles et résultats de la priorisation, tels qu'affichés sur le site web via Cartodb. Les données et la méthodologie proviennent des projets suivants : 
- Demain la Forêt, en partenariat avec le Jour de la Terre Canada ;
- Priorisation des coulées agricoles des Basses-Terres du Saint-Laurent à restaurer pour rétablir la connectivité écologique, financé par ECCC.

Les régions à l'étude sont les basses terres du Saint-Laurent et la MRC du Saguenay Lac-Saint-Jean. 

Voici une brève description des différents fichiers :

**PrepInteractiveMap.R** : Script utilisé pour consolider et fusionner les données de différents projets.

**CoulAgri_adminRegion.zip** : Régions administratives couvertes par les régions d'étude. Contient le nom et le code de chaque région administrative.

**CoulAgri_coulees.zip** : Coulées agricoles délimitées. Contient également l'ID, la superficie de chaque coulée et des informations sur la pente, les propriétés du sol et la couverture végétale. Les coulées agricoles sont définies comme des jachères situées dans un zonage agricole, ayant une forme non linéaire, une pente moyenne supérieure à 15 % et une faible superficie de végétation d'au moins 0,15 hectare. Notez que certaines colonnes ont des valeurs NA en fonction de la région d'intérêt. Exemple : Nous n'avons pas extrait les propriétés du sol pour la MRC du Saguenay Lac-Saint-Jean. Les valeurs de ces colonnes sont donc manquantes pour les coulées agricoles de cette région.

**CoulAgri_mrc.zip** : MRC couvertes par les régions d'étude. Contient le nom et le code de chaque MRC, ainsi que le code et le nom de la région administrative dans laquelle la MRC se trouve. 

**CoulAgri_priorisation.zip** : Résultats de la priorisation. Les différents critères utilisés dans les priorisations sont mentionnés dans Metadonnees.pdf. Nous n'avons pas utilisé les mêmes critères pour toutes les régions étudiées. Exemple : Il n'y avait pas d'espèces forestières menacées au Saguenay Lac-Saint-Jean, donc nous n'avons pas inclus ce critère dans la priorisation.

**Metadonnees.pdf** : Pdf contenant la description des colonnes des fichiers CoulAgri_adminRegion.zip et CoulAgri_coulees.zip.  

**recommandations.xlsx** :  Document contenant différentes pratiques et aménagements pouvant être mobilisées dans les coulées agricoles dans le but de favoriser la présence de certaines espèces champêtres ou forestières. Les espèces sélectionnées pour cette revue de littérature ont été jugées comme étant prioritaires dans les Basses-Terres du Saint-Laurent par nos collaborateurs et collaboratrices de ECCC.



*Notez que toutes les colonnes des fichiers ne sont pas affichées dans la carte.*

-----

Source data used for the  interactive map showing where coulées agricoles are located and how to prioritize them for restoration, as displayed using Cartodb on the Habitat website. The data and methodology are described in the documentation for the following projects: 
- Demain la Forêt, in partenership with Jour de la Terre Canada ;
- Priorisation des coulées agricoles des Basses-Terres du Saint-Laurent à restaurer pour rétablir la connectivité écologique, funded by ECCC.

The analysis focused on two study regions including the St. Lawrence Lowlands and the Saguenay Lac-Saint-Jean regional municipal county.

Here is a short description of the different files:

**PrepInteractiveMap.R** : Script used to consolidate and merge data from different projects for integration into the interactive map.

**CoulAgri_adminRegion.zip** : The zip file includes shapefiles of the administrative regions within each study region, along with the respective names and codes for each region.

**CoulAgri_coulees.zip** : The provided zip file contains a shapefile delineating coulées agricoles. Within the attribute tables of the shapefile, you will find comprehensive information regarding each coulée agricole, including a unique ID, surface area, slope, soil characteristics, and vegetation cover. Coulées agricoles are defined as fallow land situated in agriculturally zoned areas, featuring a non-linear shape and an average slope exceeding 15%. Additionally, these areas are characterized by a minimum coverage of 0.15 ha of low vegetation. It's important to note that certain columns within the attribute table may contain NA values depending on the specific region of interest. For example, soil properties for the Saguenay Lac-Saint-Jean regional municipal county were not extracted, resulting in missing values within columns with soil property information for coulées agricoles in this particular region.

**CoulAgri_mrc.zip** : Regional municipal counties covered by study regions. Contains the names and codes of each regional municipal county. Also containt the names and the codes of the administratives regions in which the regional municipality counties are located. 

**CoulAgri_priorisation.zip** :Prioritization results are available, with details on the various criteria used, listed in the Metadonnees.pdf file. Different sets of criteria were employed to rank coulées agricoles in each study region. For instance, in Saguenay Lac-Saint-Jean, the criteria regarding occurrences of forest threatened species were excluded from the prioritization due to their absence in the region.

**Metadonnees.pdf** : Pdf containing column descriptions for CoulAgri_adminRegion.zip and CoulAgri_coulees.zip.

**recommandations.xlsx** :  The provided document outlines a range of practices applicable to agricultural wastelands, aiming to enhance the presence of specific rural or forest species. These species were identified as being of high priority  i the St. Lawrence Lowlands, based on the assessment conducted in collaboration with our partners at ECCC.

*Note that some columns included in the different files are not displayed on the map.*
