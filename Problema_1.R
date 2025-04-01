# Cargar librería necesaria
library(dplyr)  # Para manipulación de datos

# Cargar el dataset desde un archivo CSV
ventas <- read.csv("ventas.csv", stringsAsFactors = FALSE)

# Ver las primeras filas del dataset
head(ventas)

# Crear un dataset con problemas
ventas <- data.frame(
  Sucursal = c("Madrid", "Barcelona", "Madrid ", "Sevilla", "Valencia", "Madrid"),
  Producto = c("Zapatos", "Camiseta", "zapatos", "Pantalón", "Zapatos", "Camiseta"),
  Ventas = c(100, 200, NA, 400, 500, 200),  # NA representa valores faltantes
  Fecha = as.Date(c("2024-03-01", "2024-03-02", "2024-03-01", "2024-03-03", "2024-03-04", "2024-03-02"))
)

ventas <- read.csv("C:/Usuarios/TuUsuario/Documentos/ventas.csv", stringsAsFactors = FALSE)

# Revisar valores faltantes en cada columna
summary(ventas)

# Contar valores NA por columna
colSums(is.na(ventas))

ventas <- na.omit(ventas)  # Elimina filas con valores faltantes

# Ver cuántas filas duplicadas existen
sum(duplicated(ventas))

# Eliminar duplicados
ventas <- distinct(ventas)

# Eliminar espacios adicionales en los nombres de productos
ventas$Producto <- trimws(ventas$Producto)

# Convertir todos los nombres a minúsculas para estandarizar
ventas$Producto <- tolower(ventas$Producto)

# Ver el dataset limpio
print(ventas)

# Resumen final del dataset
summary(ventas)