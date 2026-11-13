-- Quiz #5 SQL - CE 2103 - II Semestre 2026
-- Script de consultas de MiAutoPuntoCom
USE MiAutoPuntoCom;

DROP DATABASE IF EXISTS MiAutoPuntoCom;
CREATE DATABASE MiAutoPuntoCom CHARACTER SET utf8mb4 COLLATE utf8mb4    _unicode_ci;
USE MiAutoPuntoCom;


-- Tabla Vehiculos

CREATE TABLE Vehiculos (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    marca       VARCHAR(50)  NOT NULL,
    modelo      VARCHAR(50)  NOT NULL,
    anio        SMALLINT     NOT NULL,
    color       VARCHAR(30)  NOT NULL,
    precio      DECIMAL(12,2) NOT NULL,
    vin         CHAR(17)     NOT NULL,
    tipo        ENUM('sedan','SUV','camioneta','hatchback','coupe','otro') NOT NULL,
    estado      ENUM('nuevo','usado') NOT NULL,
    CONSTRAINT uq_vehiculos_vin UNIQUE (vin),
    CONSTRAINT ck_vehiculos_precio CHECK (precio > 0),
    CONSTRAINT ck_vehiculos_anio CHECK (anio BETWEEN 1980 AND 2100)
);

-- Tabla Clientes

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre     VARCHAR(50)  NOT NULL,
    apellido   VARCHAR(50)  NOT NULL,
    cedula     VARCHAR(20)  NOT NULL,
    telefono   VARCHAR(20)  NOT NULL,
    email      VARCHAR(100) NOT NULL,
    direccion  VARCHAR(200) NOT NULL,
    CONSTRAINT uq_clientes_cedula UNIQUE (cedula),
    CONSTRAINT uq_clientes_email UNIQUE (email)
);
-- Tabla Vendedores
CREATE TABLE Vendedores (
    id_vendedor        INT AUTO_INCREMENT PRIMARY KEY,
    nombre             VARCHAR(50) NOT NULL,
    apellido           VARCHAR(50) NOT NULL,
    cedula             VARCHAR(20) NOT NULL,
    fecha_contratacion DATE        NOT NULL,
    comision_porcentual DECIMAL(5,2) NOT NULL,
    CONSTRAINT uq_vendedores_cedula UNIQUE (cedula),
    CONSTRAINT ck_vendedores_comision CHECK (comision_porcentual BETWEEN 0 AND 100)
);


-- Tabla Ventas 
CREATE TABLE Ventas (
    id_venta     INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo  INT  NOT NULL,
    id_cliente   INT  NOT NULL,
    id_vendedor  INT  NOT NULL,
    fecha_venta  DATE NOT NULL,
    precio_final DECIMAL(12,2) NOT NULL,
    metodo_pago  ENUM('efectivo','financiamiento','tarjeta') NOT NULL,
    CONSTRAINT uq_ventas_vehiculo UNIQUE (id_vehiculo),  -- un vehículo se vende una sola vez
    CONSTRAINT ck_ventas_precio CHECK (precio_final > 0),
    CONSTRAINT fk_ventas_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ventas_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ventas_vendedor FOREIGN KEY (id_vendedor) REFERENCES Vendedores(id_vendedor)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
