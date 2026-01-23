# =========================================================
# Título: Sesión 1 - Conociendo RStudio
# Propósito: Conocer RStudio
# =========================================================

#Conociendo el panel de RStudio

#https://docs.posit.co/ide/user/ide/guide/ui/ui-panes.html

#Código en R

View(mtcars)
summary(mtcars)
?mtcars
?summary
?View

library(help = "datasets")

View(Titanic)
?Titanic

data_titanic <- data.frame(Titanic)
sum(data_titanic$Freq)
aggregate(Freq ~ Sex, data = data_titanic, sum)

# =========================================================
# Título: Sesión 2 - Instalando librerias y cargando información
# Propósito: Conocer RStudio
# =========================================================





# 1. CARGA DE LIBRERÍAS ----
# Si no las tienen, deben instalarlas con: install.packages("here")
install.packages("here")
library(here)
library(tidyverse)

# 2. CONFIGURACIÓN DE RUTAS ----
# 'here' detecta automáticamente la raíz del proyecto
path_datos <- here("data", "raw", "titanic.csv")

# 3. LECTURA DE DATOS ----
# Usamos read_csv (del paquete tidyverse) porque es más rápido y limpio
# Asegúrate de haber puesto un archivo CSV en la carpeta data/raw/
datos <- read_csv(path_datos)

# 4. EXPLORACIÓN INICIAL ----
head(datos)    # Ver las primeras 6 filas
glimpse(datos) # Ver estructura de columnas y tipos de datos
str()

summary()

ggplot2::ggplot()

#PRUEBA


