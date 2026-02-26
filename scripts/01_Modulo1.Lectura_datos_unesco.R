#Página UNESCO
#https://api.uis.unesco.org/api/public/documentation/

#Cargar librerias
#Si no se tiene instalada previamente, correr la función
#install.packages("","")

library(tidyverse)  #data wrangling
library(httr)       #tools for working with URLs and HTTP
library(jsonlite)   #convert the json output to data frames 
library(DT)         #interactive output tables

#Carga de indicadores y países específicos----

#Definir la URL

url <- "https://api.uis.unesco.org/api/public/data/indicators"

queryString <- list(
  indicator = "NERT.1.CP,NERT.2.CP,NERT.3.CP",
  geoUnit = "SLV",
  geoUnitType = "NATIONAL",
  start = "2005",
  end = "2024",
  indicatorMetadata = "true")

response <- VERB("GET",
                 url,
                 query = queryString,
                 accept("application/json"))

text <- httr::content(response,as = "text",encoding = "UTF-8")

indicatorsdf <- jsonlite::fromJSON(text, flatten = TRUE)

datos <- indicatorsdf$records
nombres_codigos <- indicatorsdf$indicatorMetadata

datos <- datos |> 
  left_join(nombres_codigos |>
              select(indicatorCode,name),
            by=c("indicatorId"="indicatorCode")) |> 
  select(-magnitude,-qualifier)
View(datos)

#Carga de todos los indicadores de un país específico----

#Definir la URL

url <- "https://api.uis.unesco.org/api/public/data/indicators?geoUnit=SLV&indicatorMetadata=true"

response <- VERB("GET",
                 url,
                 accept("application/json"))

text <- httr::content(response,as = "text",encoding = "UTF-8")

indicatorsdf <- jsonlite::fromJSON(text, flatten = TRUE)

datos <- indicatorsdf$records
nombres_codigos <- indicatorsdf$indicatorMetadata

datos <- datos |> 
  left_join(nombres_codigos |>
              select(indicatorCode,name),
            by=c("indicatorId"="indicatorCode")) |> 
  select(-magnitude,-qualifier)
View(datos)

#Exportar información en formato Excel----

# 1. Crear el objeto con la información filtrada
filtrado <- filter(datos,indicatorId=="NERT.1.F.CP")
#Si es más de un indicador, entonces correr el siguiente código (eliminar el signo numeral de la siguiente línea para quitar el comentario):
filtrado <- filter(datos,indicatorId %in% c("NERT.1.F.CP","NERT.1.M.CP") )

# 2. Definir donde se guardará la información. Se debe copiar la ruta donde se
#exportará la información utilizando esta barra / al separador de carpetas
setwd("C:/BK ROBERTO RODRIGUEZ/MINED/UNESCO_datos")

# 3. Exportar
writexl::write_xlsx(filtrado,"Nombre_archivo.xlsx")

