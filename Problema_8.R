# Cargar las librerías necesarias
library(dplyr)

#Cargar y explorar los datasets
clientes <- read.csv("clientes.csv")  # Cargar dataset de clientes
compras <- read.csv("compras.csv")    # Cargar dataset de compras

#Fusionar los datos usando left_join()
fusionado <- left_join(clientes, compras, by = "id_cliente")

#Detectar y manejar duplicados con distinct()
fusionado <- fusionado %>% distinct()

#Verificar inconsistencias después de la integración
# Verificar claves duplicadas
duplicados <- fusionado %>% group_by(id_cliente) %>% filter(n() > 1)
print(duplicados)

# Verificar valores faltantes
faltantes <- colSums(is.na(fusionado))
print(faltantes)

# Consulta de resumen
resumen <- fusionado %>%
  group_by(id_cliente) %>%
  summarise(total_compras = n(),
            monto_total = sum(monto, na.rm = TRUE))

print(resumen)