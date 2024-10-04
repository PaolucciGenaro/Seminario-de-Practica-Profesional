-- Crear tabla Categoria
CREATE TABLE Categoria (
    Categoria_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

-- Crear tabla Ubicacion
CREATE TABLE Ubicacion (
    Ubicacion_ID INT AUTO_INCREMENT PRIMARY KEY,
    Ciudad VARCHAR(100) NOT NULL,
    Provincia VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255) NOT NULL
);

-- Crear tabla Producto
CREATE TABLE Producto (
    Producto_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255),
    Cantidad INT NOT NULL,
    Precio DECIMAL(10,2),
    Fecha_Registro DATE NOT NULL,
    Categoria_ID INT,
    Ubicacion_ID INT,
    FOREIGN KEY (Categoria_ID) REFERENCES Categoria(Categoria_ID),
    FOREIGN KEY (Ubicacion_ID) REFERENCES Ubicacion(Ubicacion_ID)
);

-- Crear tabla Almacen
CREATE TABLE Almacen (
    Almacen_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Capacidad INT NOT NULL,
    Ubicacion_ID INT,
    FOREIGN KEY (Ubicacion_ID) REFERENCES Ubicacion(Ubicacion_ID)
);

-- Crear tabla Cliente
CREATE TABLE Cliente (
    Cliente_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255),
    Telefono VARCHAR(15)
);

-- Crear tabla Pedido
CREATE TABLE Pedido (
    Pedido_ID INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(Cliente_ID)
);

-- Crear tabla DetallePedido
CREATE TABLE DetallePedido (
    DetallePedido_ID INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    Pedido_ID INT,
    Producto_ID INT,
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(Pedido_ID),
    FOREIGN KEY (Producto_ID) REFERENCES Producto(Producto_ID)
);

-- Insertar datos en la tabla Categoria
INSERT INTO Categoria (Nombre, Descripcion) VALUES
('Electrodoméstico', 'Aparatos eléctricos para el hogar'),
('Muebles', 'Mobiliario para el hogar y oficina'),
('Tecnología', 'Dispositivos electrónicos');

-- Insertar datos en la tabla Ubicacion
INSERT INTO Ubicacion (Ciudad, Provincia, Direccion) VALUES
('Buenos Aires', 'Buenos Aires', 'Av. Corrientes 1234'),
('Córdoba', 'Córdoba', 'Calle Colon 5678'),
('Rosario', 'Santa Fe', 'San Martín 2345');

-- Insertar datos en la tabla Producto
INSERT INTO Producto (Nombre, Descripcion, Cantidad, Precio, Fecha_Registro, Categoria_ID, Ubicacion_ID) VALUES
('Televisor LED', 'Televisor de 50 pulgadas', 10, 50000.00, CURDATE(), 1, 1),
('Sillón', 'Sillón de cuero de 3 cuerpos', 5, 20000.00, CURDATE(), 2, 2),
('Laptop', 'Laptop Intel Core i7', 15, 75000.00, CURDATE(), 3, 3);

-- Insertar datos en la tabla Cliente
INSERT INTO Cliente (Nombre, Apellido, Direccion, Telefono) VALUES
('Juan', 'Pérez', 'Av. Siempreviva 742', '123456789'),
('Ana', 'García', 'Calle Olga 321', '987654321');

-- Insertar datos en la tabla Pedido
INSERT INTO Pedido (Fecha, Total, Cliente_ID) VALUES
(CURDATE(), 120000.00, 1),
(CURDATE(), 50000.00, 2);

-- Insertar datos en la tabla DetallePedido
INSERT INTO DetallePedido (Cantidad, Subtotal, Pedido_ID, Producto_ID) VALUES
(2, 100000.00, 1, 3),  -- 2 laptops
(1, 20000.00, 2, 2);    -- 1 sillón

--Consultar productos y su ubicación:

SELECT Producto.Nombre AS Producto, Producto.Descripcion, Producto.Cantidad, Categoria.Nombre AS Categoria, Ubicacion.Ciudad, Ubicacion.Provincia
FROM Producto
JOIN Categoria ON Producto.Categoria_ID = Categoria.Categoria_ID
JOIN Ubicacion ON Producto.Ubicacion_ID = Ubicacion.Ubicacion_ID;

--Consultar pedidos y productos asociados:

SELECT Pedido.Pedido_ID, Pedido.Fecha, Cliente.Nombre, Cliente.Apellido, Producto.Nombre AS Producto, DetallePedido.Cantidad, DetallePedido.Subtotal
FROM Pedido
JOIN Cliente ON Pedido.Cliente_ID = Cliente.Cliente_ID
JOIN DetallePedido ON Pedido.Pedido_ID = DetallePedido.Pedido_ID
JOIN Producto ON DetallePedido.Producto_ID = Producto.Producto_ID;

-- Borrar los datos de las tablas manteniendo su estructura
DELETE FROM DetallePedido;
DELETE FROM Pedido;
DELETE FROM Cliente;
DELETE FROM Producto;
DELETE FROM Categoria;
DELETE FROM Ubicacion;

-- Si deseas reiniciar los valores AUTO_INCREMENT
ALTER TABLE DetallePedido AUTO_INCREMENT = 1;
ALTER TABLE Pedido AUTO_INCREMENT = 1;
ALTER TABLE Cliente AUTO_INCREMENT = 1;
ALTER TABLE Producto AUTO_INCREMENT = 1;
ALTER TABLE Categoria AUTO_INCREMENT = 1;
ALTER TABLE Ubicacion AUTO_INCREMENT = 1;

--Verificacion de los datos borrados de la tabla
SELECT * FROM DetallePedido;
SELECT * FROM Pedido;
SELECT * FROM Cliente;
SELECT * FROM Producto;
SELECT * FROM Categoria;
SELECT * FROM Ubicacion;