library(ggplot2)  # Cargar ggplot2 para gráficos

# Fijar semilla para reproducibilidad
set.seed(123)

# Generar datos normales con algunos valores atípicos
produccion <- data.frame(
  Unidades = c(rnorm(50, mean = 500, sd = 50),  # 50 valores dentro del rango normal
               800, 850, 900,  # Valores atípicos altos
               200, 150)  # Valores atípicos bajos
)

ggplot(produccion, aes(y = Unidades)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  labs(title = "Diagrama de Caja de Producción",
       y = "Unidades Producidas") +
  theme_minimal()

# Calcular Q1 y Q3
Q1 <- quantile(produccion$Unidades, 0.25)
Q3 <- quantile(produccion$Unidades, 0.75)
IQR <- Q3 - Q1  # Rango intercuartil

# Definir límites
limite_inferior <- Q1 - 1.5 * IQR
limite_superior <- Q3 + 1.5 * IQR

# Filtrar valores atípicos
outliers <- produccion$Unidades[produccion$Unidades < limite_inferior | produccion$Unidades > limite_superior]
print(outliers)  # Muestra los valores atípicos detectados

produccion_sin_outliers <- produccion[produccion$Unidades >= limite_inferior & produccion$Unidades <= limite_superior, ]

summary(produccion$Unidades)  # Estadísticas antes de tratamiento
