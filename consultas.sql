-- Consultas de práctica | PostgreSQL
-- Ejecutar cada consulta por separado o seleccionar todo el archivo.

-- 1. Ver todos los productos con su categoría.
SELECT p.sku, p.nombre, c.nombre AS categoria, p.stock_actual
FROM productos p
JOIN categorias c ON c.categoria_id = p.categoria_id
ORDER BY p.nombre;

-- 2. Productos que necesitan reposición.
SELECT sku, producto, stock_actual, stock_minimo, estado_stock
FROM vista_stock
WHERE estado_stock IN ('REPOSICION', 'SIN STOCK')
ORDER BY stock_actual ASC;

-- 3. Valor total del inventario por categoría.
SELECT categoria, SUM(valor_inventario) AS valor_total
FROM vista_stock
GROUP BY categoria
ORDER BY valor_total DESC;

-- 4. Cantidad de productos por categoría.
SELECT c.nombre AS categoria, COUNT(p.producto_id) AS cantidad_productos
FROM categorias c
LEFT JOIN productos p ON p.categoria_id = c.categoria_id AND p.activo = TRUE
GROUP BY c.nombre
ORDER BY cantidad_productos DESC;

-- 5. Historial de movimientos con nombre del producto.
SELECT m.fecha, p.sku, p.nombre, m.tipo, m.cantidad, m.motivo
FROM movimientos_stock m
JOIN productos p ON p.producto_id = m.producto_id
ORDER BY m.fecha DESC;

-- 6. Entradas y salidas totales por producto.
SELECT p.sku, p.nombre,
       SUM(CASE WHEN m.tipo = 'ENTRADA' THEN m.cantidad ELSE 0 END) AS total_entradas,
       SUM(CASE WHEN m.tipo = 'SALIDA' THEN m.cantidad ELSE 0 END) AS total_salidas
FROM productos p
LEFT JOIN movimientos_stock m ON m.producto_id = p.producto_id
GROUP BY p.sku, p.nombre
ORDER BY p.nombre;

-- 7. Productos cuyo precio de venta supera el promedio general.
SELECT sku, nombre, precio_venta
FROM productos
WHERE precio_venta > (SELECT AVG(precio_venta) FROM productos)
ORDER BY precio_venta DESC;

-- 8. Movimientos de los últimos 7 días.
SELECT p.nombre, m.tipo, m.cantidad, m.fecha
FROM movimientos_stock m
JOIN productos p ON p.producto_id = m.producto_id
WHERE m.fecha >= CURRENT_TIMESTAMP - INTERVAL '7 days'
ORDER BY m.fecha DESC;

-- 9. Ranking de productos con más unidades movidas.
SELECT p.nombre, SUM(m.cantidad) AS unidades_movidas
FROM movimientos_stock m
JOIN productos p ON p.producto_id = m.producto_id
GROUP BY p.nombre
ORDER BY unidades_movidas DESC
LIMIT 5;

-- 10. CTE: resumen de inventario por categoría.
WITH resumen AS (
    SELECT c.nombre AS categoria,
           COUNT(p.producto_id) AS productos,
           COALESCE(SUM(p.stock_actual), 0) AS unidades
    FROM categorias c
    LEFT JOIN productos p ON p.categoria_id = c.categoria_id AND p.activo = TRUE
    GROUP BY c.nombre
)
SELECT categoria, productos, unidades
FROM resumen
ORDER BY unidades DESC;

-- 11. Registrar una entrada de stock de ejemplo (transacción).
-- En un sistema real, el UPDATE y el INSERT deben ejecutarse juntos.
-- BEGIN;
-- UPDATE productos SET stock_actual = stock_actual + 10 WHERE sku = 'INF-002';
-- INSERT INTO movimientos_stock (producto_id, tipo, cantidad, motivo)
-- SELECT producto_id, 'ENTRADA', 10, 'Reposición de ejemplo'
-- FROM productos WHERE sku = 'INF-002';
-- COMMIT;
