import os
from dotenv import load_dotenv
import pymysql
import pandas as pd
import matplotlib.pyplot as plt

load_dotenv()

# Credenciales base de datos desde las variables de entorno
DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_DATABASE = os.getenv("DB_DATABASE")

# Conexión a la bd
connection = pymysql.connect(host=DB_HOST,
                             user=DB_USER,
                             password=DB_PASSWORD,
                             database=DB_DATABASE)

# Consulta
query = "SELECT * FROM ventas"

# Ejecutar consulta y obtener resultados
with connection.cursor() as cursor:
    cursor.execute(query)
    ventas_data = cursor.fetchall()

connection.close()

# Convertir datos de ventas en un DataFrame de Pandas
df_ventas = pd.DataFrame(ventas_data, columns=['id_venta', 'fecha', 'producto', 'cantidad', 'precio_unitario'])

# Eliminar filas con valores nulos
df_ventas = df_ventas.dropna()

# Eliminar filas duplicadas
df_ventas = df_ventas.drop_duplicates()

# Convertir columna 'fecha' a tipo datetime
df_ventas['fecha'] = pd.to_datetime(df_ventas['fecha'])

# Calcular ingresos totales
ingresos_totales = df_ventas['cantidad'] * df_ventas['precio_unitario']
ingresos_totales = ingresos_totales.sum()

# Calcular número total de pedidos
num_pedidos = df_ventas['id_venta'].nunique()

# Calcular promedio de ventas por producto
promedio_ventas_producto = df_ventas.groupby('producto')['cantidad'].sum().mean()

# Productos más vendidos
productos_mas_vendidos = df_ventas['producto'].value_counts().head(10)

# Gráfico de barras para productos más vendidos
plt.figure(figsize=(10, 6))
productos_mas_vendidos.plot(kind='bar')
plt.title('Productos más vendidos')
plt.xlabel('Producto')
plt.ylabel('Cantidad vendida')
plt.xticks(rotation=45)
# Guardar gráfico en una foto
plt.savefig('productos_mas_vendidos.png')
plt.show()

# Generar informe resumido en la terminal
print(f"Ingresos totales: ${ingresos_totales}")
print(f"Número total de pedidos: {num_pedidos}")
print(f"Promedio de ventas por producto: {promedio_ventas_producto:.2f}")
print("\nProductos más vendidos:")
print(productos_mas_vendidos)

# Guardar informe en un txt
with open('informe.txt', 'w') as file:
	file.write(f"Ingresos totales: ${ingresos_totales}\n")
	file.write(f"Número total de pedidos: {num_pedidos}\n")
	file.write(f"Promedio de ventas por producto: {promedio_ventas_producto:.2f}\n\n")
	file.write("Productos más vendidos:\n")
	file.write(productos_mas_vendidos.to_string())

