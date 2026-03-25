# Diccionario de Datos — App_Impresiones (NeoPrint Studio)

## Tabla: `usuario`
Almacena los usuarios del sistema.

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, IDENTITY | Identificador único del usuario |
| nombre | VARCHAR(100) | NOT NULL | Nombre completo del usuario |
| email | VARCHAR(150) | NOT NULL, UNIQUE | Correo electrónico (usado para login) |
| password | VARCHAR(255) | NOT NULL | Contraseña del usuario |
| rol | VARCHAR(20) | DEFAULT 'cliente' | Rol: 'admin' o 'cliente' |
| fecha_registro | DATETIME | DEFAULT GETDATE() | Fecha de creación del usuario |

---

## Tabla: `categoria`
Clasifica los productos por tipo.

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, IDENTITY | Identificador único de la categoría |
| nombre | VARCHAR(50) | NOT NULL, UNIQUE | Nombre de la categoría (Gorra, Mug, etc.) |
| descripcion | VARCHAR(200) | | Descripción de la categoría |

---

## Tabla: `producto`
Almacena todos los productos disponibles en el catálogo.

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, IDENTITY | Identificador único del producto |
| nombre | VARCHAR(100) | NOT NULL | Nombre del producto |
| descripcion | VARCHAR(255) | | Descripción del producto |
| precio | DECIMAL(10,2) | NOT NULL | Precio del producto en pesos |
| stock | INT | NOT NULL, DEFAULT 0 | Cantidad disponible en inventario |
| imagen_url | VARCHAR(255) | | Ruta de la imagen del producto |
| id_categoria | INT | FK → categoria(id) | Categoría a la que pertenece |

---

## Tabla: `gorra`
Extiende la información de productos tipo Gorra (herencia).

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, FK → producto(id) | Referencia al producto padre |
| talla | VARCHAR(10) | NOT NULL | Talla de la gorra (Única, S, M, L) |
| color | VARCHAR(50) | NOT NULL | Color de la gorra |
| material | VARCHAR(50) | | Material de fabricación |

---

## Tabla: `mug`
Extiende la información de productos tipo Mug (herencia).

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, FK → producto(id) | Referencia al producto padre |
| capacidad_ml | INT | NOT NULL | Capacidad en mililitros |
| material | VARCHAR(50) | | Material (cerámica, vidrio, etc.) |
| color | VARCHAR(50) | NOT NULL | Color del mug |

---

## Tabla: `carrito`
Representa el carrito de compras activo de un usuario.

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, IDENTITY | Identificador único del carrito |
| id_usuario | INT | FK → usuario(id) | Usuario dueño del carrito |
| fecha_creacion | DATETIME | DEFAULT GETDATE() | Fecha de creación del carrito |
| estado | VARCHAR(20) | DEFAULT 'activo' | Estado: 'activo' o 'cerrado' |

---

## Tabla: `carrito_detalle`
Almacena los productos dentro de un carrito.

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, IDENTITY | Identificador único del detalle |
| id_carrito | INT | FK → carrito(id) | Carrito al que pertenece |
| id_producto | INT | FK → producto(id) | Producto agregado |
| cantidad | INT | NOT NULL, DEFAULT 1 | Cantidad del producto |
| precio_unitario | DECIMAL(10,2) | NOT NULL | Precio al momento de agregar |

---

## Tabla: `pedido`
Registra los pedidos realizados por los usuarios.

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, IDENTITY | Identificador único del pedido |
| id_usuario | INT | FK → usuario(id) | Usuario que realizó el pedido |
| fecha_pedido | DATETIME | DEFAULT GETDATE() | Fecha del pedido |
| total | DECIMAL(10,2) | NOT NULL | Valor total del pedido |
| estado | VARCHAR(20) | DEFAULT 'pendiente' | Estado: 'pendiente', 'pagado', 'enviado' |

---

## Tabla: `pedido_detalle`
Almacena los productos dentro de un pedido.

| Campo | Tipo | Restricción | Descripción |
|-------|------|-------------|-------------|
| id | INT | PK, IDENTITY | Identificador único del detalle |
| id_pedido | INT | FK → pedido(id) | Pedido al que pertenece |
| id_producto | INT | FK → producto(id) | Producto pedido |
| cantidad | INT | NOT NULL | Cantidad del producto |
| precio_unitario | DECIMAL(10,2) | NOT NULL | Precio al momento del pedido |

---

## Relaciones principales

| Tabla origen | Relación | Tabla destino | Descripción |
|---|---|---|---|
| usuario | 1:N | carrito | Un usuario puede tener varios carritos |
| usuario | 1:N | pedido | Un usuario puede tener varios pedidos |
| categoria | 1:N | producto | Una categoría clasifica muchos productos |
| producto | 1:1 | gorra | Un producto puede ser una gorra |
| producto | 1:1 | mug | Un producto puede ser un mug |
| carrito | 1:N | carrito_detalle | Un carrito contiene varios productos |
| pedido | 1:N | pedido_detalle | Un pedido contiene varios productos |
