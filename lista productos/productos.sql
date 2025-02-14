CREATE TABLE Categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo INT UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    stock INT NOT NULL,
    precioUnitario DECIMAL(10,2) NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id) ON UPDATE CASCADE
);

CREATE TABLE Pedido ( -- Contiene información general de el pedido
  id INT PRIMARY KEY AUTO_INCREMENT,
  precioTotal DECIMAL(10,2) NOT NULL, -- Precio total de todo el pedido
  fecha DATE NOT NULL  
);

CREATE TABLE Pedido_Productos( -- Contiene informacion especifica de cada producto pedido
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT,
    idProducto INT,
    cantidad INT NOT NULL CHECK(cantidad > 0),
    precioXproducto DECIMAL(10,2) NOT NULL, -- Precio total del pedido por producto (precioUnitario * cantidad) 
    FOREIGN KEY (idProducto) REFERENCES Productos(id) ON UPDATE CASCADE,
    FOREIGN KEY (idPedido) REFERENCES Pedido(id) ON UPDATE CASCADE
);

INSERT INTO Categorias (nombre) VALUES ('bebidas'), ('comida');

INSERT INTO Productos (codigo, nombre, stock, precio, categoria_id) VALUES
('10001', 'Coca-Cola 500ml', 50, 1200, 1),
('10002', 'Agua Mineral 1L', 30, 1500, 1),
('10003', 'Coca-Cola Sin Azúcar 500ml', 40, 1200, 1),
('10004', 'Fanta 500ml', 35, 1200, 1),
('10005', 'Agua Mineral 500ml', 25, 850, 1),
('10006', 'Agua Saborizada 1L', 30, 2500, 1),
('20001', 'Pan lactal', 20, 3000, 2),
('20002', 'Galletas dulces', 40, 1350, 2),
('20003', 'Queso', 15, 4000, 2),
('20004', 'Fruta', 30, 1160, 2),
('20005', 'Pollo', 25, 4600, 2),
('20006', 'Carne', 20, 5200, 2),
('20007', 'Condimentos de ensalada', 50, 700, 2),
('20008', 'Verdura', 35, 2000, 2),
('20009', 'Especias', 40, 750, 2),
('20010', 'Sal', 100, 1200, 2),
('20011', 'Aceite', 30, 3000, 2),
('20012', 'Azúcar', 50, 1600, 2),
('20013', 'Pescado', 15, 5800, 2),
('20014', 'Huevo', 60, 6000, 2),
('20015', 'Jamón', 20, 2200, 2),
('20016', 'Mayonesa', 25, 2700, 2),
('20017', 'Mostaza', 25, 2500, 2),
('20018', 'Ketchup', 25, 2700, 2),
('20019', 'Harina', 40, 1700, 2),
('20020', 'Levadura', 50, 1000, 2); 
