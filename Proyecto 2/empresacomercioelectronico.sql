-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS empresa_comercio_electronico;

-- Usar la base de datos
USE empresa_comercio_electronico;

-- Crear la tabla de Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    correo_electronico VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

-- Crear la tabla de Productos
CREATE TABLE IF NOT EXISTS Productos (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10, 2),
    stock_disponible INT,
    categoria VARCHAR(50)
);

-- Crear la tabla de Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    fecha_pedido DATE,
    total DECIMAL(10, 2),
    estado VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Usuarios(user_id)
);

-- Crear la tabla de Detalles del Pedido
CREATE TABLE IF NOT EXISTS Detalles_Pedido (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Pedidos(order_id),
    FOREIGN KEY (product_id) REFERENCES Productos(product_id)
);

