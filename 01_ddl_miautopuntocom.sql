
-- Quiz #5 SQL - CE 2103 - II Semestre 2026
-- Script DDL: base de datos, tablas y restricciones (Partes 1 y 2)

DROP DATABASE IF EXISTS MiAutoPuntoCom;
CREATE DATABASE MiAutoPuntoCom CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE MiAutoPuntoCom;

-- Tabla Vehiculos
CREATE TABLE Vehiculos (
    id_vehiculo INT AUTO_INCREMENT,
    marca       VARCHAR(50)   NOT NULL,
    modelo      VARCHAR(50)   NOT NULL,
    anio        SMALLINT      NOT NULL,
    color       VARCHAR(30)   NOT NULL,
    precio      DECIMAL(14,2) NOT NULL,   -- en colones (₡)
    vin         CHAR(17)      NOT NULL,
    tipo        VARCHAR(30)   NOT NULL,   -- sedán, SUV, camioneta, etc.
    estado      VARCHAR(10)   NOT NULL,   -- 'Nuevo' o 'Usado'
    CONSTRAINT pk_vehiculos PRIMARY KEY (id_vehiculo),
    CONSTRAINT uq_vehiculos_vin UNIQUE (vin),
    -- Año entre 1900 y el año actual (MySQL no permite YEAR(CURDATE()) en un CHECK,
    -- el límite superior lo controla el trigger de abajo)
    CONSTRAINT ck_vehiculos_anio CHECK (anio >= 1900),
    CONSTRAINT ck_vehiculos_precio CHECK (precio > 0),
    CONSTRAINT ck_vehiculos_estado CHECK (estado IN ('Nuevo', 'Usado'))
);

-- Triggers: el año del vehículo no puede ser mayor al año actual
DELIMITER //
CREATE TRIGGER trg_vehiculos_anio_ins BEFORE INSERT ON Vehiculos
FOR EACH ROW
BEGIN
    IF NEW.anio > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El año del vehículo no puede ser mayor al año actual';
    END IF;
END//

CREATE TRIGGER trg_vehiculos_anio_upd BEFORE UPDATE ON Vehiculos
FOR EACH ROW
BEGIN
    IF NEW.anio > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El año del vehículo no puede ser mayor al año actual';
    END IF;
END//
DELIMITER ;

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT,
    nombre     VARCHAR(50)  NOT NULL,
    apellido   VARCHAR(50)  NOT NULL,
    cedula     VARCHAR(20)  NOT NULL,
    telefono   VARCHAR(20)  NOT NULL,
    email      VARCHAR(100) NOT NULL,
    direccion  VARCHAR(200) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (id_cliente),
    CONSTRAINT uq_clientes_cedula UNIQUE (cedula),
    CONSTRAINT uq_clientes_email UNIQUE (email)
);
-- Tabla Vendedores

CREATE TABLE Vendedores (
    id_vendedor         INT AUTO_INCREMENT,
    nombre              VARCHAR(50)  NOT NULL,
    apellido            VARCHAR(50)  NOT NULL,
    cedula              VARCHAR(20)  NOT NULL,
    fecha_nacimiento    DATE         NOT NULL,
    fecha_contratacion  DATE         NOT NULL,
    comision_porcentual DECIMAL(5,2) NOT NULL,
    CONSTRAINT pk_vendedores PRIMARY KEY (id_vendedor),
    CONSTRAINT uq_vendedores_cedula UNIQUE (cedula),
    CONSTRAINT ck_vendedores_comision CHECK (comision_porcentual BETWEEN 0 AND 20),
    -- No pueden ser menores de 21 años (edad al momento de la contratación)
    CONSTRAINT ck_vendedores_edad CHECK (fecha_nacimiento <= DATE_SUB(fecha_contratacion, INTERVAL 21 YEAR))
);

-- Tabla Ventas 
CREATE TABLE Ventas (
    id_venta     INT AUTO_INCREMENT,
    id_vehiculo  INT           NOT NULL,
    id_cliente   INT           NOT NULL,
    id_vendedor  INT           NOT NULL,
    fecha_venta  DATE          NOT NULL,
    precio_final DECIMAL(14,2) NOT NULL,   -- en colones (₡)
    metodo_pago  VARCHAR(20)   NOT NULL,
    CONSTRAINT pk_ventas PRIMARY KEY (id_venta),
    CONSTRAINT uq_ventas_vehiculo UNIQUE (id_vehiculo),   -- un vehículo se vende una sola vez
    CONSTRAINT ck_ventas_precio CHECK (precio_final > 0),
    CONSTRAINT ck_ventas_metodo CHECK (metodo_pago IN ('efectivo', 'financiamiento', 'tarjeta')),
    CONSTRAINT fk_ventas_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ventas_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ventas_vendedor FOREIGN KEY (id_vendedor) REFERENCES Vendedores(id_vendedor)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
