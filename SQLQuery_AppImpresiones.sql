-- ============================================
-- BASE DE DATOS: App_Impresiones - NeoPrint Studio
-- Autor: Erika Ramírez
-- Fecha: 2026
-- ============================================

CREATE DATABASE AppImpresiones;
GO

USE AppImpresiones;
GO

-- ============================================
-- TABLA: usuario
-- ============================================
CREATE TABLE usuario (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    nombre      VARCHAR(100)  NOT NULL,
    email       VARCHAR(150)  NOT NULL UNIQUE,
    password    VARCHAR(255)  NOT NULL,
    rol         VARCHAR(20)   NOT NULL DEFAULT 'cliente',
    fecha_registro DATETIME   DEFAULT GETDATE()
);

-- ============================================
-- TABLA: categoria
-- ============================================
CREATE TABLE categoria (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    nombre      VARCHAR(50)   NOT NULL UNIQUE,
    descripcion VARCHAR(200)
);

-- ============================================
-- TABLA: producto
-- ============================================
CREATE TABLE producto (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    nombre      VARCHAR(100)  NOT NULL,
    descripcion VARCHAR(255),
    precio      DECIMAL(10,2) NOT NULL,
    stock       INT           NOT NULL DEFAULT 0,
    imagen_url  VARCHAR(255),
    id_categoria INT,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria)
        REFERENCES categoria(id)
);

-- ============================================
-- TABLA: gorra (hereda de producto)
-- ============================================
CREATE TABLE gorra (
    id          INT PRIMARY KEY,
    talla       VARCHAR(10)   NOT NULL,
    color       VARCHAR(50)   NOT NULL,
    material    VARCHAR(50),
    CONSTRAINT fk_gorra_producto FOREIGN KEY (id)
        REFERENCES producto(id)
);

-- ============================================
-- TABLA: mug (hereda de producto)
-- ============================================
CREATE TABLE mug (
    id          INT PRIMARY KEY,
    capacidad_ml INT          NOT NULL,
    material    VARCHAR(50),
    color       VARCHAR(50)   NOT NULL,
    CONSTRAINT fk_mug_producto FOREIGN KEY (id)
        REFERENCES producto(id)
);

-- ============================================
-- TABLA: carrito
-- ============================================
CREATE TABLE carrito (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario  INT           NOT NULL,
    fecha_creacion DATETIME   DEFAULT GETDATE(),
    estado      VARCHAR(20)   DEFAULT 'activo',
    CONSTRAINT fk_carrito_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id)
);

-- ============================================
-- TABLA: carrito_detalle
-- ============================================
CREATE TABLE carrito_detalle (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    id_carrito  INT           NOT NULL,
    id_producto INT           NOT NULL,
    cantidad    INT           NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_detalle_carrito FOREIGN KEY (id_carrito)
        REFERENCES carrito(id),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto)
        REFERENCES producto(id)
);

-- ============================================
-- TABLA: pedido
-- ============================================
CREATE TABLE pedido (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario  INT           NOT NULL,
    fecha_pedido DATETIME     DEFAULT GETDATE(),
    total       DECIMAL(10,2) NOT NULL,
    estado      VARCHAR(20)   DEFAULT 'pendiente',
    CONSTRAINT fk_pedido_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id)
);

-- ============================================
-- TABLA: pedido_detalle
-- ============================================
CREATE TABLE pedido_detalle (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido   INT           NOT NULL,
    id_producto INT           NOT NULL,
    cantidad    INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_pedido_det_pedido FOREIGN KEY (id_pedido)
        REFERENCES pedido(id),
    CONSTRAINT fk_pedido_det_producto FOREIGN KEY (id_producto)
        REFERENCES producto(id)
);

-- ============================================
-- DATOS DE PRUEBA
-- ============================================

-- Categorías
INSERT INTO categoria (nombre, descripcion) VALUES
('Gorra',     'Gorras personalizadas'),
('Mug',       'Mugs y tazas personalizadas'),
('Camiseta',  'Camisetas estampadas'),
('Sudadera',  'Sudaderas personalizadas'),
('Agenda',    'Agendas ejecutivas'),
('Boligrafo', 'Bolígrafos metálicos'),
('Llavero',   'Llaveros acrílicos'),
('Termo',     'Termos térmicos'),
('Bolsa',     'Bolsas ecológicas'),
('PopSocket', 'PopSockets estampados');

-- Productos
INSERT INTO producto (nombre, descripcion, precio, stock, imagen_url, id_categoria) VALUES
('Gorra básica',          'Gorra con bordado personalizado',     25000.00, 50, 'imagenes/gorra.roja.jpg',  1),
('Mug personalizado',     'Taza con diseño a elección',          18000.00, 30, 'imagenes/mugs.jpg',        2),
('Camiseta estampada',    'Camiseta 100% algodón con estampado', 35000.00, 40, NULL,                       3),
('Sudadera con capucha',  'Sudadera personalizada',              60000.00, 20, NULL,                       4),
('Agenda ejecutiva',      'Agenda con logo empresarial',         22000.00, 25, NULL,                       5),
('Bolígrafo metálico',    'Bolígrafo con grabado láser',          8000.00, 100, NULL,                      6),
('Llavero acrílico',      'Llavero con foto personalizada',       5000.00, 80, NULL,                       7),
('Termo térmico',         'Termo de acero inoxidable',           45000.00, 15, NULL,                       8),
('Bolsa ecológica',       'Bolsa reutilizable con diseño',       12000.00, 60, NULL,                       9),
('PopSocket estampado',   'PopSocket con diseño personalizado',  15000.00, 70, NULL,                       10);

-- Gorras
INSERT INTO gorra (id, talla, color, material) VALUES
(1, 'Única', 'Rojo', 'Algodón');

-- Mugs
INSERT INTO mug (id, capacidad_ml, material, color) VALUES
(2, 350, 'Cerámica', 'Blanco');

-- Usuarios
INSERT INTO usuario (nombre, email, password, rol) VALUES
('Erika Ramírez', 'erika@mail.com', '1234', 'admin'),
('Cliente Prueba', 'cliente@mail.com', '1234', 'cliente');

-- ============================================
-- CONSULTA: verificar duplicados (original)
-- ============================================
SELECT nombre, COUNT(*) 
FROM producto
GROUP BY nombre
HAVING COUNT(*) > 1;
