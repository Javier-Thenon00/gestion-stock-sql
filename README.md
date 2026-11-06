# 📦 Gestión de Stock con SQL + Demo Web

Proyecto práctico de gestión de inventario que combina **SQL (PostgreSQL)** con una **demostración visual web** para mostrar cómo podría utilizarse un sistema de stock.

> Proyecto de aprendizaje y portfolio. Todos los productos, precios y movimientos son ficticios.

## 🌐 Demo visual

Podés abrir la demostración desde GitHub Pages:

**https://javier-thenon00.github.io/gestion-stock-sql/**

La demo permite:
- Consultar indicadores de inventario y valor estimado.
- Buscar productos y filtrar por categoría.
- Identificar productos con stock bajo o sin existencias.
- Agregar productos de ejemplo.
- Registrar entradas y salidas ajustando cantidades.
- Consultar el historial de movimientos.

**Importante:** la demo web funciona en el navegador y guarda los cambios en el almacenamiento local de ese navegador. No está conectada a PostgreSQL ni a un servidor. Los datos son de muestra y se pueden reiniciar borrando los datos del sitio desde el navegador.

## 🧰 Tecnologías

- PostgreSQL y SQL: modelo de datos, relaciones y consultas.
- HTML: estructura de la interfaz.
- CSS: diseño adaptable a computadora y celular.
- JavaScript: filtros, indicadores, altas y movimientos de demostración.
- GitHub Pages: publicación de la demo estática.

## 📁 Archivos

| Archivo | Contenido |
|---|---|
| `schema.sql` | Creación de tablas, relaciones e índices |
| `datos_ejemplo.sql` | Datos ficticios para probar la base |
| `consultas.sql` | Consultas de stock, alertas, movimientos y reportes |
| `index.html` | Interfaz de la demostración web |
| `styles.css` | Diseño visual adaptable |
| `app.js` | Interacciones y datos de ejemplo de la demo |

## 🚀 Cómo ejecutar la base SQL

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

## 🔎 Diferencia entre la demo y la base de datos

La web es una simulación de interfaz para que cualquier persona pueda explorar el proyecto sin instalar programas. La base PostgreSQL es el proyecto SQL real y se ejecuta localmente siguiendo los pasos anteriores. Actualmente no existe una conexión entre ambas partes.

---

Hecho como proyecto de aprendizaje para practicar SQL aplicado a operaciones e inventario.
