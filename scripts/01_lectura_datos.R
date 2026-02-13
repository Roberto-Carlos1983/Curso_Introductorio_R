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
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point() + 
  labs(title = "Gráfico con ggplot2") +
  theme_minimal()

# 2. Configuración de rutas para lectura de archivos

# Con setwd, usar doble \\ en cada lugar donde se ingrese a una nueva carpeta
setwd("")

# Trabajando por proyectos, todo archivo guargado en la misma carpeta del proyecto
# se cargará de forma directa. Si está dentro de una carpeta, se genera el código 
# con la identificación de la carpeta
read.csv("base_datos.csv")
read.csv("dataset/ultimos/base_datos.csv")

# 3. Lectura de datos

read.csv()

library(readxl)
read_xlsx()
readxl::read_xlsx()

library(foreign)
read.spss()
foreign::read.spss()

haven::read_stata()

#Si no se trabaja por proyectos, file.choose() es util para ubicar la ruta en el computador
#Se ejecuta file.choose() sin ningún argumento
 
file.choose()

datos <- read_csv("copiar ruta")

library(here)
here()
matricula <- read.csv(here("data", "raw","Muestra2025.csv"))

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

