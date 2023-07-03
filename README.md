# 2023_HAB_CoulAgri

Ensemble de données utilisées pour développer la carte interactive des coulées agricoles et résultats de la priorisation, tels qu'affichés sur le site web via Cartodb. Les données et la méthodologie proviennent des projets suivants : 
- Demain la Forêt, en partenariat avec le Jour de la Terre Canada ;
- Priorisation des coulées agricoles des Basses-Terres du Saint-Laurent à restaurer pour rétablir la connectivité écologique, financé par ECCC.

Les régions à l'étude sont les basses terres du Saint-Laurent et la MRC du Saguenay Lac-Saint-Jean. 

Voici une brève description des différents fichiers :

**PrepInteractiveMap.R** : Script utilisé pour consolider et fusionner les données de différents projets.

**CoulAgri_adminRegion.zip** : Régions administratives couvertes par les régions d'étude. Contient le nom et le code de chaque région administrative.

**CoulAgri_coulees.zip** : Coulées agricoles délimitées. Contient également l'ID, la superficie de chaque coulée et des informations sur la pente, les propriétés du sol et la couverture végétale. Les coulées agricoles sont définies comme des jachères situées dans un zonage agricole, ayant une forme non linéaire, une pente moyenne supérieure à 15 % et une faible superficie de végétation d'au moins 0,15 hectare. Notez que certaines colonnes ont des valeurs NA en fonction de la région d'intérêt. Exemple : Nous n'avons pas extrait les propriétés du sol pour la MRC du Saguenay Lac-Saint-Jean. Les valeurs de ces colonnes sont donc manquantes pour les coulées agricoles de cette région.

**CoulAgri_mrc.zip** : MRC couvertes par les régions d'étude. Contient le nom et le code de chaque MRC.

**CoulAgri_priorisation.zip** : Résultats de la priorisation. Les différents critères utilisés dans les priorisations sont mentionnés dans Metadonnees.pdf. Nous n'avons pas utilisé les mêmes critères pour toutes les régions étudiées. Exemple : Il n'y avait pas d'espèces forestières menacées au Saguenay Lac-Saint-Jean, donc nous n'avons pas inclus ce critère dans la priorisation.

**Metadonnees.pdf** : Pdf contenant la description des colonnes des fichiers CoulAgri_adminRegion.zip et CoulAgri_coulees.zip.   

*Notez que toutes les colonnes des fichiers ne sont pas affichées dans la carte.*

-----

Dataset used for constructing the interactive map of coulées agricoles and prioritization results, as displayed through Cartodb on the website. The data and methodology come from the following projects : 
- Demain la Forêt, in partenership with Jour de la Terre Canada ;
- Priorization of the coulees agricoles in the St.Lawrence Lowlands for restauration to re-establish ecological connectivity, funded by ECCC.

The study regions are the St. Lawrence Lowlands and the MRC of Saguenay Lac-Saint-Jean.

Here is a short description of the different files :

PrepInteractiveMap.R : Script used to consolidate and merge data from different projects.

CoulAgri_adminRegion.zip : Administrative regions covered by study regions. Contains name and code of each administrative region.

CoulAgri_coulees.zip : Coulees agricoles delimitations. Also contains ID, superficy of each coulees and information on slope, soil properties and vegetation cover. Coulees agricoles are defined as fallows located in agricultural zoning, with a non-linear shape, an average slope superior to 15% and a low vegetation superficy of at least 0.15 hectares. Note that some columns have NA values depending on the region of interest. Example : We didn't extract soil properties for the MRC Saguenay Lac-Saint-Jean so the values in those columns are missing for coulées agricoles in this region.

CoulAgri_mrc.zip : MRC covered by study regions. Contains name and code of each MRC.

CoulAgri_priorisation.zip : Prioritization results. The different criteria used in the prioritizations are mentioned in Metadonnees.pdf. We didn't use the same criteria for every study regions. Example : There were no occurrences of forest threatened species in Saguenay Lac-Saint-Jean, so we didn't include this criteria in the priorization.

Metadonnees.pdf : Pdf containing columns description of CoulAgri_adminRegion.zip and CoulAgri_coulees.zip files.

Note that not all file columns are displayed in the map.
