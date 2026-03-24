# =========================================================
# Título: Sesión 1 - Manipulación de información
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
  
objeto_pipe <- base_matricula |>
  clean_names() |> 
  filter(cod_departamento_ce == 1) |> 
  group_by(distrito_ce) |> 
  summarise(total = n())

# 1. Limpieza de nombres

#Primer ejemplo

library(tidyverse)
library(janitor)
library(here)

gira_musical <- read_csv(here("data/raw/my_file (1).csv"))
names(gira_musical)
unique(gira_musical$`All Time Peak`)
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

names(datos_limpios)

# Tercer ejemplo

remesas <- readxl::read_xlsx(here("data", "raw","Ingresos_mensuales_de_remesas_familiares.xlsx"))

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
glimpse(datos)
unique(datos$country)

el_salvador <- filter(datos,country=="El Salvador")
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

base <- matricula |> 
  filter(str_detect(nombre_ce, "Complejo"))






