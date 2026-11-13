-- Quiz #5 SQL - CE 2103 - II Semestre 2026
-- Script DML: datos de prueba (Parte 3)
-- 10 vehículos, 6 clientes, 4 vendedores y 8 ventas
-- Todos los precios están en colones costarricenses (₡)
USE MiAutoPuntoCom;

INSERT INTO Vehiculos (marca, modelo, anio, color, precio, vin, tipo, estado) VALUES
('Toyota',     'Corolla',  2023, 'Blanco', 13500000.00, '1HGCM82633A004352', 'sedán',     'Nuevo'),
('Toyota',     'RAV4',     2021, 'Gris',   17500000.00, 'JTDKN3DU0A0123456', 'SUV',       'Usado'),
('Volkswagen', 'Golf',     2020, 'Rojo',   10500000.00, '3VWFE21C04M000001', 'hatchback', 'Usado'),
('BMW',        'X3',       2024, 'Negro',  32000000.00, 'WBAFR7C57CC812345', 'SUV',       'Nuevo'),
('Ford',       'F-150',    2022, 'Azul',   27000000.00, '1FTFW1ET5DFC10312', 'camioneta', 'Usado'),
('Hyundai',    'Elantra',  2024, 'Plata',  14200000.00, 'KMHD35LH5EU098765', 'sedán',     'Nuevo'),
('Honda',      'Civic',    2019, 'Gris',   9500000.00, '2T1BURHE5JC034567', 'sedán',     'Usado'),
('Tesla',      'Model S',  2023, 'Blanco', 45000000.00, '5YJSA1E26HF123456', 'sedán',     'Nuevo'),
('Nissan',     'Frontier', 2021, 'Verde',  19500000.00, 'JN1TBNT30Z0000123', 'camioneta', 'Usado'),
('Nissan',     'Sentra',   2025, 'Azul',   12500000.00, '3N1AB7AP5HY204567', 'sedán',     'Nuevo');

INSERT INTO Clientes (nombre, apellido, cedula, telefono, email, direccion) VALUES
('Carlos', 'Rojas Mora',     '1-1234-0567', '8888-1111', 'carlos.rojas@email.com',  'Cartago, Centro'),
('María',  'Jiménez Solano', '2-0456-0789', '8777-2222', 'maria.jimenez@email.com', 'Alajuela, San Rafael'),
('Luis',   'Vargas Campos',  '3-0321-0654', '8666-3333', 'luis.vargas@email.com',   'Heredia, Barva'),
('Ana',    'Quesada Ureña',  '1-0987-0432', '8555-4444', 'ana.quesada@email.com',   'San José, Escazú'),
('Daniel', 'Mora Brenes',    '4-0111-0222', '8444-5555', 'daniel.mora@email.com',   'Limón, Guápiles'),
('Sofía',  'Brenes Chaves',  '1-1456-0888', '8333-6666', 'sofia.brenes@email.com',  'Cartago, Paraíso');

INSERT INTO Vendedores (nombre, apellido, cedula, fecha_nacimiento, fecha_contratacion, comision_porcentual) VALUES
('Andrés',  'Solís Araya',  '1-1500-0300', '1990-05-12', '2019-03-15', 3.50),
('Karla',   'Méndez Pérez', '1-1600-0400', '1993-08-30', '2021-07-01', 4.00),
('Jorge',   'Castro Leiva', '2-0700-0500', '1998-02-17', '2023-01-10', 2.75),
('Marcela', 'Rojas Vega',   '3-0800-0600', '2000-11-05', '2024-02-01', 5.00);

-- Algunas ventas usan fechas relativas a hoy para que la consulta del "último mes" siempre devuelva datos
INSERT INTO Ventas (id_vehiculo, id_cliente, id_vendedor, fecha_venta, precio_final, metodo_pago) VALUES
(1, 1, 1, '2026-08-20',                           13000000.00, 'financiamiento'),
(2, 2, 2, '2026-09-14',                           17000000.00, 'tarjeta'),
(3, 3, 1, '2026-09-30',                           10500000.00, 'efectivo'),
(4, 4, 3, DATE_SUB(CURDATE(), INTERVAL 10 DAY),   31000000.00, 'financiamiento'),
(5, 5, 2, DATE_SUB(CURDATE(), INTERVAL 20 DAY),   26000000.00, 'financiamiento'),
(7, 6, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY),    9200000.00, 'efectivo'),
(8, 1, 3, DATE_SUB(CURDATE(), INTERVAL 45 DAY),   43500000.00, 'tarjeta'),
(9, 2, 4, DATE_SUB(CURDATE(), INTERVAL 3 DAY),    19000000.00, 'tarjeta');
-- Quedan sin vender: Hyundai Elantra (6) y Nissan Sentra (10)
