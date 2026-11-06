-- Datos ficticios de prueba. Ejecutar después de schema.sql.

INSERT INTO categorias (nombre, descripcion) VALUES
('Informática', 'Periféricos y accesorios'),
('Librería', 'Insumos de oficina'),
('Mobiliario', 'Muebles y equipamiento');

INSERT INTO proveedores (nombre, email, telefono) VALUES
('Distribuidora Centro', 'ventas@ejemplo.com', '11-4000-1000'),
('Insumos del Sur', 'pedidos@ejemplo.com', '11-4000-2000'),
('Equipamientos Delta', 'contacto@ejemplo.com', '11-4000-3000');

INSERT INTO productos
(sku, nombre, categoria_id, proveedor_id, precio_costo, precio_venta, stock_actual, stock_minimo)
VALUES
('INF-001', 'Mouse inalámbrico', 1, 1, 8500, 12500, 24, 8),
('INF-002', 'Teclado USB', 1, 1, 12000, 17500, 5, 10),
('INF-003', 'Monitor 24 pulgadas', 1, 3, 95000, 129000, 7, 3),
('LIB-001', 'Resma A4', 2, 2, 6500, 8900, 40, 12),
('LIB-002', 'Marcadores x 12', 2, 2, 4200, 6200, 0, 5),
('MOB-001', 'Silla ergonómica', 3, 3, 78000, 109000, 4, 2);

INSERT INTO movimientos_stock (producto_id, tipo, cantidad, motivo, fecha) VALUES
(1, 'ENTRADA', 30, 'Carga inicial', CURRENT_TIMESTAMP - INTERVAL '12 days'),
(1, 'SALIDA', 6, 'Entrega a sector administrativo', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(2, 'ENTRADA', 8, 'Reposición de proveedor', CURRENT_TIMESTAMP - INTERVAL '8 days'),
(2, 'SALIDA', 3, 'Entrega a usuarios', CURRENT_TIMESTAMP - INTERVAL '2 days'),
(3, 'ENTRADA', 7, 'Carga inicial', CURRENT_TIMESTAMP - INTERVAL '10 days'),
(4, 'ENTRADA', 50, 'Compra mensual', CURRENT_TIMESTAMP - INTERVAL '6 days'),
(4, 'SALIDA', 10, 'Consumo interno', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(5, 'SALIDA', 5, 'Consumo interno', CURRENT_TIMESTAMP - INTERVAL '3 days'),
(6, 'ENTRADA', 4, 'Carga inicial', CURRENT_TIMESTAMP - INTERVAL '9 days');
