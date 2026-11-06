# 📦 Gestión de Stock con SQL

Proyecto práctico de gestión de inventario desarrollado con **SQL (PostgreSQL)**. Permite organizar productos, categorías, proveedores y movimientos de stock, y consultar información útil para el seguimiento operativo.

> Proyecto de práctica y portfolio. Los datos incluidos son ficticios.

## 🎯 Objetivo
Practicar diseño de bases de datos relacionales, claves primarias y foráneas, restricciones, carga de datos y consultas SQL aplicadas a un escenario administrativo real.

## 🧰 Tecnologías
- PostgreSQL
- SQL
- Modelo relacional

## 📁 Archivos
| Archivo | Contenido |
|---|---|
| `schema.sql` | Creación de tablas, relaciones e índices |
| `datos_ejemplo.sql` | Datos ficticios para probar la base |
| `consultas.sql` | Consultas de stock, alertas, movimientos y reportes |

## 🚀 Cómo ejecutarlo
1. Instalá PostgreSQL y abrí pgAdmin o psql.
2. Creá una base de datos llamada `gestion_stock`.
3. Ejecutá `schema.sql`.
4. Ejecutá `datos_ejemplo.sql`.
5. Ejecutá las consultas de `consultas.sql` individualmente.

También podés ejecutar los archivos desde una terminal:

```bash
psql -U postgres -d gestion_stock -f schema.sql
psql -U postgres -d gestion_stock -f datos_ejemplo.sql
psql -U postgres -d gestion_stock -f consultas.sql
```

## 📊 Qué se puede analizar
- Existencias actuales por producto.
- Productos por debajo del stock mínimo.
- Valorización del inventario.
- Entradas y salidas por período.
- Productos y categorías con mayor movimiento.
- Historial de movimientos por producto.

## 🧠 Conceptos practicados
`CREATE TABLE`, `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `INSERT`, `SELECT`, `JOIN`, `GROUP BY`, `HAVING`, subconsultas, CTE y funciones de agregación.

## 🗺️ Mejoras futuras
- Incorporar vistas y procedimientos almacenados.
- Agregar control de usuarios y auditoría.
- Conectar la base con una interfaz web.

---
Hecho como proyecto de aprendizaje para practicar SQL aplicado a operaciones e inventario.
