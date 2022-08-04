# DoPE_Public

[![GitHub release](https://img.shields.io/badge/R-HEDS-green)](https://img.shields.io/badge/R-hello-green)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![GitHub last commit](https://img.shields.io/github/last-commit/ScHARR-PHEDS/DoPE_Public?color=red&style=plastic)
![GitHub top language](https://img.shields.io/github/languages/top/ScHARR-PHEDS/DoPE_Public?style=plastic)
![GitHub repo size](https://img.shields.io/github/repo-size/ScHARR-PHEDS/DoPE_Public?style=plastic)
[![GitHub forks](https://img.shields.io/github/forks/ScHARR-PHEDS/DoPE_Public?style=social&label=Fork&maxAge=2592000)](https://GitHub.com/RobertASmith/shiny_healthy_economics/network/)
<br>
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3596841.svg)](https://doi.org/10.5281/zenodo.3596841)

This work has been published in [Wellcome Open Research](https://wellcomeopenresearch.org/articles/5-9).

Please cite this work as:

Smith R, Schneider P, Bullas A et al. Does ethnic density influence community participation in mass participation physical activity events? The case of parkrun in England [version 1; peer review: 2 approved, 1 approved with reservations]. Wellcome Open Res 2020, 5:9 (https://doi.org/10.12688/wellcomeopenres.15657.1)

### Background
parkrun has been successful in encouraging people in England to participate in their weekly 5km running and walking events. However, there is substantial heterogeneity in parkrun participation across different communities in England: after controlling for travel distances, deprived communities have significantly lower participation rates.

### Methods
This paper expands on previous findings by investigating disparities in parkrun participation by ethnic density. We combined geo-spatial data available through the Office for National Statistics with participation data provided by parkrun, and fitted multivariable Poisson regression models to study the effect of ethnic density on participation rates at the Lower layer Super Output Level.

### Results
We find that areas with higher ethnic density have lower participation rates. This effect is independent of deprivation.

### Conclusions
An opportunity exists for parkrun to engage with these communities and reduce potential barriers to participation.
This project is licensed under the terms of the MIT license.

### Cool Plot
![PLOT 1](https://github.com/ScHARR-PHEDS/DoPE_Public/blob/master/output/colour_plot.png)

### Data Sources

Alan Brennan comment: I just wanted to practice making a suggested change to this brilliant and clear readme as if this was an actual suggested change in text - what i would recommend would be having the data sources in a more logical sequence for the reader.  i'd presumed you would say - they key data source is parkrun data which has the key variable ...  And then In addition to this we obtained data on blah - using source blah, and then data on blah2 using source blah2.  This way someone new to the paper and seeing the readme for the first time can follow and get a grip of the method. Fantastic work.

The sources of data are listed below:

Parkrun event info: Parkrun UK. 2018. http://www.parkrun.org.uk/

IoD2019_Scores.csv: Office for National Statistics. English indices of deprivation 2015. Official Statistics. 2015. Available at: https://www.gov.uk/government/statistics/english-indices-of-deprivation-2015

LSOA_Ethnicity.csv: Office for National Statistics. 2019. Lower layer Super Output Area population estimates (supporting information). https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/lowersuperoutputareamidyearpopulationestimates

IoD2019_Population_Denominators.csv: Office for National Statistics. English indices of deprivation 2015. Official Statistics. 2015. Available at: https://www.gov.uk/government/statistics/english-indices-of-deprivation-2015

Mid-2017 Population Density.csv: Office for National Statistics. Lower layer Super Output Area population density (National Statistics). Mid-2015: SAPE20DT11: Revised. 2018. Available at: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/lowersuperoutputareapopulationdensity

LSOA_Rural_Urban_Classification_2011.csv: Office for National Statistics. 2011 Rural-Urban Classification of Local Authorities and other geographies. https://www.gov.uk/government/statistics/2011-rural-urban-classification-of-local-authority-and-other-higher-level-geographies-for-statistical-purposes

LSOA geospatial info: Office for National Statistics. Lower Layer Super Output Area (LSOA) boundaries. Super generalized and clipped. 2016. Available at: https://borders.ukdataservice.ac.uk/easy_download_data.html?data=England_lsoa_2011

These datasets are licensed under the Open Government Licence 3.0. 
