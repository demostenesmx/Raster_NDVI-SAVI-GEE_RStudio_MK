##================================ Instalación de paquetes y llamado de librerías.==================================================/

                          ## Actualizar paqueterías antes de inciar a correr el código. ##
library(rgdal)
library(kendall)
library(raster)
library(plot)
library(ggplot2)
library(maptools)
library(spatialEco)
install.packages('RStoolbox')
install.packages("ggplot2")
install.packages("brickr")
install.packages("sp")
install.packages('raster')
install.packages("rgdal")

##===================== Compilación y modificación de código por MMZC. Eloy Gayosso Soto para la estimación ==================================/
##===================== de la prueba no paramétrica de tendencia Man-Kendal (MK) sobre valores estimados de =================================/
##===================== NDVI y SAVI en vegetación de duna costera en la RBSK, para el periodo 2011-2020. ===================================/

##============================== 1. Estableciendo el directorio de trabajo donde estan los raster anuales de trabajo.========================/

setwd("~/R_Studio/NDVI-SAVI-ZN-ZS/ZN/NDVI")

##============================== 2. Llamado y enpaquetado todas las imagenes tiff generadas en GEE en una única imagen multibanda.===============/

img_ndvi <- list.files(pattern ='*.tif', full.names=TRUE)

ndvis_01 <- stack(img_ndvi)

##=============================== 3. Gráficas de los resultados.=====================================================================================/

plot(ndvis_01)

##================================ 4. Exportando las imagen multibanda a fomato *.tiff, para poder ser visualizada en QGis.==========================/

writeRaster(ndvis_01, filename = 'ndvi_2011_2020.tif', format= 'GTiff', overwrite = TRUE)

##================================== 5. Calculo de la serie temporal con la prueba MK de todos los pixeles sobre la imagen ==========================/
##==================================    multibanda con el ídice estimado (NDVI y/o SAVI).============================================================/

fun_k <-  function(x){return(unlist(MannKendall(x)))}  ## Llamando función MK

kendal_result <- calc(ndvis_01, fun_k)   ## Aplicando la función al raster ndvi_2011_2020 generado.

print(kendal_result)                    ## Imprimir resultados de MK.

summary(kendal_result)

plot(kendal_result)                    ## En RStudio se obtienen como resultado cinco rasters  a saber: 
                    
                                      ## tau -. Estadistico Tau de Kendall, sl: Valor P,  S: Puntuación de Kendall,  
                                      ## D: denominador; Tau = S/D, y  varS: Varianza de S.
   
##=================================== 6. Exportamos la tendencia (tau) y sl (p- valor) a un tiff

writeRaster(kendal_result$tau, filename = 'tau.tif', format= 'GTiff', overwrite = TRUE)

writeRaster(kendal_result$sl, filename = 'PVAL.tif', format= 'GTiff', overwrite = TRUE)

##====================================== 7. Reclasificación de valores para una mejor visión de las zonas de tendencia  positivas (+) ================/
##======================================    y negativas (-),generando matriz de valor máximo y minimo. ==============================================/

m <- c(-1, -0.25, -1, -0.25, 0.5, 0, 0.5, 1, 1) ## Los valores entre -1 y -0.25, tendrán valor de -1. Tendencia negativa.
                                                ## Los valores entre -0.25 y 0.5 tendrán un valor de 0. Tendencia neutra
                                                ## Los valores entre 0.5 y 1, tendrán valor de 1. Tendencia positiva
rclmat <- matrix(m, ncol = 3, byrow = TRUE)     ## Se genera la matriz de 3 columnas
rc_tau <- reclassify(kendal_result$tau, rclmat) ## Aplicando matriz generada a la banda Kendal_result$tau

plot(rc_tau)                                    ## Gáficar resultados.

##===================================== 8. Exportando valores reclasificados de tau de MK.===========================================================/

writeRaster(rc_tau, filename = 'rc_tau.tif', format= 'GTiff', overwrite = TRUE) ## Se genera archivo raster reclasificado


##===================================== 9. Carga de capa vectorial de la zona de estudio según sea el caso.==========================================/
##=====================================   para realizar el corte sobre la tendencia estimada. ('.' llamando al working directory) ==================/

ZN <- readOGR ('.', 'ZN_GEE')                ## Lectura de capa vectorial zona de estudio (ZN).
tau_ZN_NDVI <- crop (kendal_result$tau, ZN)  ## Corte de la capa Kendal_result$tau con la capa ZN
tau_ZN_NDVI_f <- mask (tau_ZN_NDVI, ZN)      ## fusionar ambas capas.

sl_ZN_NDVI <- crop (kendal_result$sl, ZN)    ## Corte de la capa Kendal_result$sl con la capa ZN
sl_ZN_NDVI_f <- mask (sl_ZN_NDVI, ZN)        ## fusionar ambas capas.

print(tau_ZN_NDVI_f)                         ## Imprimir resultados.

summary(tau_ZN_NDVI_f)


print(sl_ZN_NDVI_f)                         ## Imprimir resultados, se explora lo obtenido con print y summary.

summary(sl_ZN_NDVI_f)


plot(tau_ZN_NDVI_f)                         ## recortado los valores con la capa vectorial de la zona de estudio. 
                                            ## Con Plot se visualiza en la consola el raster de Tau de MK.
plot(sl_ZN_NDVI_f)                          ## Con Plot se visualiza en la consola el raster de sl de MK.

##===================================== 10. Exporta la tendencia a formato tiff de la zona de estudio.=============================================/

writeRaster(tau_ZN_NDVI_f, filename = 'tau_ZN_NDVI.tif', format= 'GTiff', overwrite = TRUE) ## Genera raster de la zona con valores de IVM (SAVI y NDVI) segun capa tau de tendencia MK.


writeRaster(sl_ZN_NDVI_f, filename = 'sl_ZN_NDVI.tif', format= 'GTiff', overwrite = TRUE) ## Genera raster de la zona con valores de IVM ( SAVI y NDVI) segun capa sl (p - valor) de MK.


## Nota: De los resultados obtenidos y explorados hasta esta sección del código, se logro observar que si se reclasifica, ##
## el tif se exporta con una zona externa que la reclasificación la reconoce con valor dentro de QGis. Sin embargo, no debería ser así.##
## No obstante, si se exporta sin reclasificar en R studio, la zona externa desaparece. Entonces se puede realizar la reclasificación de valores ##
## de tendencia (+1/-1) de forma manual en  QGis, para verificar las zonas con tendencia positiva, neutra y negativa. ##

## esta sección podría funcionar cuadno se tiene una zona establecida de dimensiones mayores a este estudio y despues realizar el corte 
## y reclasificación posterior para obtener un raster con valores optimos.

## Reclasificación de la ZN-NDVI periodo 2011-2020.

m_ZN <- c(-1, -0.25, -1, -0.25, 0.5, 0, 0.5, 1, 1)
rclmat_ZN <- matrix(m_ZN, ncol = 3, byrow = TRUE)
rc_tau_ZN_NDVI <- reclassify(kendal_result$tau, rclmat_ZN)

plot(rc_tau_ZN_NDVI)

writeRaster(rc_tau_ZN_NDVI, filename = 'rc_tau_ZN_NDVI.tif', format= 'GTiff', overwrite = TRUE)

##bibliografía:
## RStudio Team (2021). RStudio: Integrated Development for R. RStudio, PBC, Boston, MA URL http://www.rstudio.com/.
## McLeod, A.I. (2015). Kendall rank correlation and Mann-Kendall trend test. In Package ‘Kendall’ Ver. 2.2.  http://www.stats.uwo.ca/faculty/aim




