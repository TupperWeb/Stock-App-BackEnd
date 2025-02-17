-- 1. CREACIÓN DE TABLAS

CREATE TABLE Categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo BINARY(16) NOT NULL DEFAULT (UUID_TO_BIN(UUID())) UNIQUE, -- Genera un codigo para identificar cada producto
    nombre VARCHAR(50) NOT NULL,
    stock INT NOT NULL,
    precioUnitario DECIMAL(10,2) NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id) ON UPDATE CASCADE
);

CREATE TABLE Pedido ( -- Informacion general del pedido total
  id INT PRIMARY KEY AUTO_INCREMENT,
  precioTotal DECIMAL(10,2), -- Precio total de todo el pedido, al principio es NULL y con el procedimiento se ingresa el valor final.
  fecha DATE NOT NULL DEFAULT (CURRENT_DATE) -- Inserta la fecha actual 
);

CREATE TABLE Pedido_Productos( -- Informacion especifica de cada producto pedido
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT,
    idProducto INT,
    cantidad INT NOT NULL CHECK(cantidad > 0),
    precioXproducto DECIMAL(10,2) NOT NULL, -- Precio total del pedido por producto (precioUnitario * cantidad) 
    FOREIGN KEY (idProducto) REFERENCES Productos(id) ON UPDATE CASCADE,
    FOREIGN KEY (idPedido) REFERENCES Pedido(id) ON UPDATE CASCADE
);

CREATE TABLE Reponer_Stock ( -- Cuando se quiere realizar un pedido y no hay stock suficiente se carga el producto y la cantidad a reponer. (tendris que tener el id dep pedido? o el pedido no se realiza)
id INT PRIMARY KEY AUTO_INCREMENT,
idProducto INT UNIQUE,  -- Se mantiene único por producto para evitar duplicados
cantidad INT NOT NULL CHECK(cantidad > 0),
FOREIGN KEY (idProducto) REFERENCES Productos(id) ON UPDATE CASCADE
);

-- 2. INSERTAR DATOS PRINCIPALES

INSERT INTO Categorias (nombre) VALUES 
('bebidas'), 
('comida');

INSERT INTO Productos (nombre, stock, precioUnitario, categoria_id) VALUES --No insertamos el codigo, ya que SQL lo genera automaticamente con (UUID_TO_BIN(UUID()))
('Coca-Cola 500ml', 50, 1200, 1),
('Agua Mineral 1L', 30, 1500, 1),
('Coca-Cola Sin Azúcar 500ml', 40, 1200, 1),
('Fanta 500ml', 35, 1200, 1),
('Agua Mineral 500ml', 25, 850, 1),
('Agua Saborizada 1L', 30, 2500, 1),
('Pan lactal', 20, 3000, 2),
('Galletas dulces', 40, 1350, 2),
('Queso', 15, 4000, 2),
('Fruta', 30, 1160, 2),
('Pollo', 25, 4600, 2),
('Carne', 20, 5200, 2),
('Condimentos de ensalada', 50, 700, 2),
('Verdura', 35, 2000, 2),
('Especias', 40, 750, 2),
('Sal', 100, 1200, 2),
('Aceite', 30, 3000, 2),
('Azúcar', 50, 1600, 2),
('Pescado', 15, 5800, 2),
('Huevo', 60, 6000, 2),
('Jamón', 20, 2200, 2),
('Mayonesa', 25, 2700, 2),
('Mostaza', 25, 2500, 2),
('Ketchup', 25, 2700, 2),
('Harina', 40, 1700, 2),
('Levadura', 50, 1000, 2);

-- 3. PROCEDIMIENTOS

-- 1. SumarTotal: 
-- Para realizar un pedido primero debemos hacer un insert sin valores en la tabla Pedido para poder generar el ID (INSERT INTO Pedido VALUES ()). 
-- Una vez generado el ID, hacemos el pedido de cada producto mediante inserts en la tabla Pedido_Productos, ingresando en idPedido el ID obtenido. 
-- Luego de pedir todos los productos llamamos al procedimiento SumarTotal pasandole por parametro el ID de la tabla Pedido (CALL SumarTotal(id);) , este se encargara de sumar todos los precioXproducto de cada producto del pedido y hara un update en la tabla Pedido actualizando el valor precioTotal obtenido de esta suma.
DELIMITER $$
CREATE PROCEDURE SumarTotal(IN pedidoId INT)
BEGIN
  UPDATE Pedido
  SET precioTotal = (
    SELECT IFNULL(SUM(precioXproducto), 0)
    FROM Pedido_Productos
    WHERE idPedido = pedidoId
  )
  WHERE id = pedidoId;
END$$
DELIMITER ;



-- 2. VerificarStockYPedir: 
-- Se encargará de verificar si en un pedido realizado hay stock necesario de los productos, si no hay, calcula cuanto stock falta e inserta los datos en la tabla Reponer_Stock. 
-- Si hay stock, lo descontara de la tabla Productos.
-- Luego de finalizar un pedido llamamos al procedimiento y le pasamos el id general del pedido, es decir el id de la tabla Pedido: CALL VerificarStockYPedir(id)
DELIMITER $$

CREATE PROCEDURE VerificarStockYPedir(IN pedido_id INT)
BEGIN
    
    START TRANSACTION;

    -- Insertar o actualizar productos con stock insuficiente en Reponer_Stock
    INSERT INTO Reponer_Stock (idProducto, cantidad)
    SELECT 
        p.id AS idProducto, 
        ABS(p.stock - pp.cantidad) AS cantidadFaltante
    FROM Pedido_Productos pp
    JOIN Productos p ON pp.idProducto = p.id
    WHERE pp.idPedido = pedido_id AND p.stock < pp.cantidad
    ON DUPLICATE KEY UPDATE 
        cantidad = Reponer_Stock.cantidad + VALUES(cantidad);

    -- Descontar stock solo de los productos que tienen stock suficiente
    UPDATE Productos p
    JOIN Pedido_Productos pp ON p.id = pp.idProducto
    SET p.stock = p.stock - pp.cantidad
    WHERE pp.idPedido = pedido_id AND p.stock >= pp.cantidad;

    COMMIT; 

END $$

DELIMITER ;

