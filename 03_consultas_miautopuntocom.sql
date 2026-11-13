-- Quiz #5 SQL - CE 2103 - II Semestre 2026
-- Script de consultas (Parte 4)
USE MiAutoPuntoCom;

-- 1. Vehículos disponibles (no vendidos) ordenados por precio descendente
SELECT v.id_vehiculo, v.marca, v.modelo, v.anio, v.color, v.tipo, v.estado, v.precio
FROM Vehiculos v
LEFT JOIN Ventas ve ON ve.id_vehiculo = v.id_vehiculo
WHERE ve.id_venta IS NULL
ORDER BY v.precio DESC;

-- 2. Total de ventas realizadas por cada vendedor (nombre y cantidad de ventas)
SELECT CONCAT(s.nombre, ' ', s.apellido) AS vendedor,
       COUNT(ve.id_venta)                AS cantidad_ventas
FROM Vendedores s
LEFT JOIN Ventas ve ON ve.id_vendedor = s.id_vendedor
GROUP BY s.id_vendedor, s.nombre, s.apellido
ORDER BY cantidad_ventas DESC;

-- 3. Ingreso total generado por cada vendedor
SELECT CONCAT(s.nombre, ' ', s.apellido)    AS vendedor,
       COALESCE(SUM(ve.precio_final), 0)    AS ingreso_total
FROM Vendedores s
LEFT JOIN Ventas ve ON ve.id_vendedor = s.id_vendedor
GROUP BY s.id_vendedor, s.nombre, s.apellido
ORDER BY ingreso_total DESC;

-- 4. Cliente que ha realizado la compra más costosa
SELECT c.id_cliente, c.nombre, c.apellido, c.cedula, c.email,
       ve.precio_final AS compra_mas_costosa
FROM Ventas ve
INNER JOIN Clientes c ON c.id_cliente = ve.id_cliente
WHERE ve.precio_final = (SELECT MAX(precio_final) FROM Ventas);

-- 5. Vehículos vendidos en el último mes con información del cliente comprador
SELECT ve.fecha_venta, v.marca, v.modelo, v.vin, ve.precio_final,
       c.nombre, c.apellido, c.cedula, c.telefono, c.email
FROM Ventas ve
INNER JOIN Vehiculos v ON v.id_vehiculo = ve.id_vehiculo
INNER JOIN Clientes c  ON c.id_cliente  = ve.id_cliente
WHERE ve.fecha_venta >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY ve.fecha_venta DESC;

-- 6. Comisión ganada por cada vendedor basado en sus ventas
SELECT CONCAT(s.nombre, ' ', s.apellido) AS vendedor,
       s.comision_porcentual             AS porcentaje_comision,
       COALESCE(SUM(ve.precio_final), 0) AS total_vendido,
       ROUND(COALESCE(SUM(ve.precio_final * s.comision_porcentual / 100), 0), 2) AS comision_ganada
FROM Vendedores s
LEFT JOIN Ventas ve ON ve.id_vendedor = s.id_vendedor
GROUP BY s.id_vendedor, s.nombre, s.apellido, s.comision_porcentual
ORDER BY comision_ganada DESC;

-- 7. Promedio de precios de vehículos vendidos agrupados por tipo
SELECT v.tipo,
       COUNT(*)                     AS vehiculos_vendidos,
       ROUND(AVG(v.precio), 2)      AS promedio_precio_lista,
       ROUND(AVG(ve.precio_final), 2) AS promedio_precio_venta
FROM Ventas ve
INNER JOIN Vehiculos v ON v.id_vehiculo = ve.id_vehiculo
GROUP BY v.tipo
ORDER BY promedio_precio_venta DESC;

-- 8. Marca de vehículo que se ha vendido más veces
SELECT v.marca, COUNT(*) AS veces_vendida
FROM Ventas ve
INNER JOIN Vehiculos v ON v.id_vehiculo = ve.id_vehiculo
GROUP BY v.marca
HAVING COUNT(*) = (
    SELECT MAX(conteo) FROM (
        SELECT COUNT(*) AS conteo
        FROM Ventas ve2
        INNER JOIN Vehiculos v2 ON v2.id_vehiculo = ve2.id_vehiculo
        GROUP BY v2.marca
    ) t
);
