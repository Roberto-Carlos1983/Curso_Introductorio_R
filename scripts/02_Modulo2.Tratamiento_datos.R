# =========================================================
# Título: Sesión 2 - Manipulación de información
# Propósito: Uso de funciones para el tratamiento de datos
# =========================================================

# 0. Uso del operador pipe |> (alt+shift+M)

# Limpiar nombres -> Filtrar -> Agrupar -> Resumir
base_matricula <- read.csv("data/raw/Muestra2025.csv")
names(base_matricula)
unique(base_matricula$COD_DEPARTAMENTO_CE)

#Todo con código base R
library(janitor)
base_matricula <- clean_names(base_matricula)
base_matricula <- filter(base_matricula,cod_departamento_ce == 1)

prueba <- filter(clean_names(base_matricula),cod_departamento_ce == 1)

resultado <- summarise(group_by(filter(clean_names(base_matricula), cod_departamento_ce == 1), distrito_ce), total = n())

#Paso a paso con creación de múltiples data frames intermedios

df1 <- clean_names(base_matricula)
df2 <- filter(df1, cod_departamento_ce == 1)
df3 <- group_by(df2, distrito_ce)
resultado_rev <- summarise(df3, total = n())

#Con la ayuda del operador pipe
# Se lee: "Toma la base, LUEGO limpia, LUEGO filtra..."
#ctrl+shift+M
library(tidyverse)

objeto_pipe <- base_matricula %>%
  clean_names() %>%
  filter(cod_departamento_ce == 1) %>%
  group_by(distrito_ce) %>%
  summarise(total = n())

# 1. Limpieza de nombres

#Primer ejemplo

library(tidyverse)
library(janitor)
library(here)

gira_musical <- read_csv("data/raw/my_file (1).csv")
View(gira_musical)
#ctrl+L
names(gira_musical)
unique(gira_musical$`Tour title`)

gira_musical_rev <- clean_names(gira_musical)
names(gira_musical_rev)

#names(gira_musical)[names(gira_musical)=="Adjusted gross (in 2022 dollars)"] <- "Adjusted gross (in $)"
#names(gira_musical)=="Adjusted gross (in 2022 dollars)"
#stringi::stri_escape_unicode(names(gira_musical))
#names(gira_musical)[names(gira_musical)=="Adjusted\u00a0gross (in 2022 dollars)"] <- "Adjusted gross (in $)"

#Segundo ejemplo
library(tidyverse)
library(janitor)

# Base con nombres "prohibidos" en R
datos_sucios <- tribble(
  ~"Nombre Completo", ~"Año/2023", ~"Ingreso ($)", ~"¿Tiene Hijos?",
  "Juan Pérez",        2023,       1200,          "Sí",
  "Ana López",         2023,       1500,          "No")

names(datos_sucios)

datos_limpios <- datos_sucios |> 
  clean_names()

datos_limpios2 <- clean_names(datos_sucios)

names(datos_limpios2)

# Tercer ejemplo
file.choose()
remesas <- readxl::read_xlsx("C:\\BK ROBERTO RODRIGUEZ\\MINED\\Capacitación_R\\Curso_Introductorio_R\\data\\raw\\Ingresos_mensuales_de_remesas_familiares.xlsx")
remesas <- readxl::read_xlsx(here("data", "raw","Ingresos_mensuales_de_remesas_familiares.xlsx"))

names(remesas)

remesas_limpio <- remesas |> 
  row_to_names(row_number = 3) |> 
  remove_empty(which = c("rows")) |> 
  clean_names()

remesas_limpio2 <- remesas_limpio[1,]

remesasadiciona <- data.frame(t(rep(NA,14)))

remesas <- rbind(remesas,remesasadiciona)

names(remesasadiciona) <- names(remesas)

remesas <- rbind(remesas,remesasadiciona)
remesas <- rbind(remesasadiciona,remesas,remesasadiciona)

remesas_limpio <- remesas |> 
  row_to_names(row_number = 4) |> 
  remove_empty(which = c("rows")) |> 
  clean_names()

# 1. Filtro de datos

# Primer ejemplo
install.packages("gapminder")
library(gapminder)

datos <- gapminder_unfiltered
View(datos)
glimpse(datos)
unique(datos$country)
library(tidyverse)

