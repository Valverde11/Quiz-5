-- Quiz #5 SQL - CE 2103 - II Semestre 2026
-- Script DML: datos de prueba de MiAutoPuntoCom
USE MiAutoPuntoCom;

INSERT INTO Vehiculos (marca, modelo, anio, color, precio, vin, tipo, estado) VALUES
('Toyota',  'Corolla', 2023, 'Blanco', 18500.00, '1HGCM82633A004352', 'sedan',     'nuevo'),
('Toyota',  'RAV4',    2021, 'Gris',   24000.00, 'JTDKN3DU0A0123456', 'SUV',       'usado'),
('Volkswagen','Golf',  2020, 'Rojo',   15500.00, '3VWFE21C04M000001', 'hatchback', 'usado'),
('BMW',     'X3',      2024, 'Negro',  45000.00, 'WBAFR7C57CC812345', 'SUV',       'nuevo'),
('Ford',    'F-150',   2022, 'Azul',   38000.00, '1FTFW1ET5DFC10312', 'camioneta', 'usado'),
('Hyundai', 'Elantra', 2024, 'Plata',  19800.00, 'KMHD35LH5EU098765', 'sedan',     'nuevo');

INSERT INTO Clientes (nombre, apellido, cedula, telefono, email, direccion) VALUES
('Carlos',  'Rojas Mora',     '1-1234-0567', '8888-1111', 'carlos.rojas@email.com',  'Cartago, Centro'),
('María',   'Jiménez Solano', '2-0456-0789', '8777-2222', 'maria.jimenez@email.com', 'Alajuela, San Rafael'),
('Luis',    'Vargas Campos',  '3-0321-0654', '8666-3333', 'luis.vargas@email.com',   'Heredia, Barva'),
('Ana',     'Quesada Ureña',  '1-0987-0432', '8555-4444', 'ana.quesada@email.com',   'San José, Escazú'),
('Daniel',  'Mora Brenes',    '4-0111-0222', '8444-5555', 'daniel.mora@email.com',   'Limón, Guápiles');

INSERT INTO Vendedores (nombre, apellido, cedula, fecha_contratacion, comision_porcentual) VALUES
('Andrés',  'Solís Araya',   '1-1500-0300', '2019-03-15', 3.50),
('Karla',   'Méndez Pérez',  '1-1600-0400', '2021-07-01', 4.00),
('Jorge',   'Castro Leiva',  '2-0700-0500', '2023-01-10', 2.75);

INSERT INTO Ventas (id_vehiculo, id_cliente, id_vendedor, fecha_venta, precio_final, metodo_pago) VALUES
(1, 1, 1, '2026-01-20', 18000.00, 'financiamiento'),
(2, 2, 2, '2026-02-14', 23500.00, 'tarjeta'),
(3, 3, 1, '2026-03-05', 15500.00, 'efectivo'),
(4, 4, 3, '2026-04-22', 44000.00, 'financiamiento');
