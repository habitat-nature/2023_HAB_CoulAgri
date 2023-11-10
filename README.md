# 2023_HAB_CoulAgri

Ensemble de données utilisées pour développer la carte interactive des coulées agricoles et des résultats de la priorisation, tels qu'affichés sur le site web via Cartodb. Les données et la méthodologie proviennent des projets suivants : 
- Demain la Forêt, en partenariat avec le Jour de la Terre Canada

La région d'étude est le sud du Québec.  

Voici une brève description des différents fichiers :

**PrepInteractiveMap.R** : Script utilisé pour consolider et fusionner les données de différents projets.

**CoulAgri_adminRegion.zip** : Régions administratives couvertes par la région d'étude. Contient le nom et le code de chaque région administrative.

**CoulAgri_coulees.zip** : Délimitation des coulées agricoles. Contient l'identifiant unique, la superficie de chaque coulée et des informations sur la pente, les propriétés du sol et la couverture végétale. Les coulées agricoles sont définies comme des friches situées en zonage agricole, ayant une forme non linéaire, une pente moyenne supérieure à 15 % et une superficie de végétation basse d'au moins 0,15 hectare. Ce jeu de données a également été subdivisé par MRC. Les données se trouvent dans le dossier *MRC_donnees*

**CoulAgri_mrc.zip** : MRC couvertes par la région d'étude. Contient le nom et le code de chaque MRC, ainsi que le code et le nom de la région administrative associée. 

**CoulAgri_priorisation.zip** : Résultats de la priorisation. Les différents critères utilisés dans les priorisations sont décrits dans le fichier Metadonnees.pdf. Les résultats de priorisation ont également été subdivisé par MRC et se trouvent dans le dossier *MRC_donnees*

**Metadonnees.pdf** : Pdf contenant la description des colonnes des fichiers CoulAgri_priorisation.zip et CoulAgri_coulees.zip.  

**recommandations.xlsx** :  Document contenant différentes pratiques et aménagements pouvant être mobilisées dans les coulées agricoles dans le but de favoriser la présence de certaines espèces champêtres ou forestières. Les espèces sélectionnées pour cette revue de littérature ont été jugées comme étant prioritaires dans les Basses-Terres du Saint-Laurent par nos collaborateurs et collaboratrices de ECCC.



*Notez que toutes les colonnes des fichiers ne sont pas affichées dans la carte.*

-----

Source data used for the  interactive map showing where *coulées agricoles* are located and how to prioritize them for restoration, as displayed using Cartodb on the Habitat website. The data and methodology are described in the documentation for the following projects: 
- Demain la Forêt, in partenership with Jour de la Terre Canada 

The study region is the South of Quebec.

Here is a short description of the different files:

**PrepInteractiveMap.R** : Script used to consolidate and merge data from different projects for integration into the interactive map.

**CoulAgri_adminRegion.zip** : Administrative regions within the study region. Contains the name and code of each administrative region. 

**CoulAgri_coulees.zip** : Delimitation of *coulées agricoles*. Contains unique identifier, surface area, slope, soil characteristics, and vegetation cover. *Coulées agricoles* are defined as wastelands in agriculturally zoned areas, featuring a non-linear shape, with an average slope exceeding 15% and a minimum of 0.15 ha of low vegetation. This dataset was also subdivided by regional municipal county. Data are available in the *MRC_donnees* folder. 

**CoulAgri_mrc.zip** : Regional municipal counties within the study region. Contains the name and code of each regional municipal county. Also containt the name and the code of the associated administrative region. 

**CoulAgri_priorisation.zip** : Prioritization results. The different criteria used in the prioritization are described in the Metadata.pdf file. This dataset was also subdivided by regional municipal county. Data are available in the *MRC_donnees* folder. 

**Metadonnees.pdf** : Pdf containing column descriptions for CoulAgri_priorisation.zip and CoulAgri_coulees.zip.

**recommandations.xlsx** :  The provided document outlines a range of practices applicable to agricultural wastelands, aiming to enhance the presence of specific rural or forest species. These species were identified as being of high priority  i the St. Lawrence Lowlands, based on the assessment conducted in collaboration with our partners at ECCC.

*Note that some columns included in the different files are not displayed on the map.*