dplyr::filter()

el_salvador <- filter(datos,country=="El Salvador")

el_salvador2 <- datos |> 
  filter(country=="El Salvador")

prueba <- filter(datos,country=="El Salvador" | country=="Guatemala" | country=="Honduras")

triangulo_norte <- filter(datos,country %in% c("El Salvador","Guatemala","Honduras"))

ggplot2::ggplot(triangulo_norte,aes(x = lifeExp,y = gdpPercap))+
  geom_point()+
  facet_wrap(~country,scales="free_y")

#Segundo ejemplo
#Ingresos altos

summary(datos$gdpPercap)
unique(datos$year)

ingresos_altos <- filter(datos,year=="2002" & gdpPercap>12000)
class(datos$year)
datos$year==2002
summary(ingresos_altos$gdpPercap)

ggplot2::ggplot(ingresos_altos,aes(x = lifeExp,y = gdpPercap))+
  geom_point()

#Tercer ejemplo

no_asia <- filter(datos,continent!="Asia")

#Cuarto ejemplo
library(tidyverse)
library(here)
file.choose()

centros_educativos <- readxl::read_xlsx("data/raw/Centros_educativos.xlsx")

centros_educativos <- readxl::read_xlsx("C:\\BK ROBERTO RODRIGUEZ\\MINED\\Capacitación_R\\Curso_Introductorio_R\\data\\raw\\Centros_educativos.xlsx")

str_detect("ROBERTO 12","roberto")

str_detect(centros_educativos$NOMBRE_CE,"COMPLEJO")

centros_filtrados <- filter(centros_educativos,str_detect(NOMBRE_CE,"COMPLEJO"))

str_detect(centros_educativos$NOMBRE_CE,regex("complejo",ignore_case = TRUE))
#ctrl+shift+M |> 

filtrado <- centros_educativos |> 
  filter(str_detect(NOMBRE_CE, regex("milagro",ignore_case = TRUE)))

filtrado <- centros_educativos |> 
  filter(str_detect(NOMBRE_CE,"[0-9]"))

install.packages("stringi")
library(stringi)
stri_trans_general(centros_educativos$NOMBRE_CE,id = "Latin-ASCII")

str_detect(stri_trans_general(NOMBRE_CE,id = "Latin-ASCII"),"CANTON")

filtrado_rev <- centros_educativos |> 
  filter(str_detect(stri_trans_general(NOMBRE_CE,id = "Latin-ASCII"), regex("canton",ignore_case = TRUE)))

filtrado <- centros_educativos |> 
  filter(str_detect(str_to_lower(stri_trans_general(NOMBRE_CE, id = "Latin-ASCII")), "canton"))

# 2. Seleccionar columnas (variables)

# Primer ejemplo: selección por nombre
file.choose()
matricula <- read.csv("data/raw/Muestra2025.csv")

niveles_sexo <- matricula |> 
  select(NIVEL_EDUCATIVO,SEXO)

# Segundo ejemplo: selección por rango

relevantes <- matricula |> 
  select(CICLO:SEXO)

# Tercer ejemplo: quitar columnas

analisis <- matricula |> 
  select(-c(AÑO,GRADO))

select(-c(AÑO,GRADO))

# Cuarto ejemplo: para ordenar las variables

analisis_rev <- matricula |> 
  select(DISTRITO_CE,everything())

# Quinto ejemplo: seleccionar solo columnas de un tipo
glimpse(matricula)

numerico <- matricula |> 
  select(where(is.numeric))

texto <- matricula |> 
  select(where(is.character))

# Sexto ejemplo: nombres de variables con algun patrón
file.choose()
library(haven)

ehpm2024 <- haven::read_sav("C:\\BK ROBERTO RODRIGUEZ\\MINED\\EHPM\\Base de datos EHPM 2024 con área geográfica.sav")
ehpm2024 <- haven::read_sav("data/raw/Base de datos EHPM 2024 con área geográfica.sav")

var_relevantes <- ehpm2024 |> 
  select(starts_with("r2"))

# 3. Crear nuevas columnas o sobrescribir (variables)
mutate()

# Primer ejemplo: crear nueva variable
library(labelled)
library(tidyverse)

