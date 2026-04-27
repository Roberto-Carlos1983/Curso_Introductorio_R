# =========================================================
# Título: Sesión 4- Gráficos
# Propósito: Aprender la lógica de ggplot2 y librerias para gráficos interactivos
# =========================================================

# 1. Gráfico de barras (geom_bar)

library(tidyverse)
?mpg
unique(mpg$class)
unique(mpg$drv)

mpg |> 
  count(class)

ggplot(data = mpg, mapping = aes(x = class, fill = drv)) +
  geom_bar(position = "dodge", color = "black", alpha = 0.5) + 
  labs(title = "Distribución de clases de vehículos",
       subtitle = "Segmentado por tipo de tracción (drv)",
       x = "Clase de vehículo",
       y = "Conteo de unidades",
       fill = "Tipo de Tracción") +
  theme_minimal()

ggplot(data = mpg, mapping = aes(x = class, fill = drv)) +
  geom_bar(position = "dodge", color = "black", alpha = 0.5) + 
  labs(title = "Distribución de clases de vehículos",
       subtitle = "Segmentado por tipo de tracción (drv)",
       x = "Clase de vehículo",
       y = "Conteo de unidades",
       fill = "Tipo de Tracción") +
  theme_minimal() + 
  theme(legend.position = "bottom")

#Cambios en el parámetros position

ggplot(data = mpg, mapping = aes(x = class, fill = drv)) +
  geom_bar(position = "stack", mapping = aes(color = "black"), alpha = 0.3) +
  theme_bw()

ggplot(data = mpg, mapping = aes(x = class, fill = drv)) +
  geom_bar(position = "fill", color = "black", alpha = 0.9) +
  theme_void()

ggplot(data = mpg, mapping = aes(x = class, fill = drv)) +
  geom_bar(position = "identity", alpha = 0.5) +
  theme_light()

# 2. Gráfico de barras (geom_col)

resumen_datos <- mpg |> 
  group_by(class) |> 
  summarise(total = n())

# Ahora graficamos con geom_col
ggplot(data = resumen_datos, mapping = aes(x = class, y = total)) +
  geom_col(fill = "lightblue") +
  labs(title = "Uso de geom_col (Tú le das el número exacto)")

# 3.Gráfico de lineas

library(tidyverse)
?economics

ggplot(data = economics, mapping = aes(x = date, y = unemploy)) +
  geom_line(color = "darkblue",
            linewidth = 1.2,
            linetype = "solid") +
  scale_x_date(date_breaks = "5 years",
               date_labels = "%Y") +
  labs(title = "Evolución del Desempleo en EE.UU.",
       subtitle = "Uso correcto del parámetro linewidth",
       x = "Línea de Tiempo (Años)",
       y = "Número de Desempleados") +
  theme_bw()

# 3.Box-plot

ggplot(data = mpg, mapping = aes(x = class, y = hwy, fill = class)) +
  geom_boxplot(outlier.colour = "red",
               outlier.shape = 5,
               outlier.size = 2,
               show.legend = FALSE) +
  facet_wrap(facets = vars(year), ncol = 1) + 
  coord_flip() +
  labs(title = "Eficiencia en autopista por clase de auto",
       subtitle = "Comparativa entre los años 1999 y 2008",
       x = "Categoría del vehículo",
       y = "Millas por galón (hwy)") +
  theme_light()
#vars(year)

# 4. Gráfico de dispersion: interactivo

library(plotly)

# Creamos el objeto ggplot de forma explícita
grafico_base <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = class)) +
  geom_point(size = 3, alpha = 0.6, shape = 16) +
  labs(title = "Relación Cilindrada vs Eficiencia",
       x = "Tamaño del Motor (litros)",
       y = "Millas por Galón",
       color = "Categoría") +
  theme_minimal()

# Convertimos a dinámico
ggplotly(p = grafico_base)

# 5. Gráfico de dispersion: interactivo

# install.packages("plotly")
library(plotly)

fig <- plot_ly(
  data = iris, 
  x = ~Sepal.Length, 
  y = ~Sepal.Width, 
  z = ~Petal.Length, 
  color = ~Species,      # Mapeo de color por variable
  colors = c('#BF382A', '#0C4B8E', '#2CA02C'), # Colores específicos
  type = 'scatter3d',    # Tipo de gráfico: Dispersión 3D
  mode = 'markers',      # Puntos (marcadores)
  marker = list(size = 5, opacity = 0.8) # Parámetros del punto
)

# Personalizar el diseño (Layout)
fig <- fig %>% layout(
  title = "Análisis 3D de Iris",
  scene = list(
    xaxis = list(title = 'Largo Sépalo'),
    yaxis = list(title = 'Ancho Sépalo'),
    zaxis = list(title = 'Largo Pétalo')
  )
)

fig

plot_ly(
  data = mpg, 
  x = ~displ, 
  y = ~hwy, 
  color = ~class, 
  type = "scatter", 
  mode = "markers",
  text = ~paste("Modelo: ", model) # Información extra al pasar el mouse
) %>%
  layout(
    title = "Eficiencia vs Cilindrada (Interactivo)",
    xaxis = list(title = "Motor (L)"),
    yaxis = list(title = "Millas por Galón")
  )

