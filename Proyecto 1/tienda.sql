-- Creacion de bd para efectos de aprendizaje
create database tienda;

-- Crear la tabla 'ventas'
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE,
    producto VARCHAR(100),
    cantidad INT,
    precio_unitario DECIMAL(10, 2)
);

-- Insertar datos de ejemplo en la tabla 'ventas'
INSERT INTO ventas (fecha, producto, cantidad, precio_unitario) VALUES
('2024-01-01', 'Producto A', 10, 20.00),
('2024-01-02', 'Producto B', 5, 15.00),
('2024-01-03', 'Producto C', 8, 25.00),
('2024-01-04', 'Producto A', 12, 20.00),
('2024-01-05', 'Producto B', 6, 15.00),
('2024-01-06', 'Producto C', 9, 25.00),
('2024-01-07', 'Producto A', 11, 20.00),
('2024-01-08', 'Producto B', 7, 15.00),
('2024-01-09', 'Producto C', 10, 25.00),
('2024-01-10', 'Producto A', 13, 20.00);
