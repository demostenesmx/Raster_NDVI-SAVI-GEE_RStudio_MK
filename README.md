# Raster_NDVI-SAVI-GEE_RStudio_MK
An谩lisis de serie temporal de raster NDVI y SAVI de GEE en RStudio (RS).

## Descripci贸n 馃搵
El presente c贸digo se encuentra estructurado para calcular la prueba Mann-Kendal (MK), Funci贸n que permite calcular para cada pixel la tendencia (+/-) de cada valor de IVM, evaluando su secuencia, es decir si es ascendente o descendente. Esta prueba fue estimada sobre raster anuales provenientes de Google Earth Engine (GEE), sobre el ecosisteam de duna costera (DC), en la Reserva de la Bisofera de Sian Ka麓an (RBSK), Quintana Roo, M茅xico, para el periodo 2011-2020. 

Las capas raster anuales fueron descargadas a traves de la plataforma [**GEE**](https://developers.google.com/earth-engine/guides/getstarted?hl=en).

El repostirorio se elabor贸 de acuerdo a los lineamientos de la [**licencia GNU General Public License v3.0.**](https://choosealicense.com/licenses/gpl-3.0/).

##Visualizaci贸n de la Reserva de la Bisofera de Sian Ka麓an (RBSK), a tr谩ves de la colecci贸n 2 de Landsat 7, con composici贸n de bandas B (3, 2, 1), en GEE.

![alt text](https://github.com/demostenesmx/NDVI-SAVI_DCA/blob/main/C02_B_3_2_1_RBSK.JPG) 馃摉

Interfaz de RStudio.

![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/Interfaz_RStudio.JPG)


Con la ejecuci贸n de este c贸digo se obtendr谩n las tendencias de la densidad de la cobertura vegetal de cada 铆ndice estimado por zona de estudio.

Representaci贸n de los raster en RS:

1. Plot NDVI_ZN.

 ![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/Anua_NDVI_ZN.png)

2. Plot SAVI_ZN.
 
 ![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/SAVI_ZN_RS.png)

3. Plot NDVI_ZS.

  ![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/Rplot.png)

4. Plot SAVI_ZS.

   ![alt text](https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/SAVI_ZS.png)

5. Ejemplo resultado de raster麓s conseguidos con Mann-Kendall.
   
   ![alt text]( https://github.com/demostenesmx/Raster_NDVI-SAVI-GEE_RStudio_MK/blob/main/5%20raters%20estadisticos.png)
   
### Interfaz de QGis. 

La manipulaci贸n de la informaci贸n contenida en los rasaters puede realizarse, a traves, del sistema de informaci贸n geografica de su preferencia. Para el presente caso de estudio se utiliz贸 el software de acceso libre QGIS.

![alt text](https://github.com/demostenesmx/NDVI-SAVI_DCA/blob/main/QGis.JPG)
