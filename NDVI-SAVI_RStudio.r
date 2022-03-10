##1.=============================Instalación de paquetes y llamado de librerías.==================================================/

library(raster)
library(rgdal)
library(kendall)
library(raster)
library(rgdal)
library(kendall)
library(ggplot2)
library(Kendall)
library(plot)
library(ggplot2)
library(maptools)
install.packages('RStoolbox')
install.packages("ggplot2")
install.packages("brickr")
install.packages("sp")
install.packages('raster')
install.packages("rgdal")

##===================== Compilación y modificación de código por MMZC. Eloy Gayosso Soto para la estimación ==================================/
##===================== de la prueba no paramétrica de tendencia Man-Kendal (MK) sobre valores estimados de =================================/
##===================== NDVI y SAVI en vegetación de duna costera en la RBSK, para el periodo 2011-2020. ===================================/

##===========================(tomado y adaptado de Dr. Francisco Javier Bonet García ).===================================================/


##==============================1. Estableciendo el directorio de trabajo donde estan los raster anuales de trabajo.========================/

setwd("~/R_Studio/NDVI-Anual")

##==============================2. Llamado y enpaquetado todas las imagenes tiff generadas en GEE en una única imagen multibanda.===============/

img_ndvi <- list.files(pattern ='*.tif', full.names=TRUE)

ndvis_01 <- stack(img_ndvi)

##===============================3. Gráficas de los resultados.=====================================================================================/

plot(ndvis_01)

##================================ 4. Exportando las imagen multibanda a fomato *.tiff, para poder ser visualizada en QGis.==========================/

writeRaster(ndvis_01, filename = 'ndvi_2011_2020.tif', format= 'GTiff', overwrite = TRUE)

##================================== 5. Calculo de la serie temporal con la prueba MK de todos los pixeles sobre la imagen ==========================/
##==================================    multibanda con el ídice estimado (NDVI y/o SAVI).============================================================/

fun_k <-  function(x){return(unlist(MannKendall(x)))}

kendal_result <- calc(ndvis_01, fun_k)

##===================================6. exportamos la tendencia (tau) a un tiff

writeRaster(kendal_result$tau, filename = 'tau.tif', format= 'GTiff', overwrite = TRUE)

##====================================== 7. Reclasificación de valores para una mejor visión de las zonas de tendencia  positivas (+) ================/
##======================================    y negativas (-),generando matriz de valor máximo y minimo. ==============================================/

m <- c(-1, -0.25, -1, -0.25, 0.5, 0, 0.5, 1, 1)

rclmat <- matrix(m, ncol = 3, byrow = TRUE)
rc_tau <- reclassify(kendal_result$tau, rclmat)

plot(rc_tau)

##===================================== 8. Exportando valores reclasificados de tau de MK.===========================================================/
writeRaster(rc_tau, filename = 'rc_tau.tif', format= 'GTiff', overwrite = TRUE)

plot(rc_tau)

##===================================== 9. Carga de capa vectorial de la zona de estudio según sea el caso.==========================================/
##=====================================   para realizar el corte sobre la tendencia estimada. ('.' llamando al working directory) ==================/

ZN <- readOGR ('.', 'ZN_GEE')
tau_ZN_NDVI <- crop (kendal_result$tau, ZN)
tau_ZN_NDVI_f <- mask (tau_ZN_NDVI, ZN)

##===================================== 10. Exporta la tendencia a formato tiff de la zona de estudio.=============================================/

writeRaster(tau_ZN_NDVI_f, filename = 'tau_ZN_NDVI.tif', format= 'GTiff', overwrite = TRUE)

## Nota: De los resultados obtenidos y explorados hasta esta sección del código, se logro observar que si se reclasifica, ##
##el tif se exporta con una zona externa que la reclasificación la reconoce con valor dentro de QGis. Sin embargo, no debería ser así.##
##NBos obstante, si se exporta sin reclasificar en R studio, la zona externa desaparece. Entonces se puede realizar la reclasificación de valores ##
##de tendencia (+1/-1) de forma manual en  QGis, para verificar las zonas con tendencia positiva y negativa. ##

## esta sección podría funcionar cuadno se tiene una zona establecida de dimensiones mayores a este estudio y despues realizar el corte 
## y reclasificación posterior para obtener un raster con valores optimos.

m_ZN <- c(-1, -0.25, -1, -0.25, 0.5, 0, 0.5, 1, 1)
rclmat_ZN <- matrix(m_ZN, ncol = 3, byrow = TRUE)
rc_tau_ZN_NDVI <- reclassify(kendal_result$tau, rclmat_ZN)

plot(rc_tau_ZN_NDVI)

writeRaster(rc_tau_ZN_NDVI, filename = 'rc_tau_ZN_NDVI.tif', format= 'GTiff', overwrite = TRUE)
