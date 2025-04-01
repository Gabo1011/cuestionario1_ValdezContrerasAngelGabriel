# Cargar librerías necesarias
library(dplyr)  # Para manipulación de datos

# Crear un dataset de ejemplo con variables categóricas y numéricas
encuesta <- data.frame(
  Genero = factor(c("M", "F", "F", "M", "F")),
  Ciudad = factor(c("Madrid", "Barcelona", "Sevilla", "Madrid", "Valencia")),
  Edad = c(25, 30, 22, 28, 35),
  variable_numerica = c(100, 200, 150, 180, 220) # Variable objetivo
)

# Agregar identificador único
encuesta$id <- 1:nrow(encuesta)

# -------------------------------
# **Codificación One-Hot Encoding**
# -------------------------------

# Crear la fórmula para One-Hot Encoding
formula_one_hot <- as.formula(paste("~", paste(colnames(encuesta)[sapply(encuesta, is.factor)], collapse = " + "), "- 1"))

# Aplicar One-Hot Encoding
one_hot_encoded <- model.matrix(formula_one_hot, data = encuesta)

# Convertir a data frame
one_hot_encoded_df <- as.data.frame(one_hot_encoded)

# Fusionar con el dataset original
encuesta_codificada_one_hot <- cbind(encuesta, one_hot_encoded_df)

# Eliminar el identificador
encuesta_codificada_one_hot$id <- NULL

# -------------------------------
# **Crear modelo con Label Encoding**
# -------------------------------

# Convertir variables categóricas en factores numéricos (Label Encoding)
encuesta_codificada_label <- encuesta %>%
  mutate(across(where(is.factor), as.numeric))

# Verificar si la variable objetivo existe antes de construir el modelo
if ("variable_numerica" %in% colnames(encuesta_codificada_label)) {
  
  # Crear la fórmula del modelo
  formula_label <- as.formula(paste("variable_numerica ~", 
                                    paste(colnames(encuesta_codificada_label)[sapply(encuesta_codificada_label, is.numeric) & 
                                                                                !colnames(encuesta_codificada_label) %in% c("variable_numerica", "id")], 
                                          collapse = " + ")))
  
  # Entrenar el modelo con Label Encoding
  modelo_label <- lm(formula_label, data = encuesta_codificada_label)
  
  # Mostrar resumen del modelo
  print("Resumen del modelo con Label Encoding:")
  print(summary(modelo_label))
}