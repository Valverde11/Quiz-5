-- Quiz #5 SQL - CE 2103 - II Semestre 2026
-- Script de consultas de MiAutoPuntoCom
USE MiAutoPuntoCom;

-- 1. Vehículos nuevos que todavía no se han vendido
SELECT v.id_vehiculo, v.marca, v.modelo, v.anio, v.color, v.precio
FROM Vehiculos v
LEFT JOIN Ventas ve ON ve.id_vehiculo = v.id_vehiculo
WHERE v.estado = 'nuevo' AND ve.id_venta IS NULL;

-- 2. Detalle completo de todas las ventas (vehículo, cliente y vendedor)
SELECT ve.id_venta, ve.fecha_venta,
       CONCAT(v.marca, ' ', v.modelo, ' ', v.anio) AS vehiculo,
       CONCAT(c.nombre, ' ', c.apellido)           AS cliente,
       CONCAT(s.nombre, ' ', s.apellido)           AS vendedor,
       ve.precio_final, ve.metodo_pago
FROM Ventas ve
INNER JOIN Vehiculos v  ON v.id_vehiculo  = ve.id_vehiculo
INNER JOIN Clientes c   ON c.id_cliente   = ve.id_cliente
INNER JOIN Vendedores s ON s.id_vendedor  = ve.id_vendedor
ORDER BY ve.fecha_venta;

-- 3. Total vendido y comisión ganada por cada vendedor
SELECT s.id_vendedor, CONCAT(s.nombre, ' ', s.apellido) AS vendedor,
       COUNT(ve.id_venta)                                   AS cantidad_ventas,
       COALESCE(SUM(ve.precio_final), 0)                    AS total_vendido,
       COALESCE(SUM(ve.precio_final * s.comision_porcentual / 100), 0) AS comision_ganada
FROM Vendedores s
LEFT JOIN Ventas ve ON ve.id_vendedor = s.id_vendedor
GROUP BY s.id_vendedor, s.nombre, s.apellido
ORDER BY total_vendido DESC;

-- 4. Clientes que compraron con financiamiento
SELECT DISTINCT c.id_cliente, c.nombre, c.apellido, c.cedula, c.telefono, c.email
FROM Clientes c
INNER JOIN Ventas ve ON ve.id_cliente = c.id_cliente
WHERE ve.metodo_pago = 'financiamiento';

-- 5. Los 3 vehículos vendidos al precio final más alto
SELECT v.marca, v.modelo, v.vin, ve.precio_final
FROM Ventas ve
INNER JOIN Vehiculos v ON v.id_vehiculo = ve.id_vehiculo
ORDER BY ve.precio_final DESC
LIMIT 3;

-- 6. Cantidad de ventas y monto total por método de pago
SELECT metodo_pago, COUNT(*) AS cantidad_ventas, SUM(precio_final) AS monto_total
FROM Ventas
GROUP BY metodo_pago
ORDER BY monto_total DESC;

-- 7. Precio promedio de los vehículos por marca (solo marcas con precio promedio > 15000)
SELECT marca, COUNT(*) AS cantidad, ROUND(AVG(precio), 2) AS precio_promedio
FROM Vehiculos
GROUP BY marca
HAVING AVG(precio) > 15000
ORDER BY precio_promedio DESC;

-- 8. Ventas realizadas en el primer trimestre de 2026 con descuento respecto al precio de lista
SELECT ve.id_venta, ve.fecha_venta, v.marca, v.modelo,
       v.precio AS precio_lista, ve.precio_final,
       (v.precio - ve.precio_final) AS descuento
FROM Ventas ve
INNER JOIN Vehiculos v ON v.id_vehiculo = ve.id_vehiculo
WHERE ve.fecha_venta BETWEEN '2026-01-01' AND '2026-03-31'
  AND ve.precio_final < v.precio;
