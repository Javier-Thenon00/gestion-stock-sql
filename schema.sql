-- Gestión de Stock | PostgreSQL
-- Ejecutar sobre una base vacía llamada gestion_stock.

CREATE TABLE categorias (
    categoria_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    descripcion VARCHAR(250)
);

CREATE TABLE proveedores (
    proveedor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    email VARCHAR(150),
    telefono VARCHAR(40),
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE productos (
    producto_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sku VARCHAR(30) NOT NULL UNIQUE,
    nombre VARCHAR(120) NOT NULL,
    categoria_id INTEGER NOT NULL REFERENCES categorias(categoria_id),
    proveedor_id INTEGER REFERENCES proveedores(proveedor_id),
    precio_costo NUMERIC(12,2) NOT NULL CHECK (precio_costo >= 0),
    precio_venta NUMERIC(12,2) NOT NULL CHECK (precio_venta >= 0),
    stock_actual INTEGER NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo INTEGER NOT NULL DEFAULT 0 CHECK (stock_minimo >= 0),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (precio_venta >= precio_costo)
);

CREATE TABLE movimientos_stock (
    movimiento_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    producto_id INTEGER NOT NULL REFERENCES productos(producto_id),
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('ENTRADA', 'SALIDA')),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    motivo VARCHAR(180) NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observaciones VARCHAR(300)
);

CREATE INDEX idx_productos_categoria ON productos(categoria_id);
CREATE INDEX idx_movimientos_producto_fecha ON movimientos_stock(producto_id, fecha DESC);
CREATE INDEX idx_movimientos_fecha ON movimientos_stock(fecha);

-- Vista para consultar el estado del inventario.
CREATE VIEW vista_stock AS
SELECT
    p.producto_id,
    p.sku,
    p.nombre AS producto,
    c.nombre AS categoria,
    p.stock_actual,
    p.stock_minimo,
    p.precio_costo,
    p.precio_venta,
    p.stock_actual * p.precio_costo AS valor_inventario,
    CASE
        WHEN p.stock_actual = 0 THEN 'SIN STOCK'
        WHEN p.stock_actual <= p.stock_minimo THEN 'REPOSICION'
        ELSE 'STOCK OK'
    END AS estado_stock
FROM productos p
JOIN categorias c ON c.categoria_id = p.categoria_id
WHERE p.activo = TRUE;