#ingresos_ehpm
busqueda <- look_for(ehpm2024,"ingreso")

ejemplo_ingreso <- ehpm2024 |> 
  select(ingreso_independientes,ingreso_agro,ingreso_pensiones,ingreso_remesas) |> 
  mutate(ingreso_independientes=if_else(is.na(ingreso_independientes),0,ingreso_independientes),
         ingreso_agro=if_else(is.na(ingreso_agro),0,ingreso_agro),
         ingreso_pensiones=if_else(is.na(ingreso_pensiones),0,ingreso_pensiones),
         ingreso_remesas=if_else(is.na(ingreso_remesas),0,ingreso_remesas),
         TOTAL_INGRESOS=ingreso_independientes+ingreso_agro+ingreso_pensiones+ingreso_remesas)

library(dplyr)

ejemplo_ingresos_rev <- ehpm2024 |> 
  select(ingreso_independientes,ingreso_agro,ingreso_pensiones,ingreso_remesas) |> 
  mutate(TOTAL_INGRESOS = rowSums(pick(ingreso_independientes, ingreso_agro, ingreso_pensiones, ingreso_remesas), na.rm = TRUE))
rowSums(objeto,na.rm = TRUE)

# Segundo ejemplo: sobrescribir
#llevar a minuscula una variable o quitar acentos

centros_minusculas <- centros_educativos |> 
  select(CÓDIGO_CE,NOMBRE_CE) |> 
  mutate(NOMBRE_minuscula=tolower(NOMBRE_CE),
         NOMBRE_mayuscula=toupper(NOMBRE_CE),
         NOMBRE_CE_corregida=stri_trans_general(NOMBRE_CE,id = "Latin-ASCII"),
         NOMBRE_CE=stri_trans_general(NOMBRE_CE,id = "Latin-ASCII")) |> 
  filter(str_detect(NOMBRE_CE_corregida,"CANTON"))

# Tercer ejemplo: uso de if_else o case_when
val_labels(ehpm2024$area)


regiones <- ehpm2024 |> 
  select(r004) |> 
  mutate(Region=case_when(r004 %in% c(1,2,3,4) ~ "Occidente",
                          r004==5 | r004==6 | r004==7 | r004==8 ~ "Centro_1",
                          r004==9 | r004==10 | r004==11 | r004==12 ~ "Centro_2",
                          r004==13 | r004==14 ~ "Oriente"))

regiones_rev <- ehpm2024 |> 
  select(r004,area) |> 
  mutate(Region=case_when(r004 %in% c(1,2,3,4) & area==1 ~ "Occidente_urbano",
                          r004==5 | r004==6 | r004==7 | r004==8 ~ "Centro_1",
                          r004==9 | r004==10 | r004==11 | r004==12 ~ "Centro_2",
                          TRUE ~ "Oriente"))
regiones |> 
  distinct(r004,Region)

#Crear regiones a partir de los departamentos

# Cuarto ejemplo: uso de .after y .before

ejemplo_ingreso <- ehpm2024 |> 
  select(ingreso_independientes,ingreso_agro,ingreso_pensiones,ingreso_remesas) |> 
  mutate(ingreso_independientes=if_else(is.na(ingreso_independientes),0,ingreso_independientes),
         ingreso_agro=if_else(is.na(ingreso_agro),0,ingreso_agro),
         ingreso_pensiones=if_else(is.na(ingreso_pensiones),0,ingreso_pensiones),
         ingreso_remesas=if_else(is.na(ingreso_remesas),0,ingreso_remesas),
         TOTAL_INGRESOS=ingreso_independientes+ingreso_agro+ingreso_pensiones+ingreso_remesas,.before = ingreso_independientes)

ejemplo_ingreso <- ehpm2024 |> 
  select(ingreso_independientes,ingreso_agro,ingreso_pensiones,ingreso_remesas) |> 
  mutate(ingreso_independientes=if_else(is.na(ingreso_independientes),0,ingreso_independientes),
         ingreso_agro=if_else(is.na(ingreso_agro),0,ingreso_agro),
         ingreso_pensiones=if_else(is.na(ingreso_pensiones),0,ingreso_pensiones),
         ingreso_remesas=if_else(is.na(ingreso_remesas),0,ingreso_remesas),
         TOTAL_INGRESOS=ingreso_independientes+ingreso_agro+ingreso_pensiones+ingreso_remesas) |> 
  select(TOTAL_INGRESOS,everything())

