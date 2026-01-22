# =========================================================
# Título: Sesión 1 - Lectura y Validación Inicial
# Propósito: Cargar bases de datos de matrícula 2026
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


