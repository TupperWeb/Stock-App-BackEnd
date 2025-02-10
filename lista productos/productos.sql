CREATE TABLE categorias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT UNIQUE NOT NULL
);

CREATE TABLE productos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo TEXT UNIQUE NOT NULL,
    nombre TEXT NOT NULL,
    stock INTEGER NOT NULL,
    categoria_id INTEGER NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

INSERT INTO categorias (nombre) VALUES ('bebidas'), ('comida');

INSERT INTO productos (codigo, nombre, stock, categoria_id) VALUES
('10001', 'Coca-Cola 500ml', 50, 1),
('10002', 'Agua Mineral 1L', 30, 1),
('10003', 'Coca-Cola Sin Azúcar 500ml', 40, 1),
('10004', 'Fanta 500ml', 35, 1),
('10005', 'Agua Mineral 500ml', 25, 1),
('10006', 'Agua Saborizada 1L', 30, 1),
('20001', 'Pan lactal', 20, 2),
('20002', 'Galletas dulces', 40, 2),
('20003', 'Queso', 15, 2),
('20004', 'Fruta', 30, 2),
('20005', 'Pollo', 25, 2),
('20006', 'Carne', 20, 2),
('20007', 'Condimentos de ensalada', 50, 2),
('20008', 'Verdura', 35, 2),
('20009', 'Especias', 40, 2),
('20010', 'Sal', 100, 2),
('20011', 'Aceite', 30, 2),
('20012', 'Azúcar', 50, 2),
('20013', 'Pescado', 15, 2),
('20014', 'Huevo', 60, 2),
('20015', 'Jamón', 20, 2),
('20016', 'Mayonesa', 25, 2),
('20017', 'Mostaza', 25, 2),
('20018', 'Ketchup', 25, 2),
('20019', 'Harina', 40, 2),
('20020', 'Levadura', 50, 2); 