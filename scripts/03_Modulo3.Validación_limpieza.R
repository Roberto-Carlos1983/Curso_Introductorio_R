# =========================================================
# Título: Sesión 3- Validación y limpieza
# Propósito: Aprender algunas herramientas para realizar limpieza de información
# =========================================================

# 1. Modificando variables a un formato de fecha adecuado

#SPSS cuenta los segundos que han pasado desde el inicio del Calendario Gregoriano (14 de octubre de 1582).
#Cambiar fechas con números de SPSS a date en R
file.choose()
base_fechas <- foreign::read.spss("C:\\BK ROBERTO RODRIGUEZ\\MINED\\Capacitación_R\\Curso_Introductorio_R\\data\\raw\\Fechas.sav",to.data.frame = TRUE)
class(base_fechas$est_fecha_nacimiento)

base_fechas <- base_fechas |> 
  mutate(Fecha_corregida=as.POSIXct(est_fecha_nacimiento, origin="1582-10-14", tz="GMT"))

#Cambiar fechas con formato de caracter a date en R
base_fechas <- base_fechas |> 
  mutate(Fecha_texto=as.character(Fecha_corregida))
glimpse(base_fechas)

base_fechas <- base_fechas |> 
  mutate(Fecha_nueva=as.Date(Fecha_texto,format = "%Y-%m-%d"))
glimpse(base_fechas)

#%b mes abreviado (MAY)
#%y año con dos digitos

#Cambiar fechas con formato de número de Excel a date en R

library(tidyverse)
library(lubridate)

# Simulación de datos importados de Excel
datos_excel <- tibble(
  id_estudiante = 1:5,
  fecha_excel = c(45321, 45382, 45413, 45290, 45350))

# La solución para tu lámina
datos_corregidos <- datos_excel |> 
  mutate(fecha_real = as.Date(fecha_excel, origin = "1899-12-30"))




