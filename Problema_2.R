# Cargar librerías necesarias
library(dplyr)  # Para manipulación de datos

# -------------------------------
# Cargar y convertir variables categóricas en factores**
# -------------------------------

# Cargar el dataset desde un archivo CSV
ruta_archivo <- "C:/Users/DANIELAGUADALUPEAGUI/OneDrive - TECNOLOGICO DE ESTUDIOS SUPERIORES DE IXTAPALUCA/Documentos/TESI/OCTAVO SEMESTRE/ANALISIS Y MODELADO DE DATOS/equipo/redesociales.csv"
red <- read.csv(ruta_archivo, stringsAsFactors = FALSE)

# Revisar estructura del dataset
str(red)

# Convertir variables categóricas en factores
red <- red %>%
  mutate(
    tipoInteraccion = as.factor(tipoInteraccion),
    plataforma = as.factor(plataforma),
    nombreUsuario = as.factor(nombreUsuario),
    contenido = as.factor(contenido),
    fecha = as.Date(fecha, format = "%d/%m/%Y") # Convertir fecha a formato Date
  )

# Eliminar columna innecesaria si existe
red <- red %>% select(-matches("Unnamed: 7"))

# Revisar estructura después de la conversión
str(red)

# -------------------------------
# Normalizar valores numéricos**
# -------------------------------

# Función para normalización Min-Max
normalizar_minmax <- function(x) {
  return((x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE)))
}

# Aplicar normalización a la columna número de interacciones
if ("numeroInteracciones" %in% colnames(red)) {
  red$numeroInteracciones <- normalizar_minmax(red$numeroInteracciones)
}

# Revisar estadísticas después de la normalización
summary(red