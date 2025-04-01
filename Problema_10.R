# Cargar librería necesaria**
# -------------------------------
library(dplyr)  # Para manipulación de datos

# -------------------------------
# Generar un dataframe de ejemplo**
# -------------------------------
set.seed(123)  # Fijar semilla para reproducibilidad

data <- data.frame(
  ID = 1:10,
  Satisfaccion = sample(c("baja", "media", "alta"), 10, replace = TRUE),
  Servicio = sample(c("A", "B", "C"), 10, replace = TRUE)
)

# -------------------------------
# Convertir variables categóricas en factores**
# -------------------------------
data$Satisfaccion <- as.factor(data$Satisfaccion)
data$Servicio <- as.factor(data$Servicio)

# -------------------------------
# Aplicar codificación One-Hot**
# -------------------------------
one_hot_encoded <- model.matrix(~ Satisfaccion + Servicio - 1, data = data)

# -------------------------------
# Mostrar el dataframe original y el transformado**
# -------------------------------
cat("Data original:\n")
print(data)

cat("\nData codificada:\n")
print(one_hot_encoded)

# -------------------------------
# Evaluar el impacto en modelos de regresión**
# -------------------------------
# Agregar una variable de respuesta ficticia
data$Score <- rnorm(10, mean = 50, sd = 10)

# Ajustar un modelo de regresión lineal
modelo <- lm(Score ~ ., data = as.data.frame(one_hot_encoded))

# Mostrar resumen del modelo
cat("\nResumen del modelo de regresión:\n")
print(summary(modelo))
