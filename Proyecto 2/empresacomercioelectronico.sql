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

-------------------------------------------------------------------------------------------
-- Insertar datos de prueba en las tablas Usuarios, Productos, Pedidos y Detalles_Pedido --
-------------------------------------------------------------------------------------------

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (nombre, apellido, correo_electronico, direccion, telefono)
SELECT
-- CONCAT() concatena cosas, en este caso, el texto 'Usuario' con el número de user_id queda algo como Usuario1
    CONCAT('Usuario', user_id) AS nombre,
    CONCAT('Apellido', user_id) AS apellido,
    CONCAT('usuario', user_id, '@empresa.com') AS correo_electronico,
    CONCAT('Dirección', user_id) AS direccion,
    CONCAT('123456789', user_id) AS telefono
FROM
-- Crear una secuencia de números del 1 al 100 es como un bucle for
    (SELECT seq AS user_id FROM seq_1_to_100) AS sub;

-- Insertar datos en la tabla Productos
INSERT INTO Productos (nombre_producto, descripcion, precio, stock_disponible, categoria)
SELECT
    CONCAT('Producto', product_id) AS nombre_producto,
    CONCAT('Descripción del producto ', product_id) AS descripcion,
    ROUND(RAND() * 1000 + 10, 2) AS precio,
    ROUND(RAND() * 1000) AS stock_disponible,
    CASE ROUND(RAND() * 4)
        WHEN 0 THEN 'Electrónica'
        WHEN 1 THEN 'Ropa'
        WHEN 2 THEN 'Hogar'
        ELSE 'Otros'
    END AS categoria
FROM
    (SELECT seq AS product_id FROM seq_1_to_200) AS sub;


-- Insertar datos en la tabla Pedidos
INSERT INTO Pedidos (user_id, fecha_pedido, total, estado)
SELECT
    u.user_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL FLOOR(RAND() * 90) DAY) AS fecha_pedido,
    ROUND(RAND() * 1000 + 10, 2) AS total,
    CASE ROUND(RAND() * 3)
        WHEN 0 THEN 'Pendiente'
        WHEN 1 THEN 'En proceso'
        ELSE 'Completado'
    END AS estado
FROM
    (SELECT user_id FROM Usuarios ORDER BY RAND() LIMIT 500) AS u;

-- Insertar datos en la tabla Detalles_Pedido
INSERT INTO Detalles_Pedido (order_id, product_id, cantidad, precio_unitario)
SELECT
    p.order_id,
    pr.product_id,
    ROUND(RAND() * 10 + 1) AS cantidad,
    ROUND(RAND() * 500 + 10, 2) AS precio_unitario
FROM
    (SELECT order_id FROM Pedidos ORDER BY RAND() LIMIT 1500) AS p
    CROSS JOIN
    (SELECT product_id FROM Productos ORDER BY RAND() LIMIT 200) AS pr;
