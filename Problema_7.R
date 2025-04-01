# ---------------------------------------
# **1️⃣ Cargar el dataset de indicadores financieros**
# ---------------------------------------
df <- read.csv("empresa.csv")

# Seleccionar solo columnas numéricas para el análisis
columnas_numericas <- df[, c("Ingresos", "utilidadNeta", "margenNeto", "ROE", "Liquidez", "Endeudamiento", "PERatio")]

# ---------------------------------------
# **2️⃣ Aplicar estandarización utilizando scale()**
# ---------------------------------------
datos_estandarizados <- as.data.frame(scale(columnas_numericas))
head(datos_estandarizados)  # Mostrar las primeras filas

# ---------------------------------------
# **3️⃣ Aplicar normalización con la fórmula (x - min) / (max - min)**
# ---------------------------------------
normalizar <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

datos_normalizados <- as.data.frame(lapply(columnas_numericas, normalizar))
head(datos_normalizados)  # Mostrar las primeras filas

# ---------------------------------------
# **4️⃣ Evaluar diferencias y visualizar con gráficos**
# ---------------------------------------
library(ggplot2)
library(tidyr)

# Generar resumen estadístico
resumen_estandarizado <- summary(datos_estandarizados)
resumen_normalizado <- summary(datos_normalizados)

# Mostrar en consola los resúmenes
cat("📌 Estadísticas descriptivas de datos estandarizados:\n")
print(resumen_estandarizado)
cat("\n📌 Estadísticas descriptivas de datos normalizados:\n")
print(resumen_normalizado)

# Crear un dataframe de comparación
df_comparacion <- data.frame(
  Original = columnas_numericas$Ingresos,
  Estandarizado = datos_estandarizados$Ingresos,
  Normalizado = datos_normalizados$Ingresos
)

# Convertir a formato largo para ggplot2
df_largo <- pivot_longer(df_comparacion, cols = everything(), names_to = "Método", values_to = "Valores")

# Generar gráfico de distribución
ggplot(df_largo, aes(x = Valores, fill = Método)) +
  geom_density(alpha = 0.5) +
  labs(title = "Distribución: Estandarización vs. Normalización", x = "Valores", y = "Densidad") +
  theme_minimal()