#Crear una variable y moverla a un lugar en específico

# 4. Limpiar nombres, filtrar, seleccionar y crear
# Primer ejemplo: Base de datos de casas

install.packages("AmesHousing")
library(AmesHousing)
?ames_raw
library(janitor)
library(stringi)
library(tidyverse)

# Cargar los datos brutos

ames_raw <- data.frame(ames_raw)

glimpse(ames_raw)
unique(ames_raw$Neighborhood)
unique(ames_raw$SalePrice)
unique(ames_limpia$year_built)
unique(ames_limpia$yr_sold)
unique(ames_limpia$neighborhood)

ames_limpia <- ames_raw |> 
  # Limpieza de nombres
  clean_names() |> 
  
  # Limpiar el texto en la columna de vecindarios
  mutate(neighborhood = str_trim(neighborhood)) |> 
  
  # Filtrar casas en vecindarios cercanos a la universidad
  # Buscamos College Creek
  filter(str_detect(neighborhood, "Coll")) |> 
  
  # Crear variables nuevas
  mutate(total_metros=(x1st_flr_sf+x2nd_flr_sf)*0.092903,
         precio_m2 = sale_price / total_metros,
         antiguedad = yr_sold - year_built,
         es_nueva = if_else(antiguedad <= 5, "Sí", "No")) |> 
  
  # Seleccionar y organizar
  select(neighborhood, sale_price, precio_m2, antiguedad, es_nueva, everything()) |> 
  relocate(sale_price, .after = es_nueva)

# Ver el resultado
View(ames_limpia)

# Segundo ejemplo: base de diamantes

library(tidyverse)
?diamonds

diamantes <- data.frame(diamonds)
glimpse(diamantes)
unique(diamantes$cut)

diamantes |> 
  count(cut)
13791+21551

diamantes_buenos <- diamantes |> 
  filter(cut %in% c("Premium","Ideal","Good")) |> 
  group_by(cut) |> 
  summarise(Precio_promedio=mean(price),
            Largo_promedio=median(x),
            Número_diamante=n()) |> 
  select(Número_diamante,everything())

diamantes_buenos_color <- diamantes |> 
  filter(cut %in% c("Premium","Ideal","Good")) |> 
  group_by(cut,color) |> 
  summarise(Precio_promedio=mean(price),
            Largo_promedio=median(x),
            Número_diamante=n()) |> 
  select(Número_diamante,everything())

# 5. Ejemplos del group_by

# Primer ejmeplo: Suma de casos por departamento

base_matricula <- read.csv("data/raw/Muestra2025.csv")

datos_depto <- base_matricula |> 
  group_by(DEPARTAMENTO_CE) |> 
  summarise(Dato=n())
View(datos_depto)

datos_depto_distrito <- base_matricula |> 
  group_by(DEPARTAMENTO_CE,DISTRITO_CE) |> 
  summarise(Dato=n()) |> 
  mutate(Total_depto=sum(Dato))
View(datos_depto_distrito)

datos_depto_distrito <- base_matricula |> 
  group_by(DEPARTAMENTO_CE,DISTRITO_CE) |> 
  summarise(Dato=n(),.groups = "keep") |>  #Incorporamos .groups= = "keep" 
  mutate(Total_depto=sum(Dato))
View(datos_depto_distrito)

datos_depto_distrito <- base_matricula |> 
  group_by(DEPARTAMENTO_CE,DISTRITO_CE) |> 
  summarise(Dato=n(),.groups = "drop_last") |>  #Incorporamos .groups= = "drop_last" 
  mutate(Total_depto=sum(Dato),
         Representacion=(Dato/Total_depto)*100)
View(datos_depto_distrito)

datos_depto_distrito <- base_matricula |> 
  group_by(DEPARTAMENTO_CE,DISTRITO_CE) |> 
  summarise(Dato=n(),.groups = "drop") |>  #Incorporamos .groups= = "drop" 
  mutate(Total_depto=sum(Dato))
