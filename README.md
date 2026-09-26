# Raster_NDVI-SAVI-GEE_RStudio_MK
Análisis de serie temporal de raster NDVI y SAVI de GEE en RStudio (RS).

## Descripción 📋
El presente código se encuentra estructurado para calcular la prueba Mann-Kendal (MK), Función que permite calcular para cada pixel la tendencia (+/-) de cada valor de IVM, evaluando su secuencia, es decir si es ascendente o descendente. Esta prueba fue estimada sobre raster anuales provenientes de Google Earth Engine (GEE), sobre el ecosisteam de duna costera (DC), en la Reserva de la Bisofera de Sian Ka´an (RBSK), Quintana Roo, México, para el periodo 2011-2020. 

Las capas raster anuales fueron descargadas a traves de la plataforma [**GEE**](https://developers.google.com/earth-engine/guides/getstarted?hl=en).

El repostirorio se elaboró de acuerdo a los lineamientos de la [**licencia GNU General Public License v3.0.**](https://choosealicense.com/licenses/gpl-3.0/).

##Visualización de la Reserva de la Bisofera de Sian Ka´an (RBSK), a tráves de la colección 2 de Landsat 7, con composición de bandas B (3, 2, 1), en GEE.

![alt text](https://github.com/demostenesmx/NDVI-SAVI_DCA/blob/main/C02_B_3_2_1_RBSK.JPG) 📖

Interfaz de RStudio.

![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/Interfaz_RStudio.JPG)


Con la ejecución de este código se obtendrán las tendencias de la densidad de la cobertura vegetal de cada índice estimado por zona de estudio.

Representación de los raster en RS:

1. Plot NDVI_ZN.

 ![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/Anua_NDVI_ZN.png)

2. Plot SAVI_ZN.
 
 ![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/SAVI_ZN_RS.png)

3. Plot NDVI_ZS.

  ![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/Rplot.png)

4. Plot SAVI_ZS.

   ![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/SAVI_ZS.png)

5. Ejemplo resultado de raster´s conseguidos con Mann-Kendall.
   
   ![alt text]( https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/5%20raters%20estadisticos.png)
   
### Interfaz de QGis. 

La manipulación de la información contenida en los rasaters puede realizarse, a traves, del sistema de información geografica de su preferencia. Para el presente caso de estudio se utilizó el software de acceso libre QGIS.

![alt text](https://github.com/demostenesmx/NDVI-SAVI_DCA/blob/main/QGis.JPG)

Cita: Gayosso-Soto, E.; Cohuo, S.; Sánchez-Sánchez, J.A.; Villegas-Sánchez, C.A.; Castro-Pérez, J.M.; Cutz-Pool, L.Q.; Macario-González, L. Coastal Dune Vegetation Dynamism and Anthropogenic-Induced Transitions in the Mexican Caribbean during the Last Decade. Plants 2024, 13, 1734. https://doi.org/10.3390/plants13131734


Gayosso-Soto, E., Cohuo, S., Sánchez-Sánchez, J. A., Macario-González, L., Villegas-Sánchez, C. A., Medina-Quej, A., Tello-Chan, J. M., Cutz-Pool, L. Q., & Castro-Pérez, J. M. (2024). The Environmental Legal Framework of Mexican Caribbean Dunes: A Retrospective Case Study of Vegetation and Coastal Dune Loss in the Sian Ka’an Biosphere Reserve. Land, 13(9), 1533. https://doi.org/10.3390/land13091533



