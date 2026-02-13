# =========================================================
# Título: Sesión 1 - R y RStudio
# Propósito: Comenzar a conocer R en el entorno RStudio
# =========================================================

#R el lenguaje y RStudio la interfaz para ejecutar código R
#Entorno de Desarrollo Integrado (Integrated Development Environment (IDE))

# 1. Conociendo el panel de RStudio

#https://docs.posit.co/ide/user/ide/guide/ui/ui-panes.html

# 2. Código en R

#Primer ejemplo
View(mtcars)
summary(mtcars, digits=3)
?mtcars
?summary
?View

#Datasets disponibles pre cargados en RStudio
library(help = "datasets")

#Segundo ejemplo
View(Titanic)
?Titanic
data_titanic <- data.frame(Titanic)
sum(data_titanic$Freq)
aggregate(Freq ~ Sex+Survived, data = data_titanic, sum)
?aggregate

#Tercer ejemplo
iris
?iris
table(iris$Sepal.Width, iris$Species)
data_iris <- data.frame(iris)
data_iris |> 
  dplyr::group_by(Species,Sepal.Width) |> 
  dplyr::summarise(Ancho=dplyr::n()) |> 
  print(n=100)

#Cuarto ejemplo
matricula <- read.csv("data/raw/Muestra2025.csv")
table(matricula$NIVEL_EDUCATIVO)

ggplot(matricula,aes(x = NIVEL_EDUCATIVO)) +
  geom_bar()

plotly::plot_ly(matricula,
                x = ~NIVEL_EDUCATIVO,
                type = "histogram")

# =========================================================
# Título: Sesión 2 - Librerias, instalación de librerias y cargando información
# Propósito: Conocer herramientas para uso de R
# =========================================================

#Comprehensive R Archive Network (CRAN)
#Libreria: conjunto de funciones, conjunto de datos, y código R predeterminado

# 1. Carga de librerias
#1ra vez: instalar y después llamar a la librería
#Librería ya instalada: llamar a la librería

install.packages("here")
library(here)
install.packages("tidyverse")
library(tidyverse)

ls("package:dplyr")

#Primer ejemplo
data_titanic[2,]
data_titanic |> 
  slice(2)

data_titanic[10:13,"Class"]
data_titanic |> 
  slice(10:13)

#Segundo ejemplo

library(dplyr)
?mtcars
table(mtcars$cyl)
#Código base R
resultado_base <- mtcars[mtcars$cyl > 6, ]
#Código paquete dplyr
resultado_tidy <- mtcars %>% 
  filter(cyl > 6)

#Tercer ejemplo

#Código base R
plot(mtcars$wt, mtcars$mpg, main="Gráfico Base")

#Código paquete ggplot2
library(ggplot2)
mtcars
ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(cyl), shape = factor(cyl))) + 
  geom_point() + 
  labs(title = "Gráfico con ggplot2") +
  theme_minimal() +
  scale_colour_manual(values = c("4" = "#fee0d2", 
                                 "6" = "#fc9272", 
                                 "8" = "#de2d26"))

#https://r-charts.com/colors/
#https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3

ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(cyl), shape = factor(cyl))) + 
  geom_point(size = 3) + 
  labs(title = "Paleta: ColorBrewer (Set1)") +
  theme_minimal() +
  # Cambia 'manual' por 'brewer' y elige una paleta
  scale_colour_discrete()
#scale_colour_discrete()
#scale_colour_viridis_d()
#scale_colour_brewer(palette = "Set1")

# 2. Configuración de rutas para lectura de archivos

#Configuración con ruta extensa
# Con setwd, usar doble \\ en cada lugar donde se ingrese a una nueva carpeta
setwd("")

#Si no se trabaja por proyectos, file.choose() es util para ubicar la ruta en el computador
#Se ejecuta file.choose() sin ningún argumento

file.choose()

datos <- read_csv("copiar ruta")

#Configuración con ruta relativa
# Trabajando por proyectos, todo archivo guargado en la misma carpeta del proyecto
# se cargará de forma directa. Si está dentro de una carpeta, se genera el código 
# con la identificación de la carpeta
read.csv("base_datos.csv")
read.csv("dataset/ultimos/base_datos.csv")

# 3. Lectura de datos

#Lectura de archivos en formato CSV
read.csv()
file.choose()
matricula <- read.csv()

#Lectura de archivos en formato Excel
library(readxl)
read_xlsx()
readxl::read_xlsx()
remesas <- readxl::read_xlsx("data/raw/Ingresos_mensuales_de_remesas_familiares.xlsx")
library(here)
here()
remesas <- readxl::read_xlsx(here("data", "raw","Ingresos_mensuales_de_remesas_familiares.xlsx"))

#Lectura de archivos en formato SPSS
library(foreign)
read.spss()
foreign::read.spss()
ehpm2024 <- read.spss("data/raw/EHPM 2024.sav")

library(haven)
haven::read_stata()
ehpm2024 <- read_sav("data/raw/EHPM 2024.sav")
class(ehpm2024$r107)
table(ehpm2024$r107)

#Lectura desde una página web
# 1. Instalar y cargar la librería
install.packages("rvest")
library(rvest)
# 2. Definir la URL
url <- "https://estadisticas.bcr.gob.sv/serie/ingresos-mensuales-de-remesas-familiares"

# 3. Leer el HTML y extraer las tablas
pagina <- read_html(url)
tablas <- html_table(pagina)

# 4. Ver donde están los datos y apuntar al número de la tabla
tablas
remesas_web <- tablas[[3]]

# 4. Exploración inicial ----
carros <- data.frame(mtcars)

head(carros)
tail(carros)    # Ver las primeras 6 filas

library(tidyverse)
glimpse(carros) # Ver estructura de columnas y tipos de datos
str(carros)
class(carros$mpg)
class(carros$gear)
summary(carros)

library(foreign)
ehpm2024 <- read.spss("data/raw/EHPM 2024.sav")

library(haven)
ehpm2024 <- read_sav("data/raw/EHPM 2024.sav")
class(ehpm2024$r107)
table(ehpm2024$r107)

library(labelled)
var_label(ehpm2024$r107)
val_labels(ehpm2024$r107)
print_labels(ehpm2024$r107)

# Buscar variables de análisis
library(labelled)
busqueda <- look_for(ehpm2024, "subempleo")
print(busqueda)

