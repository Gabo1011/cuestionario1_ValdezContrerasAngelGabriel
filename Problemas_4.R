# Crear diagrama de caja
ggplot(transacciones, aes(y = Monto)) +
  geom_boxplot(fill = "skyblue", color = "black") +
  labs(title = "Diagrama de Caja de Transacciones",
       y = "Monto de Transacción") +
  theme_minimal()
