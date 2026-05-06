# =========================================================
# Título: Sesión 5- EHPM, Censo de Población y Vivienda y uso de Quarto
# Propósito: Aprender los aspéctos básicos para analizar la EHPM y el Censo, y conocer de manera introductoria Quarto
# =========================================================

# 1. Encuesta de Hogares de Propósitos Múltiples
#https://onec.bcr.gob.sv/encuesta-de-hogares-de-propositos-multiples-ehpm/

#Unidad Primaria de Muestreo: lote
#Unidad Secundaria de Muestreo: idboleta
#Variable de estratificación: estratoarea
#Factor de expansión: fac00
library(haven)

file.choose()
ehpm2025 <- haven::read_sav("C:\\BK ROBERTO RODRIGUEZ\\MINED\\EHPM\\Base de datos EHPM 2025.sav")
length(unique(ehpm2025$estratoarea))

#Con srvyr package
install.packages("srvyr")
library(srvyr)

disenio_srvyr <- ehpm2025 |> 
  as_survey_design(
    ids     = c(lote, idboleta),  # UPM + USM
    strata  = estratoarea,        # Variable de estratificación
    weights = fac00,              # Factor de expansión
    nest    = TRUE                # IDs de lote se anidan dentro de cada estrato
  )

summary(disenio_srvyr)

#Con survey package
install.packages("survey")
library(survey)

disenio_survey <- svydesign(
  ids      = ~lote + idboleta,   # PSU + SSU (two-stage)
  strata   = ~estratoarea,       # Variable de estratificación
  weights  = ~fac00,             # Factor de expansión
  data     = ehpm2025,
  nest     = TRUE                # Los IDs de lote se anidan dentro de cada estrato
)

summary(disenio_survey)

# Población total

# Con srvyr
disenio_srvyr |> 
  summarise(total = survey_total())

# Con survey
sum(ehpm2025$fac00)
disenio_survey <- update(disenio_survey, valor = 1)
svytotal(~valor, disenio_survey)

#Población por sexo
labelled::look_for(ehpm2025,"sexo")

disenio_srvyr$variables$
names(disenio_srvyr$variables)
disenio_srvyr$variables

# Con srvyr
disenio_srvyr |> 
  group_by(r104) |> 
  summarise(total = survey_total())

# Con survey
svyby(
  formula = ~valor,        # Variable a totalizar
  by      = ~r104,       # Variable de agrupación
  design  = disenio_survey,
  FUN     = svytotal)

#Población que estudia actualmente

#Con srvyr

labelled::look_for(ehpm2025,"estudia")

estudia_sexo <- disenio_srvyr |> 
  filter(r106>=4) |> 
  group_by(r104,r203) |> 
  summarise(total = survey_total())
writexl::write_xlsx(estudia_sexo,"Reporte1.xlsx")

labelled::look_for(ehpm2025,"departamento")

disenio_srvyr |> 
  group_by(r004,r104,r203) |> 
  summarise(total = survey_total())

# Con survey
svyby(
  formula = ~valor,        # Variable a totalizar
  by      = ~r004+r104+r203,       # Variable de agrupación
  design  = disenio_survey,
  FUN     = svytotal)

labelled::var_label(ehpm2025$r201a)

disenio_srvyr |> 
  filter(r106<4) |> 
  group_by(r104,r201a) |> 
  summarise(total = survey_total())

# 2. Censo de Población y Vivienda
#https://poblacion.bcr.gob.sv/

cnpv2024 <- haven::read_sav("C:\\BK ROBERTO RODRIGUEZ\\MINED\\CNPV 2024 BCR\\Base_de_datos_CPV_2024_SV_SPSS\\Base de datos de población - CPV 2024 SV.sav")

#Filtrando grupos poblacionales para luego calcular datos

pob10ymas <- cnpv2024 |> 
  filter(P02_3_EDAD>=10)

pob15ymas <- filter(cnpv2024,P02_3_EDAD>=15)

#Escolaridad promedio

mean(pob10ymas$P10_2_ANIOS_ESTUDIOS,na.rm = TRUE)
pob10ymas %>% 
  group_by(P02_2_SEXO) %>% 
  summarise(escolaprom=mean(P10_2_ANIOS_ESTUDIOS,na.rm=TRUE))

mean(pob15ymas$P10_2_ANIOS_ESTUDIOS,na.rm = TRUE)

pob15ymas |>  
  group_by(P02_2_SEXO) %>% 
  summarise(escolaprom=mean(P10_2_ANIOS_ESTUDIOS,na.rm=TRUE))

#Alfabetizacion

cnpv2024 %>% 
  filter(P02_3_EDAD>=15) %>% 
  group_by(DEPTO,P12_ANALFABETISMO) %>% 
  summarise(dato=n()) |> 
  print(n=100)

#Función para grafico
library(tidyverse)
glimpse(cnpv2024)
library(labelled)
var_label(cnpv2024$DEPTODESC)
val_labels(cnpv2024$DEPTODESC)

departamento <- cnpv2024 |> 
  group_by(DEPTODESC,P02_2_SEXO) |> 
  summarise(Personas=n())

departamento <- cnpv2024 |> 
  mutate(P02_2_SEXO=as_factor(P02_2_SEXO),
         DEPTODESC=as_factor(DEPTODESC)) |> 
  group_by(DEPTODESC,P02_2_SEXO) |> 
  summarise(Personas=n())

ggplot(departamento,aes(x = factor(P02_2_SEXO),y = Personas)) +
  geom_col() +
  facet_wrap(~DEPTODESC)
  
# 3. Quarto

#https://quarto.org/docs/get-started/

install.packages("quarto")
install.packages("knitr")
install.packages("rmarkdown")
library(quarto)
library(knitr)
library(rmarkdown)

YAML







