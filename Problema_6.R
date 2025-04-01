# Instalar y cargar librerías necesarias**
# -------------------------------

install.packages("tidyverse") # Librería para manipulación de datos
install.packages("VIM")       # Visualización de valores faltantes
install.packages("naniar")    # Análisis avanzado de valores faltantes

# Cargar las librerías
library(tidyverse)
library(VIM)
library(naniar)

# -------------------------------
# Cargar el dataset**
# -------------------------------

# Seleccionar archivo manualmente o definir ruta específica
archivo <- file.choose()  # Seleccionar archivo manualmente
hospital <- read.csv(archivo, stringsAsFactors = FALSE)

# Visualizar el dataset
View(hospital)

# -------------------------------
# Verificar valores faltantes**
# -------------------------------

# Total de valores faltantes en el dataset
cat("Total de valores faltantes en el dataset: ", sum(is.na(hospital)), "\n")

# Valores faltantes por columna
cat("Valores faltantes por columna:\n")
print(colSums(is.na(hospital)))

# Resumen estadístico del dataset, incluyendo los valores faltantes
summary(hospital)

# -------------------------------
# Manejo de valores faltantes**
# -------------------------------

# a) Eliminar registros con valores faltantes
hospital_limpio_naomit <- na.omit(hospital)

# Mostrar datos después de eliminar valores faltantes
View(hospital_limpio_naomit)

# b) Imputación con la media para las columnas de interés
if (all(c("Presion_arterial", "Glucosa") %in% colnames(hospital))) {
  
  hospital_imputado_media <- hospital %>%
    mutate(
      Presion_arterial = replace_na(Presion_arterial, mean(Presion_arterial, na.rm = TRUE)),
      Glucosa = replace_na(Glucosa, mean(Glucosa, na.rm = TRUE))
    )
  
  # Mostrar el número de registros después de la imputación
  cat("Número de registros después de la imputación: ", nrow(hospital_imputado_media), "\n")
  
  # Visualizar los datos imputados
  View(hospital_imputado_media)
  
} else {
  cat("Las columnas ‘Presion_arterial’ y ‘Glucosa’ no están presentes en el dataset.\n")
}