View(datos_depto_distrito)

datos_depto_distrito <- base_matricula |> 
  group_by(DEPARTAMENTO_CE,DISTRITO_CE) |> 
  summarise(Dato=n(),.groups = "keep") |>
  ungroup() |> 
  mutate(Total_nal=sum(Dato))
View(datos_depto_distrito)

base_matricula |> 
  mutate(total=n())

# 6. Uso de left_join, semi_join, anti_join

# Primer ejemplo: left_join y full_join

regular <- readxl::read_xlsx("data/raw/matricula_regular.xlsx")
mod_flexible <- readxl::read_xlsx("data/raw/matricula_flexible.xlsx")
especial <- readxl::read_xlsx("data/raw/matricula_especial_1.xlsx")

sum(regular$Matricula)
sum(mod_flexible$Matricula_flexibles)
sum(especial$Matricula_especial)

total <- regular |> 
  left_join(mod_flexible,by = c("EDAD_JUNIO" = "EDAD_JUNIO",
                                "SEXO" = "SEXO")) |> 
  left_join(especial,by = c("EDAD_JUNIO" = "AÑOS_JUNIO",
                            "SEXO" = "sexo")) |> 
  mutate(Total=rowSums(pick(Matricula,Matricula_flexibles,Matricula_especial),na.rm = TRUE))

sum(total$Matricula)
sum(total$Matricula_flexibles,na.rm = TRUE)
sum(total$Matricula_especial,na.rm = TRUE)

total <- regular |> 
  full_join(mod_flexible,by = c("EDAD_JUNIO" = "EDAD_JUNIO",
                                "SEXO" = "SEXO")) |> 
  full_join(especial,by = c("EDAD_JUNIO" = "AÑOS_JUNIO",
                            "SEXO" = "sexo")) |> 
  mutate(Total=rowSums(pick(Matricula,Matricula_flexibles,Matricula_especial),na.rm = TRUE))

sum(total$Matricula,na.rm = TRUE)
sum(total$Matricula_flexibles,na.rm = TRUE)
sum(total$Matricula_especial,na.rm = TRUE)

especial <- readxl::read_xlsx("data/raw/matricula_especial_2.xlsx")
rm(total)

total <- regular |> 
  full_join(mod_flexible,by = c("EDAD_JUNIO" = "EDAD_JUNIO",
                                "SEXO" = "SEXO")) |> 
  full_join(especial,by = c("EDAD_JUNIO" = "AÑOS_JUNIO",
                            "SEXO" = "sexo")) |> 
  mutate(Total=rowSums(pick(Matricula,Matricula_flexibles,Matricula_especial),na.rm = TRUE))

# Segundo ejemplo: left_join

# install.packages("nycflights13")
library(tidyverse)
library(nycflights13)
?flights

# Tabla IZQUIERDA (Principal): 100 vuelos aleatorios
set.seed(123)
mis_vuelos <- flights |> 
  select(year, month, day, tailnum, carrier) |> 
  sample_n(100)

# Tabla DERECHA (Complementaria): Información de los aviones
# Esta tabla tiene el año de fabricación (year) y el modelo
info_aviones <- planes |> 
  select(tailnum, year_built = year, model, engines)

vuelos_enriquecidos <- mis_vuelos |> 
  left_join(info_aviones, by = "tailnum")

vuelos_enriquecidos <- left_join(mis_vuelos,info_aviones, by = "tailnum")

# Tecer ejemplo: anti_join

# ¿Qué aviones de mis vuelos no tienen información en la tabla de aviones?
aviones_perdidos <- mis_vuelos |> 
  anti_join(info_aviones, by = "tailnum") |> 
  distinct(tailnum)

print(aviones_perdidos)

# Cuarto ejemplo: inner_join

library(tidyverse)
library(nycflights13)

# Tenemos nuestra tabla de vuelos (muchas filas)
mis_vuelos <- flights |> select(tailnum, carrier, flight)

# Tenemos nuestra tabla de aviones (catálogo)
info_aviones <- planes |> select(tailnum, model, year)

# Ejecutamos el INNER JOIN
vuelos_completos <- mis_vuelos |> 
  inner_join(info_aviones, by = "tailnum")
View(vuelos_completos)



  




